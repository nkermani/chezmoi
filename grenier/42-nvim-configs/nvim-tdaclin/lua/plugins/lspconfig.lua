return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	config = function()
		local lspservers = { "clangd", "pyright", "rust_analyzer", "nixd", "ts_ls", "eslint", "tailwindcss" }

		on_attach = function(client, bufnr)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
			vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = bufnr })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
			vim.keymap.set("n", "<leader>cK", vim.lsp.buf.signature_help, { buffer = bufnr })
			vim.keymap.set("n", "<leader>cs", vim.lsp.buf.document_symbol, { buffer = bufnr })
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.document_highlight, { buffer = bufnr })
			vim.keymap.set("n", "<leader>cH", vim.lsp.buf.clear_references, { buffer = bufnr })
			vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ }) end, { buffer = bufnr }) -- TODO: view options (async, formating_options, bufnr)
		end

		on_detach = function(client, bufnr)
			vim.keymap.del("n", "K", { buffer = bufnr })
			vim.keymap.del("n", "gd", { buffer = bufnr })
			vim.keymap.del("n", "gD", { buffer = bufnr })
			vim.keymap.del("n", "gy", { buffer = bufnr })
			vim.keymap.del("n", "gi", { buffer = bufnr })
			vim.keymap.del("n", "gr", { buffer = bufnr })
			vim.keymap.del("n", "<leader>cK", { buffer = bufnr })
			vim.keymap.del("n", "<leader>cs", { buffer = bufnr })
			vim.keymap.del("n", "<leader>cr", { buffer = bufnr })
			vim.keymap.del("n", "<leader>ca", { buffer = bufnr })
			vim.keymap.del("n", "<leader>ch", { buffer = bufnr })
			vim.keymap.del("n", "<leader>cH", { buffer = bufnr })
			vim.keymap.del("n", "<leader>cf", { buffer = bufnr })
		end

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- vim.lsp.config("*", { capabilities = capabilities, on_attach = on_attach, on_detach = on_detach }) -- TODO: this doesn't work
		for _, lspserver in ipairs(lspservers) do
			vim.lsp.config(lspserver, { capabilities = capabilities, on_attach = on_attach, on_detach = on_detach })
		end
		vim.lsp.enable(lspservers)
	end
}
