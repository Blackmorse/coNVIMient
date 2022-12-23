--- A little bit more generic method of setting the keymaps
--- For mode, lhs and buffer arrays can be passed,
--- therefore for each buffer, mode and lhs keymap will be set
--- passing empty buffer will create a "global" keymap. Passing
--- buffer zero to the array will apply for the current buffer
---
--- See https://neovim.io/doc/user/lua.html#vim.keymap.set()
--- @param modes string | table - single or array of vim modes
--- @param lhss string | table - single lhs or array of lhs
--- @param func function - lua function to be applied
--- @param opts table - see the docs https://neovim.io/doc/user/lua.html#vim.keymap.set()
--- @param buffers number | table - empty, single or array of buffers. If empty global mapping
--- will be set.
local function vim_keymap_set(modes, lhss, func, opts, buffers)
    buffers = buffers or {}
    local buffer_table = type(buffers) == "table" and buffers or { buffers }
    local lhss_table = type(lhss) == "table" and lhss or { lhss }

    for _, lhs in pairs(lhss_table) do
        if #buffers == 0 then
            vim.keymap.set(modes, lhs, func, opts)
        else
            for _, buffer in pairs(buffer_table) do
                local opts_copy = {}
                for k,v in pairs(opts) do opts_copy[k] = v end
                opts_copy['buffer'] = buffer
                vim.keymap.set(modes, lhs, func, opts_copy)
            end
        end
    end
end

--- Expanding array of buffest for creating nvim autocommands
---
--- See https://neovim.io/doc/user/api.html#nvim_create_autocmd()
---@param events table
---@param opts table
---@param buffers table | number
local function vim_create_autocmd(events, opts, buffers)
    buffers = buffers or {}
    local buffer_table = type(buffers) == "table" and buffers or { buffers }
    if #buffers == 0 then
        vim.api.nvim_create_autocmd(events, opts)
    else
        for _, buffer in pairs(buffer_table) do
            local opts_clone = {}
            for k,v in pairs(opts) do opts_clone[k] = v end
            opts_clone['buffer'] = buffer
            vim.api.nvim_create_autocmd(events, opts_clone)
        end
    end
end

return {
    vim_keymap_set = vim_keymap_set,
    vim_create_autocmd = vim_create_autocmd
}
