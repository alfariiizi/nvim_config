-- kubernetes-utils.lua
-- Plugin to apply Kubernetes resources directly from current buffer

local M = {}

-- Configuration with defaults
M.config = {
  kubectl_path = 'kubectl',
  kubens_path = 'kubens', -- Path to kubens executable
  default_namespace = 'default', -- Default namespace if not specified
  show_output = true, -- Whether to show command output
  output_split_size = 10, -- Height of output split window
  k9s_path = 'k9s', -- Path to k9s executable
  keymaps = {
    apply = '<leader>ka', -- Apply current buffer
    delete = '<leader>kD', -- Delete resource in current buffer
    get = '<leader>kg', -- Get resource info
    describe = '<leader>kd', -- Describe resource
    logs = '<leader>kl', -- Get logs for resource
    switch_ns = '<leader>kn', -- Switch namespace
    open_k9s = '<leader>k9', -- Open k9s
  },
}

-- Get the current namespace using kubens
local function get_namespace()
  -- Try to get current namespace using kubens
  local cmd = M.config.kubens_path .. ' -c'
  local handle = io.popen(cmd)

  if not handle then
    vim.notify('Failed to execute kubens. Using default namespace.', vim.log.levels.WARN)
    return M.config.default_namespace
  end

  local result = handle:read '*a'
  handle:close()

  -- Remove any trailing whitespace or newlines
  result = result:gsub('%s+$', '')

  if result and result ~= '' then
    return result
  end

  return M.config.default_namespace
end

-- Extract resource kind and name from buffer content
local function extract_resource_info()
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local yaml_content = table.concat(content, '\n')

  -- Basic pattern matching to extract kind and name
  local kind = yaml_content:match 'kind:%s*([%w]+)'
  local name = yaml_content:match 'name:%s*([%w%-%.]+)'

  if not kind or not name then
    return nil
  end

  return {
    kind = kind:lower(),
    name = name,
  }
end

-- Execute kubectl command and show output
local function kubectl_exec(cmd, args, callback)
  local full_cmd = M.config.kubectl_path .. ' ' .. cmd

  -- Add namespace if not specified in args
  if not string.find(args or '', ' -n ') and not string.find(args or '', ' --namespace') then
    local namespace = get_namespace()
    full_cmd = full_cmd .. ' -n ' .. namespace
  end

  -- Add other arguments
  if args and args ~= '' then
    full_cmd = full_cmd .. ' ' .. args
  end

  -- Show command being executed
  vim.notify('Executing: ' .. full_cmd, vim.log.levels.INFO)

  -- Execute the command
  vim.fn.jobstart(full_cmd, {
    on_stdout = function(_, data)
      if callback then
        callback(data)
      elseif M.config.show_output and data and #data > 1 then
        -- Create or use output buffer
        local bufnr = vim.fn.bufnr 'K8sOutput'
        if bufnr == -1 then
          vim.cmd('botright ' .. M.config.output_split_size .. 'new K8sOutput')
          bufnr = vim.fn.bufnr 'K8sOutput'
          vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile')
          vim.api.nvim_buf_set_option(bufnr, 'swapfile', false)
          vim.api.nvim_buf_set_option(bufnr, 'filetype', 'yaml')
        else
          -- Clear existing content
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
        end

        -- Add the output
        vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, data)
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 1 then
        vim.notify(table.concat(data, '\n'), vim.log.levels.ERROR)
      end
    end,
  })
end

-- Apply current buffer to Kubernetes
function M.apply_buffer()
  -- Get buffer content
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Create temporary file
  local temp_file = vim.fn.tempname() .. '.yaml'
  vim.fn.writefile(content, temp_file)

  -- Apply the file
  kubectl_exec('apply', '-f ' .. temp_file, function(_)
    vim.notify('Resource applied successfully', vim.log.levels.INFO)
    -- Remove the temporary file
    vim.fn.delete(temp_file)
  end)
end

