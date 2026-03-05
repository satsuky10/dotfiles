-- Ctrl double-tap to toggle WezTerm
local ctrlDoubleTapInterval = 0.3 -- seconds
local lastCtrlRelease = 0
local ctrlWasDown = false

local function toggleWezTerm()
  local app = hs.application.find("WezTerm")
  if app then
    if app:isFrontmost() then
      app:hide()
    else
      app:activate()
    end
  else
    hs.application.launchOrFocus("WezTerm")
  end
end

local ctrlTap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(event)
  local flags = event:getFlags()
  local ctrlOnly = flags.ctrl and not (flags.cmd or flags.alt or flags.shift)

  if ctrlOnly then
    ctrlWasDown = true
  elseif ctrlWasDown then
    ctrlWasDown = false
    local now = hs.timer.secondsSinceEpoch()
    if now - lastCtrlRelease < ctrlDoubleTapInterval then
      lastCtrlRelease = 0
      toggleWezTerm()
    else
      lastCtrlRelease = now
    end
  end
end)

ctrlTap:start()
