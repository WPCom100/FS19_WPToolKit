  --
  -- WPToolKit
  -- A collection of tools for a private server
  --
  -- @author WPCom
  -- @date 03/05/2021
  --
  
WPToolKit = {};

addModEventListener(WPToolKit);


function WPToolKit:loadMap(name)
    
    WPToolKit.isRunning = false
    Player.MAX_PICKABLE_OBJECT_MASS = 999;

end;

function WPToolKit:deleteMap()

end;

function WPToolKit:keyEvent(unicode, sym, modifier, isDown)

end;

function WPToolKit:mouseEvent(posX, posY, isDown, isUp, button)

end;

function WPToolKit:update(dt)

  -- IF IT IS 8PM AND THE MOD IS NOT RUNNING
  if not self.isRunning then
    if g_currentMission.environment.currentHour == 20 then
        
      -- START THE MOD
      self.isRunning = true
      self.speedForward()
  
    end;
  -- IF IT IS 6AM AND THE MOD IS RUNNING
  elseif self.isRunning and g_currentMission.environment.currentHour == 6 then

    -- STOP THE MOD
    self.speedStop()
    self.isRunning = false

  end;
end;

function WPToolKit:draw()

end;

function WPToolKit:keyEvent(unicode, sym, modifier, isDown)
    if isDown and sym == Input.KEY_r and Input.isKeyPressed(Input.KEY_lctrl) then
        if not WPToolKit.isSpeeding then
            WPToolKit.isSpeeding = true;
            WPToolKit.lastTime = g_currentMission.missionInfo.timeScale
			g_currentMission.missionInfo.timeScale = 6000;
        end;
    end;
    
    if not isDown and sym == Input.KEY_r and Input.isKeyPressed(Input.KEY_lctrl) then
        if WPToolKit.isSpeeding then
            WPToolKit.isSpeeding = false;
            g_currentMission.missionInfo.timeScale = WPToolKit.lastTime;
        end;
    end;
end;

function WPToolKit:speedForward()

  renderText(500.0, 500.0, 15.0, "Test Text")

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