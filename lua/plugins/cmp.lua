return {
  'saghen/blink.cmp',
  event = "InsertEnter",
  -- optional: provides snippets for the snippet source
  dependencies = {
    'worming004/friendly-snippets',
    {
      'fang2hou/blink-copilot',
      dependencies = {
        {
          "zbirenbaum/copilot.lua",
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
          'CopilotC-Nvim/CopilotChat.nvim',
          event = { 'BufEnter' },
          branch = "main",
          dependencies = {
            {
              'zbirenbaum/copilot.lua',
              opts = {
                suggestion = { enabled = false },
                panel = { enabled = false },
                filetypes = {
                  markdown = true,
                  yaml = true
                },
              }
            },
            { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
          },
          opts = {
            debug = true,      -- Enable debugging
            context = 'files', -- Default context or array of contexts to use (can be specified manually in prompt via #).
            mappings = {
              reset = {
                normal = '',
                insert = '',
              },
            },
          },
          -- See Commands section for default commands if you want to lazy load on them
        }
      }
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
        min_width = 100,
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
      default = { 'lsp', 'path', 'snippets', 'buffer', 'omni', 'copilot' },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
      },
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
