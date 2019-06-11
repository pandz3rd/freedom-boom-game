-- now.lua
----------------------------------------------
local globalData = require("src.globalData")
local composer = require( "composer" )
local scene = composer.newScene()

local widget = require "widget"
local physics = require "physics"
physics.start()
-- physics.setDrawMode("hybrid")

-- variabel
------------------------------------------------
score = 0 -- global variable
local speed = 12
local arah = -1
local bg = display.newGroup()
local powerUpActiveGroup = display.newGroup()

------------------------------ local scene variable (will be removed later) -------------------------
-- bg and object
local latar, latar2, background, background1, background2
local darah, tanah, awan
local rudal, rudal1, rudal2
local bruak

-- animation and character
local mySheet
local boy

-- text
local teks_waktu, waktu, scoreTxt, puTitleTxt

-- button
local powerUpBtn, tapBtn, tapBtn2

-- timer
local rudalTime, rudal2Time, awanTime, rudalAtasTime, myTimer

-- sound - for stop and dispose
local backSound, tapSound, tap2Sound, collisionSound, collisionTanahSound, powerUpSound
local backMusicChannel, tapMusicChannel, collisionMusicChannel, powerUpMusicChannel

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

-- backSound = audio.loadSound( "sound/backSound.mp3" )
tapSound = audio.loadSound( "sound/goingUp.wav" )
tap2Sound = audio.loadSound( "sound/goingDown.wav" )
collisionSound = audio.loadSound( "sound/collisionSound.wav" )
collisionTanahSound = audio.loadSound( "sound/collisionTanahSound.wav" )
powerUpSound = audio.loadSound( "sound/powerUp.mp3" )
	
	audio.setVolume( 0.75 )  -- set the master volume
	audio.setVolume( 0.5, { channel=1 } )
-- backMusicChannel = audio.play( backSound, { channel=1, loops=-1, fadein=5000 } )
	
	
	-- objek gambar
	---------------------------------------------------------------
	print("masuk create")
	
latar = display.newImageRect("Gambar3/backgroundLangit.png", 1920, 320)
	latar.x = 0
	latar.y = display.contentCenterY
	
latar2 = display.newImageRect("Gambar3/backgroundLangit.png", 1920, 320)
	latar2.x = 1920
	latar2.y = display.contentCenterY
	
	function scrollLatar(self,event)
		if self.x < -1905 then
			self.x = 1920
		else
			self.x = self.x - 3
		end
	end
 
latar.enterFrame = scrollLatar
Runtime:addEventListener("enterFrame", latar)
	 
latar2.enterFrame = scrollLatar
Runtime:addEventListener("enterFrame", latar2)
	
background = display.newImageRect("Gambar3/backgroundMain.png", 480, 320)
	background.anchorX = 0
	background.anchorY = 0
	background.alpha = 0
	
background1 = display.newImageRect("Gambar3/backgroundDepan.png", 1920, 320)
	background1.x = 1920
	background1.y = display.contentCenterY
	
background2 = display.newImageRect("Gambar3/backgroundDepan.png", 1920, 320)
	background2.x = 0
	background2.y = display.contentCenterY
	
	bg:insert(background1)
	bg:insert(background2)
	
	-- untuk menggeser background
	---------------------------------
	function scrollBackground(self,event)
		if self.x < -1905 then
			self.x = 1920
		else
			self.x = self.x - 5
		end
	end
 
background1.enterFrame = scrollBackground
Runtime:addEventListener("enterFrame", background1)
 
background2.enterFrame = scrollBackground
Runtime:addEventListener("enterFrame", background2)
	
	-- object

	-- local hamengku = display.newImageRect("Gambar2/hamengku.png", 35, 65)
	-- hamengku.x = 50
	-- hamengku.y = display.contentCenterY - 100
	-- hamengku.isVisible = true
	-- hamengku.isFokus = false
	
	-- local hamengku2 = display.newImageRect("Gambar2/hamengkub2.png", 40, 50)
	-- hamengku2.x = 50
	-- hamengku2.y = display.contentCenterY - 100
	-- hamengku2.isVisible = false
bruak = display.newImageRect("Gambar3/bruak.png", 65, 55)
	bruak.x = 65
	bruak.y = display.contentHeight - 25
	bruak.isVisible = false
	
darah = display.newImageRect("Gambar3/darah.png", 50, 50)
	darah.x = 65
	darah.y = display.contentCenterY - 100
	darah.isVisible = false
	
tanah = display.newImageRect("Gambar3/awan.png", 580, 10)
	tanah.x = display.contentCenterX
	tanah.y = display.contentHeight + 20
	tanah.isVisible = false
	