-- Delete resource from current buffer
function M.delete_resource()
  local resource = extract_resource_info()
  if not resource then
    vim.notify('Could not determine resource kind and name', vim.log.levels.ERROR)
    return
  end

  kubectl_exec('delete', resource.kind .. ' ' .. resource.name, function(_)
    vim.notify('Resource deleted: ' .. resource.kind .. '/' .. resource.name, vim.log.levels.INFO)
  end)
end

-- Get resource described in current buffer
function M.get_resource()
  local resource = extract_resource_info()
  if not resource then
    vim.notify('Could not determine resource kind and name', vim.log.levels.ERROR)
    return
  end

  kubectl_exec('get', resource.kind .. ' ' .. resource.name .. ' -o yaml')
end

-- Describe resource in current buffer
function M.describe_resource()
  local resource = extract_resource_info()
  if not resource then
    vim.notify('Could not determine resource kind and name', vim.log.levels.ERROR)
    return
  end

  kubectl_exec('describe', resource.kind .. ' ' .. resource.name)
end

-- Get logs for pod in current buffer
function M.get_logs()
  local resource = extract_resource_info()
  if not resource then
    vim.notify('Could not determine resource kind and name', vim.log.levels.ERROR)
    return
  end

  if resource.kind ~= 'pod' and resource.kind ~= 'pods' then
    vim.notify('Logs can only be fetched for pods', vim.log.levels.ERROR)
    return
  end

  kubectl_exec('logs', resource.name)
end

-- Switch namespace using kubens
function M.switch_namespace()
  -- Get list of namespaces
  kubectl_exec('get', 'namespaces -o name', function(data)
    local namespaces = {}
    for _, line in ipairs(data) do
      if line ~= '' then
        local ns = line:gsub('namespace/', '')
        if ns ~= '' then
          table.insert(namespaces, ns)
        end
      end
    end

    -- Use vim.ui.select to let user choose namespace
    vim.ui.select(namespaces, {
      prompt = 'Select Kubernetes namespace:',
      format_item = function(item)
        return item
      end,
    }, function(choice)
      if choice then
        -- Use kubens to switch namespace
        vim.fn.system(M.config.kubens_path .. ' ' .. choice)
        vim.notify('Switched to namespace: ' .. choice, vim.log.levels.INFO)
      end
    end)
  end)
end

-- Open k9s in terminal
function M.open_k9s()
  local namespace = get_namespace()
  vim.cmd('terminal ' .. M.config.k9s_path .. ' -n ' .. namespace)
end

-- Setup function
function M.setup(opts)
  -- Merge user config with defaults
  M.config = vim.tbl_deep_extend('force', M.config, opts or {})

  -- Set up keymappings
  local keymaps = M.config.keymaps
  vim.keymap.set('n', keymaps.apply, M.apply_buffer, { desc = 'K8s: Apply buffer' })
  vim.keymap.set('n', keymaps.delete, M.delete_resource, { desc = 'K8s: Delete resource' })
  vim.keymap.set('n', keymaps.get, M.get_resource, { desc = 'K8s: Get resource' })
  vim.keymap.set('n', keymaps.describe, M.describe_resource, { desc = 'K8s: Describe resource' })
  vim.keymap.set('n', keymaps.logs, M.get_logs, { desc = 'K8s: Get logs' })
  vim.keymap.set('n', keymaps.switch_ns, M.switch_namespace, { desc = 'K8s: Switch namespace' })
  vim.keymap.set('n', keymaps.open_k9s, M.open_k9s, { desc = 'K8s: Open k9s' })

  -- Create user commands
  vim.api.nvim_create_user_command('KubeApply', M.apply_buffer, {})
  vim.api.nvim_create_user_command('KubeDelete', M.delete_resource, {})
  vim.api.nvim_create_user_command('KubeGet', M.get_resource, {})
  vim.api.nvim_create_user_command('KubeDescribe', M.describe_resource, {})
  vim.api.nvim_create_user_command('KubeLogs', M.get_logs, {})
  vim.api.nvim_create_user_command('KubeNamespace', M.switch_namespace, {})
  vim.api.nvim_create_user_command('KubeK9s', M.open_k9s, {})
end

return M
