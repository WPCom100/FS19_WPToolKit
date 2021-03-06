  --
  -- WPToolKit
  -- A collection of tools for a private server
  --
  -- @author WPCom
  -- @date 03/05/2021
  --
  
WPToolKit = {}

addModEventListener(WPToolKit)


function WPToolKit:loadMap(name)
  WPToolKit.events = {}
  Player.registerActionEvents = Utils.appendedFunction(Player.registerActionEvents, WPToolKit.registerActionEvents);
  Player.updateActionEvents = Utils.appendedFunction(Player.updateActionEvents, WPToolKit.registerActionEvents);
  Player.removeActionEvents = Utils.appendedFunction(Player.removeActionEvents, WPToolKit.removeActionEvents);
  Enterable.onRegisterActionEvents = Utils.appendedFunction(Enterable.onRegisterActionEvents, WPToolKit.registerActionEvents);

  WPToolKit.speedForwardIsRunning = false
  WPToolKit.strongIsEnabled = false
  WPToolKit.DEFAULT_PICKABLE_MASS = Player.MAX_PICKABLE_OBJECT_MASS
end;

function WPToolKit:removeActionEvents()
	WPToolKit.events = {}
end;

function WPToolKit:registerActionEvents()
	WPToolKit.events = {}
	local result, eventName = InputBinding.registerActionEvent(g_inputBinding, "STRONGFARMER", self, WPToolKit.toggleStrongFarmer, false, true, false, true)

	if result then
		table.insert(WPToolKit.events, eventName)
    g_inputBinding:setActionEventTextVisibility(eventName, true)
		g_inputBinding:setActionEventTextPriority(eventName, GS_PRIO_NORMAL)
  end
end;

function WPToolKit:toggleStrongFarmer(actionName, keyStatus, arg3, arg4, arg5)
  if actionName == "STRONGFARMER" then	
    if WPToolKit.strongIsEnabled then 
      Player.MAX_PICKABLE_OBJECT_MASS = WPToolKit.DEFAULT_PICKABLE_MASS;
      WPToolKit.strongIsEnabled = false
    else
      Player.MAX_PICKABLE_OBJECT_MASS = 999
      WPToolKit.strongIsEnabled = true
    end
  end
end;

function WPToolKit:deleteMap()
end;

function WPToolKit:keyEvent(unicode, sym, modifier, isDown)
end;

function WPToolKit:mouseEvent(posX, posY, isDown, isUp, button)
end;

function WPToolKit:update(dt)

  -- IF IT IS 8PM AND THE MOD IS NOT RUNNING
  if not self.speedForwardIsRunning then
    if g_currentMission.environment.currentHour == 20 then
        
      -- START THE MOD
      self.speedForwardIsRunning = true
      self.speedForward()
  
    end;
  -- IF IT IS 6AM AND THE MOD IS RUNNING
  elseif self.speedForwardIsRunning and g_currentMission.environment.currentHour == 6 then

    -- STOP THE MOD
    self.speedStop()
    self.speedForwardIsRunning = false

  end;
end;

function WPToolKit:draw()
end;

function WPToolKit:keyEvent(unicode, sym, modifier, isDown)
end;

function WPToolKit:speedForward()

    -- SAVE PREVIOUS TIME SCALE
    WPToolKit.lastTimeScale = g_currentMission.missionInfo.timeScale
    WPToolKit.lastGrowthScale = g_currentMission.missionInfo.plantGrowthRate

    -- LOWER THE PLANT GROWTH AND UP THE TIME SCALE
    g_currentMission.missionInfo.plantGrowthRate = 2.0
    g_currentMission.missionInfo.timeScale = 60.0

end;

function WPToolKit:speedStop()

    -- LOWER THE PLANT GROWTH AND UP THE TIME SCALE
    g_currentMission.missionInfo.plantGrowthRate = WPToolKit.lastGrowthScale
    g_currentMission.missionInfo.timeScale = WPToolKit.lastTimeScale

end;

function debugTableLogOutput(table, seperator, depth, maxDepth)

  seperator = seperator or "."
  depth = depth or 0
  maxDepth = maxDepth or 5

  if maxDepth == depth then
    return
  end

  for i,j in pairs(table) do
    print("[WPToolKit][debugTableLogOutput] "..seperator..tostring(i).." :: "..tostring(j))
    if type(j) == "table" then
      debugTableLogOutput(j, seperator..".", depth + 1, maxDepth)
    end
  end

end;