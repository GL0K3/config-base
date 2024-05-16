return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {}

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in pairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<leader>pa', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: add current file' })

    vim.keymap.set('n', '<leader>pd', function()
      harpoon:list():remove()
    end, { desc = 'Harpoon: delete current file' })

    vim.keymap.set('n', '<leader>pe', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Harpoon: Open telescope window' })

    vim.keymap.set('n', '<C-e>', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Harpoon: Open telescope window' })

    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon: Open file 1' })

    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon: Open file 2' })

    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon: Open file 3' })

    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon: Open file 4' })

    -- vim.keymap.set('n', '<C-S-P>', function()
    --   toggle_telescope(harpoon:list():prev())
    -- end, { desc = 'Harpoon: Go to previous file' })
    --
    -- vim.keymap.set('n', '<C-S-N>', function()
    --   toggle_telescope(harpoon:list():next())
    -- end, { desc = 'Harpoon: Go to next file' })
  end,
}
