return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        -- "saghen/blink.cmp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- NOTE: LSP Keybinds

        vim.api.nvim_create_autocmd("lspattach", {
            group = vim.api.nvim_create_augroup("userlspconfig", {}),
            callback = function(ev)
                -- buffer local mappings
                -- check `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- keymaps
                opts.desc = "show lsp references"
                vim.keymap.set("n", "gr", "<cmd>telescope lsp_references<cr>", opts) -- show definition, references

                opts.desc = "go to declaration"
                vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "show lsp definitions"
                vim.keymap.set("n", "gd", "<cmd>telescope lsp_definitions<cr>", opts) -- show lsp definitions

                opts.desc = "show lsp implementations"
                vim.keymap.set("n", "gi", "<cmd>telescope lsp_implementations<cr>", opts) -- show lsp implementations

                opts.desc = "show lsp type definitions"
                vim.keymap.set("n", "gt", "<cmd>telescope lsp_type_definitions<cr>", opts) -- show lsp type definitions

                opts.desc = "see available code actions"
                vim.keymap.set({ "n", "v" }, "<leader>vca", function() vim.lsp.buf.code_action() end, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "smart rename"
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "show buffer diagnostics"
                vim.keymap.set("n", "<leader>d", "<cmd>telescope diagnostics bufnr=0<cr>", opts) -- show  diagnostics for file

                opts.desc = "show line diagnostics"
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "show documentation for what is under cursor"
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "restart lsp"
                vim.keymap.set("n", "<leader>rs", ":lsprestart<cr>", opts) -- mapping to restart lsp if necessary

                vim.keymap.set("i", "<c-h>", function() vim.lsp.buf.signature_help() end, opts)
            end,
        })


        -- note : moved all this to mason including local variables
        -- used to enable autocompletion (assign to every lsp server config)
        -- local capabilities = cmp_nvim_lsp.default_capabilities()
        -- change the diagnostic symbols in the sign column (gutter)

        -- define sign icons for each severity
        local signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
            [vim.diagnostic.severity.INFO]  = " ",
        }

        -- set the diagnostic config with all icons
        vim.diagnostic.config({
            signs = {
                text = signs -- enable signs in the gutter
            },
            virtual_text = true,  -- specify enable virtual text for diagnostics
            underline = true,     -- specify underline diagnostics
            update_in_insert = false,  -- keep diagnostics active in insert mode
        })


        -- note : 
        -- moved back from mason_lspconfig.setup_handlers from mason.lua file
        -- as mason setup_handlers is deprecated & its causing issues with lsp settings
        --
        -- setup servers
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- config lsp servers here
        -- lua_ls
        vim.lsp.config["lua_ls"] = {
            capabilities = capabilities,
            settings = {
                lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    completion = {
                        callsnippet = "replace",
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$vimruntime/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        }
        vim.lsp.enable("lua_ls")

        vim.lsp.config["clangd"] = {
            capabilities = capabilities,
            filetypes = {".cpp", "c"}
        }
        vim.lsp.enable("clangd");

        vim.lsp.config["harper_ls"] = {
            capabilities = capabilities,
            filetypes = {"tex"},
            settings = {
                ["harper-ls"] = {
                    linters = {
                        SpellCheck = true,
                        SpelledNumbers = false,
                        AnA = true,
                        SentenceCapitalization = true,
                        UnclosedQuotes = true,
                        WrongQuotes = false,
                        LongSentences = true,
                        RepeatedWords = true,
                        Spaces = true,
                        Matcher = true,
                        CorrectNumberSuffix = true
                    }
                }
            }
        }
        vim.lsp.enable("harper_ls");


        -- HACK: If using Blink.cmp Configure all LSPs here

        -- ( comment the ones in mason )
        -- local lspconfig = require("lspconfig")
        -- local capabilities = require("blink.cmp").get_lsp_capabilities() -- Import capabilities from blink.cmp

        -- Configure lua_ls
        -- lspconfig.lua_ls.setup({
        --     capabilities = capabilities,
        --     settings = {
        --         Lua = {
        --             diagnostics = {
        --                 globals = { "vim" },
        --             },
        --             completion = {
        --                 callSnippet = "Replace",
        --             },
        --             workspace = {
        --                 library = {
        --                     [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        --                     [vim.fn.stdpath("config") .. "/lua"] = true,
        --                 },
        --             },
        --         },
        --     },
        -- })
        --
        -- -- Configure tsserver (TypeScript and JavaScript)
        -- lspconfig.ts_ls.setup({
        --     capabilities = capabilities,
        --     root_dir = function(fname)
        --         local util = lspconfig.util
        --         return not util.root_pattern('deno.json', 'deno.jsonc')(fname)
        --             and util.root_pattern('tsconfig.json', 'package.json', 'jsconfig.json', '.git')(fname)
        --     end,
        --     single_file_support = false,
        --     on_attach = function(client, bufnr)
        --         -- Disable formatting if you're using a separate formatter like Prettier
        --         client.server_capabilities.documentFormattingProvider = false
        --     end,
        --     init_options = {
        --         preferences = {
        --             includeCompletionsWithSnippetText = true,
        --             includeCompletionsForImportStatements = true,
        --         },
        --     },
        -- })

        -- Add other LSP servers as needed, e.g., gopls, eslint, html, etc.
        -- lspconfig.gopls.setup({ capabilities = capabilities })
        -- lspconfig.html.setup({ capabilities = capabilities })
        -- lspconfig.cssls.setup({ capabilities = capabilities })
    end,
}
