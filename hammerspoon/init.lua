-- name = "Nikhil Narayen"
-- email = "nikhil.narayen@airbnb.com"

--- Move window by top/left and botom/right as recent of the screen
function moveWindowPercentOfScreen(x1, y1, x2, y2)
  return function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local bounds = screen:frame()

    -- Set the window location as top/left plus height and width
    topLeftX = bounds.x + (bounds.w * x1)
    topLeftY = bounds.y + (bounds.h * y1)
    width = bounds.w * x2
    height = bounds.h * y2

    --- Bring bottom/right of window within screen bounds
    if (topLeftX + width) > (bounds.x + bounds.w) then
      width = (bounds.x + bounds.w) - topLeftX
    end
    if (topLeftY + height) > (bounds.y + bounds.h) then
      height = (bounds.y + bounds.h) - topLeftY
    end

    --- Set the window to the new location
    f.x = topLeftX
    f.y = topLeftY
    f.w = width
    f.h = height
    win:setFrame(f)
  end
end

-- Remove animation delay
hs.window.animationDuration = 0

homeDir=os.getenv("HOME")
function bindAppToKey(useHomeAppPath, key, app)
  local appPath

  if useHomeAppPath == true then
    appPath=homeDir .. "/Applications/" .. app .. ".app"
  else
    appPath=app
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

-- Put mac to sleep
hs.hotkey.bind(mash, "space", function() hs.execute("pmset displaysleepnow") end)

--- Move window to left/right/top/bottom half of the screen
hs.hotkey.bind(mash, "h", moveWindowPercentOfScreen(0.0,  0.0,  0.5,  1.0))
hs.hotkey.bind(mash, "l", moveWindowPercentOfScreen(0.5,  0.0,  1.0,  1.0))
hs.hotkey.bind(mash, "k", moveWindowPercentOfScreen(0.0,  0.0,  1.0,  0.5))
hs.hotkey.bind(mash, "j", moveWindowPercentOfScreen(0.0,  0.5,  1.0,  1.0))

-- Maximize screen
hs.hotkey.bind(mash, "m", moveWindowPercentOfScreen(0.0,  0.0,  1.0,  1.0))

--- Multiple Monitor Actions ---
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
