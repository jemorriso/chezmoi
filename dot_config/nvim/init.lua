local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.g.mapleader = ' '

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.breakindent = true
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect'
vim.o.mouse = 'a'
vim.o.termguicolors = true
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.timeoutlen = 300
vim.o.updatetime = 250

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

require('lazy').setup {
  {
    {
      'folke/flash.nvim',
      event = 'VeryLazy',
      opts = {
        modes = {
          search = {
            enabled == false
          }
        }
      },
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      },
    },

    -- need to pass empty opts or config true
    { 'numToStr/Comment.nvim', config = true, lazy = false },

    { "catppuccin/nvim", name = "catppuccin",
      opts = {
        integrations = {
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        }
      },
      priority = 1000
    },

    {
      'jpalardy/vim-slime',
      config = function()
        vim.g.slime_target = 'tmux'

        local slime_dict = {}
        slime_dict.socket_name = 'default'
        slime_dict.target_pane = ':.1'
        vim.g.slime_default_config = slime_dict
      end,
    },

    {
      'mrjones2014/smart-splits.nvim',
      config = function()
        require('smart-splits').setup {
          resize_mode = {
            resize_keys = { 'h', 'j', 'k', 'l' },
          },
        }
      end,
      keys = {
        { '<localleader>r', [[<cmd>lua require("smart-splits").start_resize_mode()<cr>]], desc = 'enter resize mode' },
        { '<A-h>',          [[<cmd>lua require("smart-splits").move_cursor_left()<cr>]],  desc = 'move cursor left' },
        { '<A-j>',          [[<cmd>lua require("smart-splits").move_cursor_down()<cr>]],  desc = 'move cursor down' },
        { '<A-k>',          [[<cmd>lua require("smart-splits").move_cursor_up()<cr>]],    desc = 'move cursor up' },
        { '<A-l>',          [[<cmd>lua require("smart-splits").move_cursor_right()<cr>]], desc = 'move cursor right' },
      },
    },

    { 'akinsho/toggleterm.nvim', version = "*", config = function()
      require("toggleterm").setup {
        direction = "horizontal",
        size = 20,
        open_mapping = [[<M-/>]]
      }
    end
    },

    {
      'nvim-lualine/lualine.nvim',
      opts = {
        options = {
          icons_enabled = false,
          component_separators = '|',
          section_separators = '',
        },
      },
    },

    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'rafamadriz/friendly-snippets',
      },
      config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.setup {}

        cmp.setup {
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          completion = {
            completeopt = 'menu,menuone,noinsert',
          },
          mapping = cmp.mapping.preset.insert {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
          },
        }
      end,
    },

    {
      -- LSP Configuration & Plugins
      'neovim/nvim-lspconfig',
      dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        { 'j-hui/fidget.nvim', opts = {} },
      },
      config = function()
        local on_attach = function(_, bufnr)
          local nmap = function(keys, func, desc)
            if desc then
              desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          nmap('gI', require('telescope.builtin').lsp_implementations,
            '[G]oto [I]mplementation')
          nmap('<leader>D', require('telescope.builtin').lsp_type_definitions,
            'Type [D]efinition')
          nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols,
            '[D]ocument [S]ymbols')
          nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
            '[W]orkspace [S]ymbols')

          -- See `:help K` for why this keymap
          nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
          nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        end

        -- mason-lspconfig requires that these setup functions are called in this order
        -- before setting up the servers.
        require('mason').setup()
        require('mason-lspconfig').setup()

        local servers = {
          pyright = {},
          lua_ls = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { disable = { 'missing-fields' }, globals = { 'vim' } },
            },
          },
        }

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- Ensure the servers above are installed
        local mason_lspconfig = require 'mason-lspconfig'
        mason_lspconfig.setup {
          ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
          function(server_name)
            require('lspconfig')[server_name].setup {
              capabilities = capabilities,
              on_attach = on_attach,
              settings = servers[server_name],
              filetypes = (servers[server_name] or {}).filetypes,
            }
          end,
        }
      end,
    },

    {
      'stevearc/conform.nvim',
      opts = {
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'ruff_fix', 'ruff_format' },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      },
    },

    {
      "mfussenegger/nvim-lint",
      config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
          python = {
            "ruff"
          },
        }
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
          group = lint_augroup,
          callback = function()
            lint.try_lint()
          end,
        })

        vim.keymap.set("n", "<leader>l", function()
          lint.try_lint()
        end, { desc = "Trigger linting for current file" })
      end
    },

    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        {
          -- recommended telescope native sorter
          'nvim-telescope/telescope-fzf-native.nvim',
          build = 'make',
        },
      },
      config = function()
        require('telescope').load_extension 'fzf'
        vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
          { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers,
          { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find,
          { desc = '[/] Fuzzily search in current buffer' })
        vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files,
          { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags,
          { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
          { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep,
          { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
          { desc = '[S]earch [D]iagnostics' })
      end,
    },

    { 'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup {
          -- Add languages to be installed here that you want installed for treesitter
          ensure_installed = { 'lua', 'python', 'bash' },

          -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
          auto_install = false,

          highlight = { enable = true },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<c-space>',
              node_incremental = '<c-space>',
              scope_incremental = '<c-s>',
              node_decremental = '<M-space>',
            },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
              },
              goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
              },
              goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
              },
              goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ['<leader>a'] = '@parameter.inner',
              },
              swap_previous = {
                ['<leader>A'] = '@parameter.inner',
              },
            },
          },
        }
      end,
    },
  }
}

vim.cmd.colorscheme 'catppuccin-mocha'
