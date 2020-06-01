
-- layoutMax = {
--   -- App, Title, Display, Unit, Frame, Full Frame
--   {nil, nil, hs.layout.maximized, nil, nil}
-- }

cmd = {}

function cmd.snapWindowLeft()
  hs.window.focusedWindow():moveToUnit(hs.layout.left50)
end

function cmd.snapWindowRight()
  hs.window.focusedWindow():moveToUnit(hs.layout.right50)
end

function cmd.maximizeWindow()
  hs.window.focusedWindow():moveToUnit(hs.layout.maximized)
end

function cmd.maximizeAllWindows()
  for _, window in ipairs(hs.window:orderedWindows()) do
    window:moveToUnit(hs.layout.maximized)
  end
end

function cmd.keyboardDateTime()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d %H.%M.%S"))
end

function cmd.keyboardDate()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d"))
end

function cmd.reload()
  hs.reload()
end

function cmd.toggleConsole()
  hs.toggleConsole()
end


hs.window.animationDuration = 0

hs.alert.defaultStyle.fillColor = {white = 0.1, alpha = 1}
hs.alert.defaultStyle.strokeColor = {white = 0.1, alpha = 0}
hs.alert.defaultStyle.strokeWidth = 0
hs.alert.defaultStyle.textSize = 24
hs.alert.defaultStyle.radius = 8
hs.alert.defaultStyle.fadeInDuration = 0
hs.alert.defaultStyle.fadeOutDuration = 0

prefix = {"ctrl", "alt"}

hs.hotkey.bind(prefix, "j", snapWindowLeft)
hs.hotkey.bind(prefix, "l", snapWindowRight)
hs.hotkey.bind(prefix, "space", maximizeWindow)
hs.hotkey.bind(prefix, "m", maximizeAllWindows)
hs.hotkey.bind(prefix, "t", keyboardDateTime)
hs.hotkey.bind(prefix, "d", keyboardDate)
hs.hotkey.bind(prefix, "r", reload)
hs.hotkey.bind(prefix, "c", toggleConsole)

hs.alert.show("hammerspoon", 0.5)
