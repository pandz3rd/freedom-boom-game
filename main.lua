-- main.lua

local composer = require ("composer")
local globalData = require("src.globalData")

display.setStatusBar(display.HiddenStatusBar)

-- reverse sound
globalData.bgmChannel			= 1 --menuSound(play.lua), backSound(now.lua), gameOverSound(gameOverSound)
globalData.sfxClickChannel		= 2 --clickSound(play.lua)
globalData.sfxTapChannel		= 3 --tapSound(now.lua)
globalData.sfxCollisionChannel	= 4 --collisionSound(now.lua)
globalData.sfxPowerUpChannel	= 5 --powerUpSound(now.lua)

globalData.numOfChannel			= 5 -- num of sound channel
audio.reserveChannels(globalData.numOfChannel) -- reserve channel biar ga dipakai auto-assign
globalData.soundEnable			= true

composer.gotoScene( "src.intro", zoomInOutFade, 500 )

-- local function checkMem()
    -- collectgarbage("collect")
    -- local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    -- print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed")/1048576) )
-- end
-- timer.performWithDelay( 1000, checkMem, 0 )

local function keyEvent(event)
	local exitAlert
	local phase = event.phase
	local keyName = event.keyName
	-- local eventTxt = display.newText(phase .. " " .. keyName .. "", display.contentCenterX, 20, "arial", 20)
	-- eventTxt.width = display.contentWidth
	-- eventTxt:setFillColor(0.5,0,1)
	
	local function onAlertClick(event)
		-- local alertTxt = display.newText("action" .. event.action "", display.contentCenterX, 50, "arial", 20)
		-- eventTxt:setFillColor(0.5,0.5,0.5)
		
		if event.action == "clicked" then
			if event.index == 1 then
				native.cancelAlert(exitAlert)
			elseif event.index == 2 then

				if composer then -- remove all scene and current scene before exit
					composer.removeHidden(false)
					composer.removeScene(composer.getSceneName("current"), false)
				end

				native.requestExit()
			end
		end
	end
	
	if keyName == "back" and phase == "up" then -- bwt tombol back : show exit confirmation
		exitAlert = native.showAlert("KELUAR DARI PERMAINAN", "TENANE CAH ?", {"ORAK","JANE YO ORAK"}, onAlertClick)
		return true -- klw tombol back, tell to device, we handle it !
	end
	
	return false -- untuk tombol lain, return false -> app gak meng-handle key yang dipencet
end
Runtime:addEventListener("key",keyEvent) -- handle hardware key