# coNVIMient
Yet another library for simplifying the usage of the <b>Lua Neovim API</b>.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [vim_keymap_set](#vim_keymap_set)
  - [vim_create_autocmd](#vim_create_autocmd)

### Installation

<b>packer</b>

To install coNVIMient, add the following line to your <i>init</i> file:

```lua
use({ "Blackmorse/coNVIMient.nvim" })

````

### Usage
coNVIMient offers the following functions:

#### vim_keymap_set
This function allows you to pass arrays of parameters to Neovim's nvim_create_autocmd function.

Here is an example of usage:
```lua
require('coNVIMient').vim_keymap_set(
	{'i', 'n', 't'}, --modes
	{ 'q', '<C-c>', '<esc><esc>' }, --lhs
	function() print("I'm closing!") end, 
	{ nowait = true, noremap = true, silent = true }, --opts
	{ buffer1, buffer2, 0 }) -- buffers
```

Instead of iterating through tables for modes, lhs and 'buffers', you can pass them directly to the vim_keymap_set function. The parameters correspond to the original nvim_create_autocmd function, with the exception of the buffer opt which should be passed separately.

For more information on `nvim_create_autocmd`, see the [Neovim API documentation](https://neovim.io/doc/user/api.html#nvim_create_autocmd())

#### vim_create_autocmd
This fuction allows you to create an autocmd in Neovim in the same manner, by expanding the arrays of passed buffers.

Here is an example of usage:

```lua
require('coNVIMient').vim_create_autocmd(
        { 'BufWritePre', 'BufEnter' },  -- events
        { nowait = true, noremap = true, silent = true, callback = function() print("Here is an autocmd") },  -- opts
        { buffer1, buffer2, 0 })  -- buffers
```

The parameters correspond to the original nvim_create_autocmd function, with the exception of the `buffer` opt which should be passed separately.

For more information on `nvim_create_autocmd`, see the Neovim API documentation.
