local utils = require("utils")

function upperHalf(win)
  local screen = win:screen()
  -- local f = hs.screen.primaryScreen():fullFrame()
  local f = screen:fullFrame()
  f.h = f.h/2
  return f
end

local defaultModifier = {"cmd", "alt", "ctrl"}
hs.hotkey.bind(defaultModifier, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind(defaultModifier, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)


hs.hotkey.bind(defaultModifier, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)


hs.hotkey.bind(defaultModifier, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)


local xWidthToggle = 48
local yHeightToggle = 12
hs.hotkey.bind(defaultModifier, "Return", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local paddingX = (max.w / xWidthToggle)
  local paddingY = (max.h / yHeightToggle)

  if xWidthToggle == 48 then
    xWidthToggle = 6
    yHeightToggle = 6
  else
    xWidthToggle = 48
    yHeightToggle = 12
  end

  -- alternatively look into using `hs.window:moveToUnit()` which works with display fractions out of the box!
  f.x = max.x + (paddingX / 2)
  f.y = max.y + (paddingY / 2)
  f.w = max.w - paddingX
  f.h = max.h - paddingY

  win:setFrame(f)
end)

local function focusApp(appName)
	return function()
		utils.focusApp(appName)
	end
end

local function toggleApp(appName)
	return function()
		utils.toggleApp(appName)
	end
end

local function weakFocus(appName)
	return function()
		utils.weakFocus(appName)
	end
end

local cmd2 = { "command", "ctrl" }

local function toggleAppFocus(appName)
  return function()
    local focusedApp = hs.application.frontmostApplication()
    local targetApp = hs.application.get(appName)

    if focusedApp == targetApp then
      targetApp:hide()
    else 
    hs.application.launchOrFocus(appName)
    end

  end
end

local function hmm()
  hs.window.find("togglity")
end

local function trika(appName)
  return function()
    local termTitle = "togglity"
    local termWindow = hs.window.find(termTitle)

    if not termWindow then
      os.execute("/opt/homebrew/bin/alacritty --title=togglity &")
      os.execute("/bin/sleep .5")
      local screen = hs.screen.allScreens()[1]:name()
    local focusedWin = hs.window.frontmostWindow()
      local windowLayout = {
        {nil, focusedWin, screen, nil, nil, upperHalf}

      }
      hs.layout.apply(windowLayout)
    else
      -- local targetApp = termWindow:application()
      local focusedWindow = hs.window.frontmostWindow()
      if focusedWindow == termWindow then
        termWindow:minimize()
      else 
        termWindow:focus()
      end
    end



    -- local focusedWin = hs.window.frontmostWindow()




    -- local focusedApp = hs.application.frontmostApplication()
    -- local ti = focusedApp:title()
    -- hs.alert.show(ti)
    -- local focusedWin = hs.window.frontmostWindow()
    -- local ti = focusedWin:title()
    -- hs.alert.show(ti)

  end
end

local function triko()
    local focusedWin = hs.window.frontmostWindow()
    local ti = focusedWin:title()
    hs.alert.show(ti)
end

local function biko()
    hs.alert.show("todo implement")
end

-- for more apps, run
-- $ ls /Applications
hs.hotkey.bind({}, "F1", toggleAppFocus("Google Chrome"))
hs.hotkey.bind({}, "F2", biko)
hs.hotkey.bind({}, "F3", toggleAppFocus("IntelliJ IDEA"))
hs.hotkey.bind({}, "F4", toggleAppFocus("Obsidian"))
hs.hotkey.bind({}, "F5", toggleAppFocus("Slack"))
hs.hotkey.bind({}, "F7", trika("Alacritty"))
hs.hotkey.bind({}, "F8", triko)
hs.hotkey.bind({}, "F9", toggleAppFocus("Bitwarden"))
-- hs.hotkey.bind(cmd2, "1", weakFocus("Slack"))
-- hs.hotkey.bind(cmd2, "2", focusApp("Google Chrome"))
-- hs.hotkey.bind(cmd2, "3", weakFocus("IntelliJ IDEA"))
-- hs.hotkey.bind(cmd2, "4", weakFocus("Insomnia"))
-- hs.hotkey.bind(cmd2, "9", focusApp("Spotify"))

-- local screen = hs.screen.allScreens()[1]:name()
-- local windowLayout = {
--   {nil, "togglity", screen, hs.layout.right50, nil, nil}
--
-- }
-- hs.layout.apply(windowLayout)



-- function applicationWatcher(appName, eventType, appObject)
--   if (eventType == hs.application.watcher.activated) then
--     if (appName == "Alacritty" or appName == "alacritty") then
--       local app = hs.application.get(appName)
--       local window = app::
--     end
--   end
-- end
-- appWatcher = hs.application.watcher.new(applicationWatcher)
-- appWatcher:start()


-- also check https://rakhesh.com/coding/using-hammerspoon-to-switch-apps/
