-- name = "Nikhil Narayen"
-- email = "nikhil.narayen@gmail.com"

-- Define default Spoons which will be loaded later
if not hspoon_list then
  hspoon_list = {
    "WinWin",
    "ReloadConfiguration",
  }
end

-- Load those Spoons
for _, v in pairs(hspoon_list) do
  hs.loadSpoon(v)
end

-- Remove animation delay
hs.window.animationDuration = 0

-- Custom hyper keys
mash = {"cmd", "shift"}

-- Apps
local apps = {
  c = 'Google Chrome',
  s = 'Slack',
  i = 'iTerm',
  e = 'Messages',
  o = 'Notes',
  d = 'IntelliJ IDEA'
}
apps['1'] = '1Password 7'

for key, app in pairs(apps) do
  hs.hotkey.bind(mash, key, function() hs.application.launchOrFocus(app) end)
end

-- Put mac to sleep
hs.hotkey.bind(mash, "space", function() hs.caffeinate.systemSleep() end)

-- Move window to left/right/top/bottom half of the screen
hs.hotkey.bind(mash, "h", function() spoon.WinWin:moveAndResize("halfleft") end)
hs.hotkey.bind(mash, "l", function() spoon.WinWin:moveAndResize("halfright") end)
hs.hotkey.bind(mash, "k", function() spoon.WinWin:moveAndResize("halfup") end)
hs.hotkey.bind(mash, "j", function() spoon.WinWin:moveAndResize("halfdown") end)

-- Maximize screen
hs.hotkey.bind(mash, "m", function() spoon.WinWin:moveAndResize("fullscreen") end)

-- Multiple Monitor Actions
hs.hotkey.bind(mash, "p", function()
  local win = hs.window.focusedWindow()
  win:moveToScreen(win:screen():previous())
end)

-- Reload config
spoon.ReloadConfiguration:start()

-- Show window hints
hs.hotkey.bind(mash, "a", function()
  hs.hints.windowHints()
end)

-- Turn bluetooth off/on system sleep
bluetooth = require("hs._asm.undocumented.bluetooth")
caffeinate_watcher = hs.caffeinate.watcher.new(function(state)
  if state == hs.caffeinate.watcher.systemWillSleep then
    bluetooth.power(false)
  elseif state == hs.caffeinate.watcher.systemDidWake then
    bluetooth.power(true)
  end
end)
caffeinate_watcher:start()

-- Loaded!
hs.alert.show("Config loaded")
