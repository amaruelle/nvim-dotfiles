require("config.lazy")
require("core.keymaps")
vim.wo.number = true
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "palenight",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
require("neo-tree").setup({
	source_selector = {
		winbar = true,
		statusline = false,
	},
})
require("mason").setup()

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "python-lsp-server" },
		markdown = { "markdown-oxide" },
	},
})
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
vim.api.nvim_set_keymap('', '<C-f>', ':Neotree toggle<CR>', { noremap = true, silent = true })
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,      
      override_generic_sorter = true, 
      override_file_sorter = true,      
      case_mode = "smart_case",    }
  }
}
require('telescope').load_extension('fzf')
require('gitsigns').setup()
