local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_macos = wezterm.target_triple:find("darwin") ~= nil
local is_windows = wezterm.target_triple:find("windows") ~= nil

local function smart_split_nav(direction)
  return wezterm.action_callback(function(window, pane)
    local process_name = pane:get_foreground_process_name()

    if process_name and process_name:find("nvim") then
      window:perform_action(
        wezterm.action.SendKey({
          key = direction.key,
          mods = "CTRL",
        }),
        pane
      )
    else
      window:perform_action(
        wezterm.action.ActivatePaneDirection(direction.pane),
        pane
      )
    end
  end)
end

config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "Hack Nerd Font",
  "Menlo",
  "Consolas",
})

config.font_size = is_macos and 14.0 or 11.5
config.color_scheme = 'Monokai (dark) (terminal.sexy)'
config.window_background_opacity = 0.96
config.macos_window_background_blur = is_macos and 20 or 0

config.window_padding = {
  left = 10,
  right = 10,
  top = 8,
  bottom = 8,
}

config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

config.window_decorations = is_macos and "RESIZE" or "TITLE | RESIZE"

config.audible_bell = "Disabled"
config.check_for_updates = false

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

config.keys = {
  {
    key = "d",
    mods = is_macos and "CMD" or "ALT",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "D",
    mods = is_macos and "CMD|SHIFT" or "ALT|SHIFT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "w",
    mods = is_macos and "CMD" or "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  {
    key = "h",
    mods = "CTRL",
    action = smart_split_nav({ key = "h", pane = "Left" }),
  },
  {
    key = "j",
    mods = "CTRL",
    action = smart_split_nav({ key = "j", pane = "Down" }),
  },
  {
    key = "k",
    mods = "CTRL",
    action = smart_split_nav({ key = "k", pane = "Up" }),
  },
  {
    key = "l",
    mods = "CTRL",
    action = smart_split_nav({ key = "l", pane = "Right" }),
  },
  {
    key = "Enter",
    mods = is_macos and "CMD" or "ALT",
    action = wezterm.action.ToggleFullScreen,
  },
}

if is_windows then
  config.default_domain = "WSL:Ubuntu"
end

return config
