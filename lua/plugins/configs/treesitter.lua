-- CDS Custom Parser
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.cds = {
				install_info = {
					-- local path or git repo
					url = "https://github.com/cap-js-community/tree-sitter-cds.git",
					-- url = "/path/to/tree-sitter-cds",
					branch = "main",
					files = { "src/parser.c", "src/scanner.c" },
				},
				filetype = "cds", -- if filetype does not match the parser name
			}

local options = {
  ensure_installed = { "lua", "vim", "vimdoc", "query" },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

return options
