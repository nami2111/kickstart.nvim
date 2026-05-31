local M = {}

function M.generate_and_commit()
  -- Get staged diff
  local diff = vim.fn.system('git diff --cached')

  if diff == '' then
    vim.notify('No staged changes', vim.log.levels.WARN)
    return
  end

  -- Get API key
  local api_key = vim.env.OPENCODE_API_KEY
  if not api_key then
    vim.notify('OPENCODE_API_KEY not set', vim.log.levels.ERROR)
    return
  end

  vim.notify('Generating commit message...', vim.log.levels.INFO)

  -- Build prompt
  local prompt = 'Generate a conventional commit message for these changes. Return ONLY the commit message, no explanation:\n\n' .. diff

  -- Call OpenCode API using Lua HTTP
  local json_body = vim.json.encode({
    model = 'big-pickle',
    messages = {
      { role = 'user', content = prompt }
    },
    temperature = 0
  })

  local curl_cmd = {
    'curl',
    '-s',
    'https://opencode.ai/zen/v1/chat/completions',
    '-H', 'Content-Type: application/json',
    '-H', 'Authorization: Bearer ' .. api_key,
    '-d', json_body
  }

  vim.fn.jobstart(curl_cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data or #data == 0 then return end

      local response = table.concat(data, '\n')
      local ok, json = pcall(vim.json.decode, response)

      if not ok or not json.choices or #json.choices == 0 then
        vim.notify('Failed to generate commit message', vim.log.levels.ERROR)
        return
      end

      local message = json.choices[1].message.content:gsub('^%s+', ''):gsub('%s+$', '')

      -- Show commit message in a buffer for editing
      vim.schedule(function()
        -- Create a new buffer
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(message, '\n'))
        vim.bo[buf].buftype = 'acwrite'
        vim.bo[buf].bufhidden = 'wipe'
        vim.bo[buf].filetype = 'gitcommit'

        -- Open in a centered floating window
        local width = math.floor(vim.o.columns * 0.6)
        local height = math.floor(vim.o.lines * 0.4)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        local win = vim.api.nvim_open_win(buf, true, {
          relative = 'editor',
          width = width,
          height = height,
          row = row,
          col = col,
          style = 'minimal',
          border = 'rounded',
          title = ' AI Generated Commit Message ',
          title_pos = 'center',
        })

        -- Instructions
        vim.api.nvim_buf_set_lines(buf, -1, -1, false, { '', '# Press <leader>w to commit, :q to cancel' })

        -- Keymap to commit
        vim.keymap.set('n', '<leader>w', function()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          -- Remove comment lines
          local commit_lines = {}
          for _, line in ipairs(lines) do
            if not line:match('^#') then
              table.insert(commit_lines, line)
            end
          end
          local edited_message = table.concat(commit_lines, '\n'):gsub('^%s+', ''):gsub('%s+$', '')

          if edited_message ~= '' then
            vim.api.nvim_win_close(win, true)
            local commit_result = vim.fn.system('git commit -m ' .. vim.fn.shellescape(edited_message))
            if vim.v.shell_error == 0 then
              vim.notify('Committed successfully!', vim.log.levels.INFO)
              vim.cmd('silent! Neogit refresh')
            else
              vim.notify('Commit failed: ' .. commit_result, vim.log.levels.ERROR)
            end
          end
        end, { buffer = buf, desc = 'Commit with message' })
      end)
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        vim.notify('API error: ' .. table.concat(data, '\n'), vim.log.levels.ERROR)
      end
    end,
  })
end

return M
