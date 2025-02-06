-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- CDS LSP
		local configs = require("lspconfig.configs")
		if not configs.cds_lsp then
			configs.cds_lsp = {
				default_config = {
					cmd = {
						vim.fn.expand("cds-lsp"),
						"--stdio",
					},
					filetypes = { "cds" },
					root_dir = lspconfig.util.root_pattern(".git", "package.json"),
					settings = {},
				},
			}
		end

-- Mappings & attach
		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- keybindings
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gD", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- Show LSP implmentations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, opts) -- show available code actions

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", function()
				vim.lsp.buf.rename()
			end, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0", opts) -- show diagnostics for current buffer

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", function()
				vim.diagnostic.open_float()
			end, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", function()
				vim.diagnostic.goto_prev()
			end, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", function()
				vim.diagnostic.goto_next()
			end, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation under cursor"
			keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- restart LSP in case of emergency
		end

		-- used to enable autocompletion (assigned to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the diagnostic symbols in the sign column (aka. gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

    if lspconfig["cds_lsp"].setup then
			lspconfig["cds_lsp"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end