awan = display.newImageRect("Gambar3/awan.png", 291, 90 )
	awan.nama = "awan"
	awan.alpha = 0.40
	
	-- animasi untuk rudal
rudal = display.newImageRect("Gambar3/rudal.png", 80, 30)
	rudal.nama = "rudal"
rudal1 = display.newImageRect("Gambar3/rudal.png", 80, 30)
	rudal1.nama = "rudal1"
rudal2 = display.newImageRect("Gambar3/rudal.png", 80, 30)
	rudal2.nama = "rudal2"
	
	-- function soundDisable()
		-- audio.stop( backMusicChannel )
		-- audio.stop( tapSound )
		-- audio.stop( collisionSound )
		-- audio.stop( powerUpSound )
	-- end
	
	
	-- random rudal 1
	local function randomRudal()
		-- print(rudal.x, rudal.y )
		rudal.x = display.contentWidth + 50
		rudal.y = 45+math.random()*250
	end
	rudalTime = timer.performWithDelay(2500, randomRudal, -1)
	
	-- random rudal 2
	local function duaRudal()
		rudal1.x = display.contentWidth + 50
		rudal1.y = 45+math.random()*280
	end
	rudal2Time = timer.performWithDelay(13000, duaRudal, -1)
	
	-- random awan
	local function awanMuncul()
		awan.x = display.contentWidth + 50
		awan.y = 150+math.random()*280
	end
	awanTime = timer.performWithDelay(3800, awanMuncul, -1)
	
	-- masuk ke game over
	local function gameOver()
		-- audio.stop( backMusicChannel )
	
		composer.removeScene("src.now", false)
		composer.gotoScene("src.gameOver","crossFade", 200)
		print("game over dipanggil")
		-- return true
	end
	
	-- animasi untuk Hamengku
local sheetData = { width=50, height=62, numFrames=2, sheetContentWidth=100, sheetContentHeight=62 }

mySheet = graphics.newImageSheet( "Gambar3/12a.png", sheetData )
local sequenceData = 
	{
		{ name = "jump1", start=1, count=2, time=800 }
	}

-- hamengku
boy = display.newSprite( mySheet, sequenceData )
	boy.x = 65  --center the sprite horizontally
	boy.y = display.contentCenterY - 100  --center the sprite vertically
	boy:play()
	
-- local boy2 = display.newImageRect("Gambar3/4.png", 46, 40)
	-- boy2.x = 50
	-- boy2.y = display.contentCenterY - 100
	-- boy2.isVisible = false
	
-- trying to bug on top
if boy.y > 1 and boy.y < 65 then
	local function munculRudalAtas()
		rudal2.x = display.contentWidth + 50
		rudal2.y = 5+math.random()*20
	end
	rudalAtasTime = timer.performWithDelay(4600, munculRudalAtas, -1)
end

	-- bila di tap
function onTouch(event)
	if event.phase == "began" then
		print( "You touched the object!" )
		audio.stop(tapMusicChannel)
		tapMusicChannel = audio.play( tapSound, { channel=globalData.sfxTapChannel} )
			
		-- untuk animasi saat disentuh
		boy.isVisible = true
		darah.y = boy.y - 10
			
		-- boy2.isVisible = true
		-- boy2.y = boy.y

		-- hamengku2:setLinearVelocity(0, -100)
		boy:setLinearVelocity(0, -120)
	elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
		-- boy.isVisible = true
		-- boy2.isVisible = false
	end
	-- end
end

function onTouch2(event)
	if event.phase == "began" then
		print( "You touched the object!" )
		audio.stop(tapMusicChannel)
		tapMusicChannel = audio.play( tap2Sound, { channel=globalData.sfxTapChannel} )
		
		-- untuk animasi saat disentuh
		boy.isVisible = true
		darah.y = boy.y - 10
		-- boy2.isVisible = false
		-- boy2.y = boy.y

		boy:setLinearVelocity(0, 120)
		-- hamengku2:setLinearVelocity(0, -100)
	elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
	
	end
	-- end
end

	-- timer.performWithDelay(20, background)
	-- local isTabrakan = false
tapBtn = widget.newButton
	{
		-- label = "Play        ",
		-- fontSize = 20,
		defaultFile = "Gambar3/buttonUp.png",
		overFile = "Gambar3/buttonUpPress.png",
		width = 70,
		height = 70,
		-- textOnly = true,
		onRelease = onTouch -- listener, methodnya harus sudah di declare di atas
	}
	tapBtn.x = 470 -- todo move to constant
	tapBtn.y = display.contentHeight *5/6
	-- tapBtn.isVisible = true
	
	
