hs.window.animationDuration = 0 -- disable animations


-- I don't really need this, just here for an example
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.notify.new({title="HAMMERSPOON", informativeText="Hello World"}):send():release()
end)

-- This reloads config, and I think it's in the intro or tutorial
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
hs.notify.new({title="Config loaded"})


-- Stuff to manipulate application window sizes and positions starts here.

-- Move window to left half of screen by Ctrl-Alt-Cmd-Left
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
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

-- Move window to right half of screen by Ctrl-Alt-Cmd-Right
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
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

-- This is for my tallscreen which I use as my primary work screen
-- It is divided into thirds. The following stuff puts things into
-- different thirds of the screen

-- Toggle between moving application to upper third, or upper two-thirds

local toggle = 1;
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  if toggle == 1 then
     f.h = max.h / 3
     toggle = 0
  else
     f.h = 2 * (max.h) / 3
     toggle = 1
  end
  win:setFrame(f)
end)

-- Move window to bottom third
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (2 * max.h / 3)
  f.w = max.w
  f.h = max.h / 3
  win:setFrame(f)
end)

-- Move window to middle third
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "l", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  
  f.x = max.x
  f.y = max.y + (max.h / 3)
  f.w = max.w
  f.h = max.h / 3
  win:setFrame(f)
end)


-- Fullscreen application without removing the menu bar.
-- Apple added this annoying feature which removes the
-- menu bar (good) and animates it every time you go in
-- and out of fullscreen (bad). I'll take the loss of
-- screen space

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "o", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

-- App specific shortcuts

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "m", function()
      hs.application.launchOrFocus("Emacs")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "p", function()
      hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "k", function()
      hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "i", function()
      hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, ",", function()
      hs.application.launchOrFocus("Slack")
end)
