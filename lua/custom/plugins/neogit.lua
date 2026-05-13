return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  keys = {
    { '<leader>gg', '<cmd>Neogit<CR>',                 desc = 'Open Git Panel' },
    { '<leader>g<CR>', '<cmd>Neogit commit<CR>',       desc = 'Git Commit' },
    { '<leader>gL',    '<cmd>Neogit log<CR>',          desc = 'Git Log' },
    { '<leader>gP',    '<cmd>Neogit pull<CR>',         desc = 'Git Pull' },
    { '<leader>gU',    '<cmd>Neogit push<CR>',         desc = 'Git Push' },
    { '<leader>gB',    '<cmd>Neogit branch<CR>',       desc = 'Git Branches' },
  },
  opts = {
    integrations = { diffview = true },
    kind = 'tab',
    commit_editor = {
      kind = 'split',
    },
  },
}