tapBtn2 = widget.newButton
	{
		-- label = "Play        ",
		-- fontSize = 20,
		defaultFile = "Gambar3/buttonDown.png",
		overFile = "Gambar3/buttonDownPress.png",
		width = 70,
		height = 70,
		-- textOnly = true,
		onRelease = onTouch2 -- listener, methodnya harus sudah di declare di atas
	}
	tapBtn2.x = 10 -- todo move to constant
	tapBtn2.y = display.contentHeight *5/6
	
	-- coliision
------------------------------------------------------
		
local function onCollisionLose(event)
	print("terdapat sentuhan")
    if ( event.phase == "began" ) then
	
		collisionMusicChannel = audio.play( collisionSound, {channel=globalData.sfxCollisionChannel} )
		
		--hapus semua listener dan phisics body
		local function delFunction()
			rudal:removeEventListener( "collision", onCollisionLose )
			rudal1:removeEventListener( "collision", onCollisionLose )
			rudal2:removeEventListener( "collision", onCollisionLose )

			physics.removeBody(boy)
			physics.removeBody(tanah)
			physics.removeBody(rudal)
			physics.removeBody(rudal1)
			physics.removeBody(rudal2)
			
			----------- remove sound ---------------
	audio.stop()

	audio.dispose( backSound )
	backSound = nil  --prevents the handle from being used again
	
	audio.dispose( tapSound )
	tapSound = nil
	
	audio.dispose( collisionSound )
	collisionSound = nil
	
	audio.dispose( powerUpSound )
	powerUpSound = nil
			
			
			gameOver()		
		end
		
		timerTubruk = timer.performWithDelay(50, delFunction, 1)

    elseif ( event.phase == "ended" ) then
    end

	darah.isVisible = true
end

local function onCollisionTanah(event)
print("terdapat sentuhan")
    if ( event.phase == "began" ) then
	
	bruak.isVisible = true
	boy.isVisible = false
	collisionTanahMusicChannel = audio.play( collisionTanahSound, {channel=globalData.sfxCollisionChannel} )
	
	--hapus semua listener dan phisics body
	local function delFunction()
		rudal:removeEventListener( "collision", onCollisionLose )
		rudal1:removeEventListener( "collision", onCollisionLose )
		rudal2:removeEventListener( "collision", onCollisionLose )
	
		physics.removeBody(boy)
		physics.removeBody(tanah)
		physics.removeBody(rudal)
		physics.removeBody(rudal1)
		physics.removeBody(rudal2)
		
		----------- remove sound ---------------
	audio.stop()

	audio.dispose( backSound )
	backSound = nil  --prevents the handle from being used again
	
	audio.dispose( tapSound )
	tapSound = nil
	
	-- audio.dispose( collisionSound )
	-- collisionSound = nil
	
	audio.dispose( powerUpSound )
	powerUpSound = nil
		
		gameOver()		
	end
	timerTubruk2 = timer.performWithDelay(50, delFunction, 1)
    elseif ( event.phase == "ended" ) then
    end
end

-----------------------------------------------------------------------------------------
-- Tampilkan waktu
-----------------------------------------------------------------------------------------
local timeTxt = 1 --untuk waktu 
teks_waktu = display.newEmbossedText("", display.contentWidth - 40, 20, "font", 20)
	teks_waktu:setFillColor(250/255, 239/255, 207/255)

	local color = 
	{
		highlight = { r=237/255, g=135/255, b=162/255 },
		shadow = { r=237/255, g=135/255, b=162/255 }
	}
	teks_waktu:setEmbossColor( color )
	
	local function waktu( event ) --semakin lama semakin naik speednya
		-- print( timeTxt )
		teks_waktu.text = timeTxt
		timeTxt = timeTxt + 1	
		speed = speed + 0.10
	end
	myTimer = timer.performWithDelay( 1000, waktu, -1 )
	
waktu = display.newEmbossedText("Waktu:", display.contentWidth - 100, 20, "font", 20)
	waktu:setFillColor(250/255, 239/255, 207/255)
	local color2 = 
	{
		highlight = { r=237/255, g=135/255, b=162/255 },
		shadow = { r=237/255, g=135/255, b=162/255 }
	}
	waktu:setEmbossColor( color2 )
	

