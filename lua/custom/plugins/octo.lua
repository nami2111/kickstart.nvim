return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>gii', '<cmd>Octo issue list<CR>',           desc = 'My Issues' },
    { '<leader>gir', '<cmd>Octo issue list --all<CR>',     desc = 'Repo Issues' },
    { '<leader>gip', '<cmd>Octo pr list<CR>',              desc = 'My PRs' },
    { '<leader>gia', '<cmd>Octo pr list --all<CR>',        desc = 'Repo PRs' },
    { '<leader>gRv', '<cmd>Octo review<CR>',               desc = 'Review PR' },
    { '<leader>gic', '<cmd>Octo pr create<CR>',            desc = 'Create PR' },
    { '<leader>gim', '<cmd>Octo pr merge<CR>',             desc = 'Merge PR' },
    { '<leader>gin', '<cmd>Octo notify<CR>',               desc = 'Notifications' },
    { '<leader>gis', '<cmd>Octo search<CR>',               desc = 'Search GitHub' },
    { '<leader>gig', '<cmd>Octo gist list<CR>',            desc = 'Gists' },
  },
  opts = {
    default_remote = { 'upstream', 'origin' },
    -- Telescope as the picker
    picker = 'telescope',
    -- Use the default GitHub timeline review
    review = {
      comment_on_all_diff = false,
    },
  },
}
