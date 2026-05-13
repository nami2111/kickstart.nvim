local api_key = vim.env.OPENAI_API_KEY or vim.env.OPENROUTER_API_KEY or vim.env.ANTHROPIC_API_KEY or vim.env.OPENCODE_API_KEY

return {
  'yetone/avante.nvim',
  build = 'make',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
    'MunifTanjim/nui.nvim',
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {},
    },
  },
  keys = {
    { '<leader>aa', '<cmd>AvanteChat<CR>',               desc = 'AI Chat (ask)' },
    { '<leader>ac', '<cmd>AvanteCommit<CR>',             desc = 'AI Commit Message' },
    { '<leader>ae', '<cmd>AvanteEdit<CR>',               desc = 'AI Edit',                    mode = 'v' },
    { '<leader>ar', '<cmd>AvanteRefresh<CR>',            desc = 'AI Refresh' },
    { '<leader>af', '<cmd>AvanteFind<CR>',               desc = 'AI Find File' },
    { '<leader>as', '<cmd>AvanteSwitchProvider<CR>',     desc = 'AI Switch Provider' },
    { '<leader>am', function() require('custom.opencode').pick_model() end,
                                                          desc = 'AI Pick OpenCode Model' },
    { '<leader>a?', function() require('custom.opencode').show_current() end,
                                                          desc = 'AI Show Current Model' },
  },
  opts = {
    provider = 'openai',
    auto_suggestions_provider = 'openai',
    providers = {
      openai = {
        endpoint = 'https://openrouter.ai/api/v1',
        model = 'openai/gpt-4o-mini',
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
      opencode = {
        __inherited_from = 'openai',
        api_key_name = 'OPENCODE_API_KEY',
        endpoint = 'https://opencode.ai/zen/v1',
        model = require('custom.opencode').get_saved_model() or 'opencode/big-pickle',
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
    },
    behaviour = {
      auto_suggestions = false,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
    },
    -- If no API key is found in env vars, show a warning on startup
    _warn_no_key = api_key == nil,
  },
  -- Lazy-load on the avante commands
  cmd = { 'AvanteChat', 'AvanteCommit', 'AvanteEdit', 'AvanteRefresh', 'AvanteFind', 'AvanteSwitchProvider' },
}
