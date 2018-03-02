-- name = "Nikhil Narayen"
-- email = "nikhil.narayen@airbnb.com"

-- Define default Spoons which will be loaded later
if not hspoon_list then
  hspoon_list = {
    "WinWin",
  }
end

-- Load those Spoons
for _, v in pairs(hspoon_list) do
  hs.loadSpoon(v)
end

-- Remove animation delay
hs.window.animationDuration = 0

homeDir = os.getenv("HOME")
function bindAppToKey(useHomeAppPath, key, app)
  local appPath

  if useHomeAppPath == true then
    appPath = homeDir .. "/Applications/" .. app .. ".app"
  else
    appPath = app
  end

  hs.hotkey.bind(mash, key, function() hs.application.launchOrFocus(appPath) end)
end

-- Custom hyper keys
mash = {"cmd", "shift"}

-- Apps
bindAppToKey(false, "c", "Google Chrome")
bindAppToKey(false, "s", "Slack")
bindAppToKey(false, "i", "iTerm")
bindAppToKey(false, "e", "Messages")
bindAppToKey(false, "o", "Notes")
bindAppToKey(false, "1", "1Password 6")
bindAppToKey(false, "d", "IntelliJ IDEA")

-- Put mac to sleep
hs.hotkey.bind(mash, "space", function() hs.caffeinate.systemSleep() end)

--- Move window to left/right/top/bottom half of the screen
hs.hotkey.bind(mash, "h", function() spoon.WinWin:moveAndResize("halfleft") end)
hs.hotkey.bind(mash, "l", function() spoon.WinWin:moveAndResize("halfright") end)
hs.hotkey.bind(mash, "k", function() spoon.WinWin:moveAndResize("halfup") end)
hs.hotkey.bind(mash, "j", function() spoon.WinWin:moveAndResize("halfdown") end)

-- Maximize screen
hs.hotkey.bind(mash, "m", function() spoon.WinWin:moveAndResize("fullscreen") end)

--- Multiple Monitor Actions
hs.hotkey.bind(mash, "p", function()
  local win = hs.window.focusedWindow()
  win:moveToScreen(win:screen():previous())
end)

-- Reload config
function reloadConfig(files)
  doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
hs.pathwatcher.new(homeDir .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

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