-----------------------------------------------------
-- Tampilkan score
-----------------------------------------------------
scoreTxt = display.newEmbossedText("Score: 0", 0, 0, "font", 20)
	scoreTxt:setFillColor(250/255, 239/255, 207/255)
	local color3 = 
	{
		highlight = { r=237/255, g=135/255, b=162/255 },
		shadow = { r=237/255, g=135/255, b=162/255 }
	}
	scoreTxt:setEmbossColor( color3 )
	scoreTxt.x = 50
	scoreTxt.y = 20
	
	-- function untuk tambah score
	----------------------------------------
	local function addToScore(num)
		score = score + num
		scoreTxt.text = "Score: " .. score
		scoreTxt:setFillColor(250/255, 239/255, 207/255)
		scoreTxt.x = 50
		scoreTxt.y = 20
		
		print("Score " .. score)
	end
	
	local num
	
	-- text untuk powerUp is Active
	
powerUpActiveGroup =  display.newGroup()

	local function onPowerUpActive()
		transition.to(powerUpActiveGroup, {time = 1000, alpha = 1})
		powerUpActiveGroup.isVisible = true
		return true
	end
	local function onPowerUpDeactive()
		transition.to(powerUpActiveGroup, {time = 300, alpha = 0})
		powerUpActiveGroup.isVisible = false
		return true
	end

local puTeks =
	{
		text = "Power Up is Activated",
		font = "font",
		fontSize = 25,
		x = display.contentCenterX,
		y = 100,
	}
puTitleTxt = display.newText(puTeks)
	puTitleTxt:setFillColor(250/255, 239/255, 207/255)
	powerUpActiveGroup:insert(puTitleTxt)
	powerUpActiveGroup.isVisible = false
	
	
	-- update
	--untuk moving rudal
	function update()
	
	-- awan berjalan
		if awan then
			awan.x = awan.x + (speed*arah);
		end
	-- rudal berjalan
		if rudal then
			rudal.x = rudal.x + (speed*arah);
			
			-- posisi saat pertambah score
			if rudal.x <= 13 and rudal.x >= 0 then
				num = 1
				addToScore(num)
			end
		end
		if rudal1 then
			rudal1.x = rudal1.x + (speed*arah);
			
			-- posisi saat pertambah score
			if rudal1.x <= 14 and rudal1.x >= 0 then
				num = 1
				addToScore(num)
			end
		end
		if rudal2 then
			rudal2.x = rudal2.x + (speed*arah);
			
			-- posisi saat pertambah score
			if rudal2.x <= 14 and rudal2.x >= 0 then
				num = 1
				addToScore(num)
			end
		end
		-- if hamengku out of screen
		-- if boy.y < -20 or boy2.y < -20 then
		if boy.y < -20 then
			boy.y = boy.y * -1
		end

		-- power up muncul disini
		if score >= 5 and score <= 10 then
			powerUpBtn.isVisible = true
		end
		if score >= 30 and score <= 40 then
			powerUpBtn.isVisible = true
		end
	end
	
	local function onPUclicked()
		
		powerUpMusicChannel = audio.play( powerUpSound, {channel=globalData.sfxPowerUpChannel} )
		
		-- if phisicsTime <= 5 then
			physics.removeBody(rudal)
			physics.removeBody(rudal1)
			physics.removeBody(rudal2)
			onPowerUpActive()
		-- end
		
		local function powerUpEnd()
			physics.addBody( rudal, "kinematic", { friction=0.5 } )
			physics.addBody( rudal1, "kinematic", { friction=0.5 } )
			physics.addBody( rudal2, "kinematic", { friction=0.5 } )
			powerUpBtn.isVisible = false
		end
		timer.performWithDelay(3000, powerUpEnd, 1)
		
		local function puDeactive()
			onPowerUpDeactive()
		end
		timer.performWithDelay(4500, puDeactive, 1)
	end
	
	powerUpBtn = widget.newButton
	{
		-- label = "Play        ",
		-- fontSize = 20,
		defaultFile = "Gambar3/pu1.png",
		overFile = "Gambar3/pu1Press.png",
		width = 40,
		height = 40,
		-- textOnly = true,
		onRelease = onPUclicked -- listener, methodnya harus sudah di declare di atas
	}
	powerUpBtn.x = 120 -- todo move to constant
	powerUpBtn.y = display.contentHeight *5/6
	powerUpBtn.isVisible = false

	---------------------------------------------------

	-- add physics
	physics.addBody(boy)
	-- physics.addBody(boy2)
	-- physics.addBody(tanah)
	physics.addBody( rudal, "kinematic", { friction=0.5 } )
	physics.addBody( rudal1, "kinematic", { friction=0.5 } )
	physics.addBody( rudal2, "kinematic", { friction=0.5 } )
	physics.addBody( tanah, "static", { friction=0.2, bounce=0 } )

	-------------------------------------------------------------
	-- sceneGroup
	------------------------------------------------
	sceneGroup:insert(latar)
	sceneGroup:insert(latar2)
	sceneGroup:insert(background1)
	sceneGroup:insert(background2)
	-- sceneGroup:insert(hamengku2)
	sceneGroup:insert(rudal)
	sceneGroup:insert(rudal1)
	sceneGroup:insert(rudal2)
	sceneGroup:insert(teks_waktu)
	sceneGroup:insert(waktu)
	sceneGroup:insert(scoreTxt)
	sceneGroup:insert(tanah)
	sceneGroup:insert(boy)
	sceneGroup:insert(bruak)
	sceneGroup:insert(darah)
	sceneGroup:insert(awan)
	sceneGroup:insert(tapBtn)
	sceneGroup:insert(tapBtn2)
	sceneGroup:insert(powerUpBtn)
	-- sceneGroup:insert(powerUp1)
	
	-- listener
	-------------------------------------------------
	-- air:addEventListener("coliision", onCollisionLose)
	-- hamengku:addEventListener("coliision", indikator)
	tanah:addEventListener( "collision", onCollisionTanah )
	rudal:addEventListener( "collision", onCollisionLose )
	rudal1:addEventListener( "collision", onCollisionLose )
	rudal2:addEventListener( "collision", onCollisionLose )
	Runtime:addEventListener("enterFrame", update)
	tapBtn:addEventListener( "touch", onTouch )
	tapBtn2:addEventListener( "touch", onTouch2 )
	-- batas.collision = onCollisionScore
	-- batas:addEventListener( "collision", batas )

