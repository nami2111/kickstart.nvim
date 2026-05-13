local M = {}

local model_cache = nil

function M.fetch_models()
  if model_cache then return model_cache end

  local ok, result = pcall(function()
    local resp = vim.fn.systemlist('curl -sf https://opencode.ai/zen/v1/models')
    local json = vim.json.decode(table.concat(resp, ''))
    local models = {}
    if json and json.data then
      for _, m in ipairs(json.data) do
        table.insert(models, m.id)
      end
    end
    table.sort(models)
    return models
  end)

  if ok then
    model_cache = result
    return result
  else
    vim.notify('Failed to fetch Opencode models: ' .. tostring(result), vim.log.levels.ERROR)
    return {}
  end
end

function M.show_current()
  local model = M.get_saved_model() or 'opencode/big-pickle (default)'
  vim.notify('OpenCode model: ' .. model, vim.log.levels.INFO)
end

function M.pick_model()
  local models = M.fetch_models()
  if #models == 0 then
    vim.notify('No Opencode models available', vim.log.levels.WARN)
    return
  end

  vim.ui.select(models, {
    prompt = 'Select OpenCode Zen model',
  }, function(choice)
    if choice then M.set_model(choice) end
  end)
end

local function save_path() return vim.fn.stdpath 'config' .. '/opencode_model' end

function M.get_saved_model()
  local f = io.open(save_path(), 'r')
  if not f then return nil end
  local model = f:read '*l'
  f:close()
  return (model and model ~= '') and model or nil
end

function M.set_model(model_id)
  -- Persist to disk
  local f = io.open(save_path(), 'w')
  if f then
    f:write('opencode/' .. model_id)
    f:close()
  end

  require('lazy').load { plugins = { 'avante.nvim' } }

  local Config = require('avante.config')
  if not Config or not Config.providers then
    vim.notify('Avante config not available', vim.log.levels.ERROR)
    return
  end

  local full_id = 'opencode/' .. model_id
  Config.providers['opencode'].model = full_id

  vim.notify('Switched to Opencode model: ' .. full_id, vim.log.levels.INFO)
  require('avante.api').switch_provider('opencode')
end

return M
