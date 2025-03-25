-- local has_words_before = function()
--   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
-- end
--
-- return {
--   "hrsh7th/nvim-cmp",
--   dependencies = {
--     {
--       "hrsh7th/cmp-nvim-lsp",
--     },
--     {
--       "hrsh7th/cmp-buffer",
--     },
--     {
--       "hrsh7th/cmp-path",
--     },
--     {
--       "hrsh7th/cmp-cmdline",
--     },
--     {
--       "saadparwaiz1/cmp_luasnip",
--     },
--     {
--       "hrsh7th/cmp-nvim-lsp-signature-help"
--     },
--     {
--       "L3MON4D3/LuaSnip",
--       event = "InsertEnter",
--       dependencies = {
--         "worming004/friendly-snippets",
--         branch = "main"
--       },
--     },
--     {
--       "hrsh7th/cmp-nvim-lua",
--     },
--     {
--       "zbirenbaum/copilot-cmp",
--       cmd = "Copilot",
--       config = function()
--         require("copilot_cmp").setup({
--           fix_pairs = true,
--         })
--       end,
--       dependencies = {
--         {
--           "CopilotC-Nvim/CopilotChat.nvim",
--           branch = "main",
--           dependencies = {
--             {
--               "zbirenbaum/copilot.lua",
--               opts = {
--                 suggestion = { enabled = false },
--                 panel = { enabled = false },
--                 filetypes = {
--                   markdown = true,
--                   yaml = true
--                 },
--               }
--             },
--             { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
--           },
--           opts = {
--             debug = true,      -- Enable debugging
--             context = "files", -- Default context or array of contexts to use (can be specified manually in prompt via #).
--             mappings = {
--               reset = {
--                 normal = '',
--                 insert = '',
--               },
--             },
--           },
--           -- See Commands section for default commands if you want to lazy load on them
--         },
--       }
--     }
--   },
--   event = {
--     "InsertEnter",
--     "CmdlineEnter",
--   },
--
--   config = function()
--     local cmp = require "cmp"
--     local luasnip = require "luasnip"
--     require("luasnip/loaders/from_vscode").lazy_load()
--
--     local check_backspace = function()
--       local col = vim.fn.col "." - 1
--       return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
--     end
--
--     local kind_icons = {
--       Text = "󰉿",
--       Method = "m",
--       Function = "󰊕",
--       Constructor = "",
--       Field = "",
--       Variable = "󰆧",
--       Class = "󰌗",
--       Interface = "",
--       Module = "",
--       Property = "",
--       Unit = "",
--       Value = "󰎠",
--       Enum = "",
--       Keyword = "󰌋",
--       Snippet = "",
--       Color = "󰏘",
--       File = "󰈙",
--       Reference = "",
--       Folder = "󰉋",
--       EnumMember = "",
--       Constant = "󰇽",
--       Struct = "",
--       Event = "",
--       Operator = "󰆕",
--       TypeParameter = "󰊄",
--       Codeium = "󰚩",
--       Copilot = "",
--     }
--
--     local default_setup = {
--       sorting = {
--         priority_weight = 2,
--         comparators = {
--           require("copilot_cmp.comparators").prioritze,
--           cmp.config.compare.offset,
--           cmp.config.compare.exact,
--           cmp.config.compare.score,
--           cmp.config.compare.kind,
--           cmp.config.compare.sort_text,
--           cmp.config.compare.length,
--           cmp.config.compare.order,
--         },
--       },
--       preselect = cmp.PreselectMode.None,
--       snippet = {
--         expand = function(args)
--           luasnip.lsp_expand(args.body) -- For `luasnip` users.
--         end,
--       },
--       mapping = cmp.mapping.preset.insert {
--         ["<C-k>"] = cmp.mapping.select_prev_item(),
--         ["<C-j>"] = cmp.mapping.select_next_item(),
--         ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
--         ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
--         ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
--         ["<C-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
--         ["<C-e>"] = cmp.mapping {
--           i = cmp.mapping.abort(),
--           c = cmp.mapping.close(),
--         },
--         -- Accept currently selected item. If none selected, `select` first item.
--         -- Set `select` to `false` to only confirm explicitly selected items.
--         ["<CR>"] = cmp.mapping.confirm { select = false },
--         ["<Tab>"] = cmp.mapping(function(fallback)
--           if not has_words_before() then
--             fallback()
--           elseif cmp.visible() then
--             cmp.select_next_item()
--           elseif luasnip.expandable() then
--             luasnip.expand()
--           elseif luasnip.expand_or_jumpable() then
--             luasnip.expand_or_jump()
--           elseif check_backspace() then
--             fallback()
--           else
--             fallback()
--           end
--         end, {
--           "i",
--           "s",
--         }),
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_prev_item()
--           elseif luasnip.jumpable(-1) then
--             luasnip.jump(-1)
--           else
--             fallback()
--           end
--         end, {
--           "i",
--           "s",
--         }),
--       },
--       formatting = {
--         fields = { cmp.ItemField.Kind, cmp.ItemField.Abbr, cmp.ItemField.Menu },
--         format = function(entry, vim_item)
--           vim_item.kind = kind_icons[vim_item.kind]
--           vim_item.menu = ({
--             nvim_lsp = "",
--             nvim_lua = "",
--             luasnip = "",
--             buffer = "",
--             path = "",
--             emoji = "",
--           })[entry.source.name]
--           return vim_item
--         end,
--       },
--       sources = {
--         { name = "luasnip" },
--         { name = "nvim_lsp" },
--         { name = "nvim_lua" },
--         { name = "buffer" },
--         { name = "path" },
--         { name = "copilot", max_item_count = 5 },
--       },
--       confirm_opts = {
--         behavior = cmp.ConfirmBehavior.Replace,
--         select = false,
--       },
--       window = {
--         completion = cmp.config.window.bordered(),
--         documentation = cmp.config.window.bordered(),
--         max_width = 80,
--       },
--     }
--
--     cmp.setup(default_setup)
--
--     local cmp_markdown = vim.deepcopy(default_setup)
--     cmp_markdown.sources = {
--       -- same list but rm lsp. Language tool is better used with a debouncing. But cmp_lsp puth a textDocument/completion for each keystroke
--       { name = "luasnip" },
--       { name = "nvim_lua" },
--       { name = "buffer" },
--       { name = "path" },
--       { name = "copilot", max_item_count = 5 },
--     }
--
--     cmp.setup.filetype('markdown', cmp_markdown)
--   end
-- }

--to blink
return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    'worming004/friendly-snippets',
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      },
    },
    {
      "saghen/blink.cmp",
      optional = true,
      dependencies = { "fang2hou/blink-copilot" },
      opts = {
        sources = {
          default = { "copilot" },
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-copilot",
              score_offset = 100,
              async = true,
            },
          },
        },
      },
    },
  },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'enter' },
    signature = { enabled = true }, -- Really work ??
    appearance = {
      use_nvim_cmp_as_default = true
    },

    completion = {
      menu = {
        draw = {
          components = {
            kind_icon = {
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            }
          }
        }
      },
      documentation = {
        auto_show = false
      }
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'omni' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
