-- lua/config/cmp.lua
-- hrsh7th/nvim-cmp -> Completion engine

local ok_cmp, cmp = pcall(require, "cmp")
if not ok_cmp then return end

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),

        -- 1. Désactiver ENTER pour la complétion (comportement normal de touche Entrée)
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- 2. Configurer CTRL + SPACE pour VALIDER
        ['<C-Space>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.confirm({ select = true }) -- Valide la sélection
                else
                    cmp.complete() -- Ouvre le menu si fermé
                end
            end,
            -- Le mode 's' (select) pour les snippets
            s = cmp.mapping.confirm({ select = true }),
        })
        ,        -- Super Tab : Gestion intelligente des priorités
        ['<Tab>'] = cmp.mapping(function(fallback)
            local copilot = require("copilot.suggestion")

            if copilot.is_visible() then
                copilot.accept() -- 1. Priorité à Copilot
            elseif cmp.visible() then
                cmp.select_next_item() -- 2. Si menu LSP ouvert, on navigue
            else
                fallback() -- 3. Sinon, on fait un vrai Tab (indentation)
            end
        end, { "i", "s" }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    })
})
