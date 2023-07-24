-- init grid
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 6
hs.grid.GRIDHEIGHT = 3

-- disable animation
hs.window.animationDuration = 0

-- Key bindings
local mash = {"shift", "cmd"}
local shift = {"shift"}
local none = {""}

-- global operations
hs.hotkey.bind(mash, ';', function() hs.grid.snap(hs.window.focusedWindow()) end)
hs.hotkey.bind(mash, "'", function() hs.fnutil.map(hs.window.visibleWindows(), hs.grid.snap) end)
hs.hotkey.bind(mash, 'M', hs.grid.maximizeWindow)

-- Remap nasty ± character to something more expected like ~
hs.hotkey.bind(shift, '§', function() hs.eventtap.keyStroke({"shift"}, '`') end)
hs.hotkey.bind(none, '§', function() hs.eventtap.keyStroke(none, '`') end)

--
-- Launch or switch to JumpDesktop
--
-- hs.hotkey.bind(mash, "J", function()
--   hs.application.launchOrFocus("Jump Desktop")
--   local win = hs.window.focusedWindow()
--   if win then
--     -- win:maximize()
--   end
-- end)

-- hs.hotkey.bind(mash, "F", function()
--   hs.application.launchOrFocus("Firefox")
--   local win = hs.window.focusedWindow()
-- end)

hs.hotkey.bind(mash, "I", function()
  hs.application.launchOrFocus("Iridium")
  local win = hs.window.focusedWindow()
end)

--hs.hotkey.bind(mash, "P", function()
--  hs.application.launchOrFocus("Macpass")
--  local win = hs.window.focusedWindow()
-- end)

--hs.hotkey.bind(mash, "S", function()
--  hs.application.launchOrFocus("Safari")
--  local win = hs.window.focusedWindow()
--  if win then
--    -- win:maximize()
--  end
--end)

-- hs.hotkey.bind(mash, "D", function()
--  hs.application.launchOrFocus("Dash")
-- local win = hs.window.focusedWindow()
-- end)

hs.hotkey.bind(mash, "Z", function()
  hs.application.launchOrFocus("iTerm")
  local win = hs.window.focusedWindow()
end)

-- hs.hotkey.bind(mash, "H", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--
--   f.x = f.x - 10
--   win:setFrame(f)
-- end)

hs.hotkey.bind(mash, "Left", function()
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

hs.hotkey.bind(mash, "Right", function()
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

hs.hotkey.bind(mash, "Up", function()
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

hs.hotkey.bind(mash, "Down", function()
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

-----------------------------------------------
-- Hyper hjkl to switch window focus
-----------------------------------------------

-- hs.hotkey.bind(mash, 'k', function()
--     if hs.window.focusedWindow() then
--         hs.window.focusedWindow():focusWindowNorth()
--     else
--         hs.alert.show("No active window")
--     end
-- end)

-- hs.hotkey.bind(mash, 'j', function()
--     if hs.window.focusedWindow() then
--         hs.window.focusedWindow():focusWindowSouth()
--     else
--         hs.alert.show("No active window")
--     end
-- end)

-- hs.hotkey.bind(mash, 'l', function()
--     if hs.window.focusedWindow() then
--     hs.window.focusedWindow():focusWindowEast()
--     else
--         hs.alert.show("No active window")
--     end
-- end)

-- hs.hotkey.bind(mash, 'h', function()
--     if hs.window.focusedWindow() then
--         hs.window.focusedWindow():focusWindowWest()
--     else
--         hs.alert.show("No active window")
--     end
-- end)

-- Auto reload config when writing file
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
	if file:sub(-4) == ".lua" then
	    doReload = true
	end
    end
    if doReload then
	hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Hammer time!")

--
-- Graphically highlight the mouse position on screen.
--
local mouseCircle = nil
local mouseCircleTimer = nil

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.absolutePosition()
    -- Prepare a big red circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:show()

    -- Set a timer to delete the circle after 3 seconds
    mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end
hs.hotkey.bind({"cmd","alt","shift"}, "D", mouseHighlight)

---
--- Spoons Configs
---

local SkyRocket = hs.loadSpoon("SkyRocket")

sky = SkyRocket:new({
  -- Opacity of resize canvas
  opacity = 0.3,

  -- Which modifiers to hold to move a window?
  -- moveModifiers = {'cmd', 'shift'},
  moveModifiers = {'cmd', 'shift'},

  -- Which mouse button to hold to move a window?
  moveMouseButton = 'left',

  -- Which modifiers to hold to resize a window?
  -- resizeModifiers = {'ctrl', 'shift'},
  resizeModifiers = {'cmd', 'shift'},

  -- Which mouse button to hold to resize a window?
  resizeMouseButton = 'right',
})
