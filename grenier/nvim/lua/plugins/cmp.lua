local cmp_ok, cmp = pcall(require, "cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")
if cmp_ok and luasnip_ok then
  cmp.setup({
    window = {
      completion = cmp.config.window.bordered({ winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None" }),
      documentation = cmp.config.window.bordered({ winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None" }),
    },
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<C-Space>'] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then cmp.confirm({ select = true }) else cmp.complete() end
        end,
        s = cmp.mapping.confirm({ select = true }),
      }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
        elseif cmp.visible() then cmp.select_next_item()
        else fallback() end
      end, { "i", "s" }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then luasnip.jump(-1)
        elseif cmp.visible() then cmp.select_prev_item()
        else fallback() end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    }),
  })
end
