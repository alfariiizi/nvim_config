# Alfarizi's Neovim Configuration

Welcome to my personal Neovim configuration repository, which is a fork of [kickstart.nvim](https://github.com/yourforkedrepo/kickstart.nvim). This setup is tailored to enhance the development experience, particularly for web developers using ReactJS, NextJS, and TailwindCSS, and is optimized for use with the Kitty terminal emulator or Wezterm terminal emulator.

## Prerequisites

Before you start using this configuration, ensure you have Neovim installed on your system. You can download and install Neovim from [Neovim's official website](https://neovim.io/).

## Installation

To use this configuration, follow these steps:

1. Clone this repository into your Neovim configuration directory:

   ```bash
   git clone https://github.com/yourusername/your-repo-name.git ~/.config/nvim
   ```

2. Open Neovim and install the plugins with lazy.nvim:

   ```plaintext
   nvim
   :LazySync
   ```

## Features

- Enhanced Key Bindings: Custom key mappings for more efficient coding and navigation.
- Plugin Management: Uses lazy.nvim for efficient and lazy loading of plugins, enhancing startup times and performance.
- UI Improvements: Integration with Kitty for a seamless terminal experience, and tailored UI enhancements using themes suitable for extended coding sessions.
- Language Support: Optimized for TypeScript, with additional configurations for better syntax highlighting and error detection.

## Custom Key Bindings

Here are some of the custom key bindings set up in this configuration:

- `<leader> + n`: Open NERDTree for file exploration.
- `<leader> + f`: Search for files using FZF.

I use `<space>` as leader key.

## Contributing

Contributions are always welcome! If you have any suggestions or improvements, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](/LICENSE.md) file for details.

## Acknowledgments

- Thanks to the contributors of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), whose work formed the basis of this configuration.
- Thanks to everyone in the Neovim community; your tools and scripts have been incredibly helpful in building this configuration.