end

-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

	physics.stop()
	-- stop infinite listener!
	Runtime:removeEventListener("enterFrame", update)
	Runtime:removeEventListener("enterFrame", latar)
	Runtime:removeEventListener("enterFrame", latar2)
	Runtime:removeEventListener("enterFrame", background1)
	Runtime:removeEventListener("enterFrame", background2)

	-- stop all infinite timer!
	timer.cancel(myTimer)
	timer.cancel(rudalTime)
	timer.cancel(rudal2Time)
	timer.cancel(awanTime)
	timer.cancel(rudalAtasTime)
	-- timer.cancel(timerTubruk)
	-- timer.cancel(timerTubruk2)
	
	print("remove event")
----- remove bg -----
	if latar then
		latar:removeSelf()
		latar = nil
	end
	if latar2 then
		latar2:removeSelf()
		latar2 = nil
	end
	if background then
		background:removeSelf()
		background = nil
	end
	if background1 then
		background1:removeSelf()
		background1 = nil
	end
	if background2 then
		background2:removeSelf()
		background2 = nil
	end

----- remove object -----
	if darah then
		darah:removeSelf()
		darah = nil
	end
	if tanah then
		tanah:removeSelf()
		tanah = nil
	end
	if awan then
		awan:removeSelf()
		awan = nil
	end	
	if rudal then
		rudal:removeSelf()
		rudal = nil
	end
	if rudal1 then
		rudal1:removeSelf()
		rudal1 = nil
	end
	if rudal2 then
		rudal2:removeSelf()
		rudal2 = nil
	end
	if bruak then
		bruak:removeSelf()
		bruak = nil
	end

------ remove animation & char ------
	if boy then
		boy:removeSelf()
		boy = nil
	end
	if mySheet then
		mySheet = nil
	end

--------- remove text ---------
	if teks_waktu then
		teks_waktu:removeSelf()
		teks_waktu = nil
	end
	if waktu then
		waktu:removeSelf()
		waktu = nil
	end
	if scoreTxt then
		scoreTxt:removeSelf()
		scoreTxt = nil
	end
	if puTitleTxt then
		puTitleTxt:removeSelf()
		puTitleTxt = nil
	end

--------- remove button ---------
	if powerUpBtn then
		powerUpBtn:removeSelf()
		powerUpBtn = nil
	end
	if tapBtn then
		tapBtn:removeSelf()
		tapBtn = nil
	end	
	if tapBtn2 then
		tapBtn2:removeSelf()
		tapBtn2 = nil
	end

----------- remove sound ---------------
	audio.stop()

	audio.dispose( backSound )
	backSound = nil  --prevents the handle from being used again
	
	audio.dispose( tapSound )
	tapSound = nil
	
	audio.dispose( collisionSound )
	collisionSound = nil
	
	audio.dispose( collisionTanahSound )
	collisionTanahSound = nil
	
	audio.dispose( powerUpSound )
	powerUpSound = nil
	

end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene