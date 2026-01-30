-- Arrow Key Trainer for Neovim
-- Toggle arrow keys on/off to build hjkl muscle memory

local M = {}

-- Track whether arrow keys are currently disabled
M.arrows_disabled = false

-- Function to show a reminder message when arrow keys are pressed
local function show_hint(direction)
  local hints = {
    Left = "← Use 'h' instead!",
    Down = "↓ Use 'j' instead!",
    Up = "↑ Use 'k' instead!",
    Right = "→ Use 'l' instead!",
  }
  vim.notify(hints[direction], vim.log.levels.WARN, { title = "Arrow Trainer" })
end

-- Disable arrow keys in specified modes
local function disable_arrows()
  local modes = { "n", "i", "v", "x", "o" }
  local arrows = { "Left", "Down", "Up", "Right" }

  for _, mode in ipairs(modes) do
    for _, arrow in ipairs(arrows) do
      vim.keymap.set(mode, "<" .. arrow .. ">", function()
        show_hint(arrow)
      end, { noremap = true, silent = false, desc = "Arrow disabled - use hjkl" })
    end
  end
end

-- Re-enable arrow keys (restore default behavior)
local function enable_arrows()
  local modes = { "n", "i", "v", "x", "o" }
  local arrows = { "Left", "Down", "Up", "Right" }

  for _, mode in ipairs(modes) do
    for _, arrow in ipairs(arrows) do
      -- pcall safely ignores "no such mapping" errors
      pcall(vim.keymap.del, mode, "<" .. arrow .. ">")
    end
  end
end

-- Toggle function
function M.toggle()
  if M.arrows_disabled then
    enable_arrows()
    M.arrows_disabled = false
    -- vim.notify("🏹 Arrow keys ENABLED (training mode OFF)", vim.log.levels.INFO)
  else
    disable_arrows()
    M.arrows_disabled = true
    -- vim.notify("🎯 Arrow keys DISABLED (training mode ON) - use hjkl!", vim.log.levels.INFO)
  end
end

-- Setup function with options
function M.setup(opts)
  opts = opts or {}

  -- Start with arrows disabled by default (can be overridden)
  local start_disabled = opts.start_disabled
  if start_disabled == nil then
    start_disabled = true
  end

  -- Create user command for easy toggling
  vim.api.nvim_create_user_command("ArrowToggle", function()
    M.toggle()
  end, { desc = "Toggle arrow key training mode" })

  -- Optional: set up a keymap for quick toggle
  if opts.toggle_key then
    vim.keymap.set("n", opts.toggle_key, M.toggle, { noremap = true, silent = true, desc = "Toggle arrow training" })
  end

  -- Initialize state (deferred to ensure we override other plugins)
  if start_disabled then
    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        vim.defer_fn(function()
          disable_arrows()
          M.arrows_disabled = true
          -- vim.notify("🎯 Arrow Trainer: hjkl mode active! Use :ArrowToggle to switch", vim.log.levels.INFO)
        end, 100)
      end,
    })
  end
end

return M
