-- main.lua

local globalData = require("src.globalData")
local sound = require ("src.sound")
local composer = require( "composer" )
local widget = require "widget"
-- local now = require("now")
-- local gameOver = require("gameOver")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


-- Hide status bar
display.setStatusBar(display.HiddenStatusBar)

local bgmPlayer, sfxClickPlayer

local aboutDetailGroup = display.newGroup()
local instructionDetailGroup = display.newGroup()
local settingDetailGroup = display.newGroup()
local soundDetailGroup = display.newGroup()

-- title teks
local aboutTitle, instructionTitle, soundTitle, gameOverTitle

-- object
local background, backgroundBlur
local playBtn, instructionBtn, aboutBtn, settingBtn, soundOptionBtn -- optimize : use local variable
local aboutTitleTxt, instructionTitleTxt, instructionTxt, aboutTxt, settingTitleTxt, soundtTitleTxt, soundTxt
local tapAtas, tapBawah, skill, roket, logo
local instructionClose, aboutClose, settingClose


local function onPlayBtnRelease()
	bgmPlayer:stopSound()
	-- audio.stop( menuMusicChannel )

	composer.removeScene("src.play", false)
	composer.gotoScene("src.now", "zoomInOutFade", 50)
	return true
end

local function onAboutBtnRelease()
	sfxClickPlayer:playSfx()
	backgroundBlur.isVisible = true
	background.isVisible = false
	-- background.fill.effect = "filter.blurGaussian"

	transition.to(aboutDetailGroup, {time = 200, alpha = 1})
	playBtn.isVisible = false
	aboutBtn.isVisible = false
	instructionBtn.isVisible = false
	nextBtn.isVisible = true
	-- settingBtn.isVisible = false
	aboutDetailGroup.isVisible = true
	return true
end

-- local function onSettingBtnRelease()
	-- sfxClickPlayer:playSfx()

	-- transition.to(settingDetailGroup, {time = 200, alpha = 1})
	-- playBtn.isVisible = false
	-- aboutBtn.isVisible = false
	-- instructionBtn.isVisible = false
	-- settingBtn.isVisible = false
	-- settingDetailGroup.isVisible = true
	-- return true
-- end

local function onInstructionBtnRelease()
	sfxClickPlayer:playSfx()
	backgroundBlur.isVisible = true
	background.isVisible = false
	-- background.fill.effect = "filter.blurGaussian"

	transition.to(instructionDetailGroup, {time = 200, alpha = 1})
	playBtn.isVisible = false
	aboutBtn.isVisible = false
	instructionBtn.isVisible = false
	-- settingBtn.isVisible = false
	instructionDetailGroup.isVisible = true
	return true
end

local function onCloseAboutRelease()
	backgroundBlur.isVisible = false
	background.isVisible = true
	sfxClickPlayer:playSfx()
	
	transition.to(aboutDetailGroup, {time = 200, alpha = 0})
	-- background.fill.effect = "filter.blurGaussian = 0"
	playBtn.isVisible = true
	aboutBtn.isVisible = true
	instructionBtn.isVisible = true
	beforeBtn.isVisible = false
	nextBtn.isVisible = false
	-- settingBtn.isVisible = true
	instructionDetailGroup.isVisible = false
	return true
end

local function onCloseInstructionRelease()
	backgroundBlur.isVisible = false
	background.isVisible = true
	sfxClickPlayer:playSfx()

	transition.to(instructionDetailGroup, {time = 200, alpha = 0, alpha=0})
	-- background.fill.effect = "filter.blurGaussian = 0"
	playBtn.isVisible = true
	aboutBtn.isVisible = true
	instructionBtn.isVisible = true
	-- settingBtn.isVisible = true
	instructionDetailGroup.isVisible = false
	return true
end

local function onCloseSoundRelease()
	backgroundBlur.isVisible = false
	background.isVisible = true
	sfxClickPlayer:playSfx()

	transition.to(soundDetailGroup, {time = 200, alpha = 0})
	-- background.fill.effect = "filter.blurGaussian = 0"
	playBtn.isVisible = true
	aboutBtn.isVisible = true
	instructionBtn.isVisible = true
	beforeBtn.isVisible = false
	nextBtn.isVisible = false
	-- settingBtn.isVisible = true
	soundDetailGroup.isVisible = false
	return true
end

local function onNextBtnRelease()
	sfxClickPlayer:playSfx()

	transition.to(soundDetailGroup, {time = 200, alpha = 1})
	-- background.fill.effect = "filter.blurGaussian"
	playBtn.isVisible = false
	aboutBtn.isVisible = false
	instructionBtn.isVisible = false
	nextBtn.isVisible = false
	beforeBtn.isVisible = true
	-- settingBtn.isVisible = true
	aboutDetailGroup.isVisible = false
	soundDetailGroup.isVisible = true
	return true
end

local function onBeforeBtnRelease()
	sfxClickPlayer:playSfx()

	transition.to(aboutDetailGroup, {time = 200, alpha = 1})
	-- background.fill.effect = "filter.blurGaussian"
	playBtn.isVisible = false
	aboutBtn.isVisible = false
	instructionBtn.isVisible = false
	beforeBtn.isVisible = false
	nextBtn.isVisible = true
	-- settingBtn.isVisible = true
	soundDetailGroup.isVisible = false
	aboutDetailGroup.isVisible = true
	return true
end

-- local function onCloseSettingRelease()

	-- transition.to(settingDetailGroup, {time = 200, alpha = 0})
	-- playBtn.isVisible = true
	-- aboutBtn.isVisible = true
	-- instructionBtn.isVisible = true
	-- settingBtn.isVisible = true
	-- settingDetailGroup.isVisible = false
	-- return true
-- end

-- local function onSoundOptionBtnRelease()
	-- soundOptionOffBtn.isVisible = true
	-- soundOptionOffBtn.isVisible = false
	-- now.soundDisable()
	-- gameOver.soundDisable()
	-- audio.stop( menuMusicChannel )
	-- audio.stop( tapSound )
	-- audio.stop( backMusicChannel )
	-- audio.stop( collisionSound )
	-- audio.stop( powerUpSound )
	-- audio.stop( gameOverMusicChannel )
	-- audio.stop( 1 )
	-- audio.pause( clickSound )
-- end


	-- "scene:create()"
function scene:create( event )

	local sceneGroup = self.view

	-- sound
	bgmPlayer = sound.new(globalData.bgmChannel)
	bgmPlayer:loadSound("sound/Ambler.mp3")
	
	bgmPlayer:playBgm()
	
	sfxClickPlayer = sound.new(globalData.bgmChannel)
	sfxClickPlayer:loadSound("sound/clickSound.mp3")
	
	
	-- menuSound = audio.loadSound( "sound/menuSound.mp3" )
	-- menuMusicChannel = audio.play( menuSound, { channel=1, loops=-1, fadein=3000 } )
	

background = display.newImageRect("Gambar3/imageHome.png", 565, 350)
	background.x = display.contentCenterX
	background.y = display.contentCenterY + 15
	-- background.anchorX = 0
	-- background.anchorY = 0
	background.isVisible = true

backgroundBlur = display.newImageRect("Gambar3/imageHomeBlur.png", 565, 350)
	backgroundBlur.x = display.contentCenterX
	backgroundBlur.y = display.contentCenterY + 15
	-- backgroundBlur.anchorX = 0
	-- backgroundBlur.anchorY = 0
	backgroundBlur.isVisible = false

local aboutDetail = display.newRoundedRect(display.contentCenterX, display.contentCenterY, 400, 300, 10)
	aboutDetail:setFillColor(0,0,0)
	aboutDetail:setStrokeColor(1,1,1)
	aboutDetail.strokeWidth = 5
	aboutDetail.alpha = 0.50 -- transparency
	aboutDetailGroup:insert(aboutDetail)
	aboutDetailGroup.isVisible = false
	
local instructionDetail = display.newRoundedRect(display.contentCenterX, display.contentCenterY, 400, 300, 10)
	instructionDetail:setFillColor(0,0,0)
	instructionDetail:setStrokeColor(1,1,1)
	instructionDetail.strokeWidth = 5
	instructionDetail.alpha = 0.50 -- transparency
	instructionDetailGroup:insert(instructionDetail)
	instructionDetailGroup.isVisible = false
	
local soundDetail = display.newRoundedRect(display.contentCenterX, display.contentCenterY, 400, 300, 10)
	soundDetail:setFillColor(0,0,0)
	soundDetail:setStrokeColor(1,1,1)
	soundDetail.strokeWidth = 5
	soundDetail.alpha = 0.50 -- transparency
	soundDetailGroup:insert(soundDetail)
	soundDetailGroup.isVisible = false
	
	-- local settingDetail = display.newRoundedRect(display.contentCenterX, display.contentCenterY, 400, 300, 10)
	-- settingDetail:setFillColor(0,0,0)
	-- settingDetail:setStrokeColor(1,1,1)
	-- settingDetail.strokeWidth = 5
	-- settingDetail.alpha = 0.50 -- transparency
	-- settingDetailGroup:insert(settingDetail)
	-- settingDetailGroup.isVisible = false
	
------------- MM BUTTON ----------
playBtn = widget.newButton
	{
		-- label = "Play        ",
		font = "font",
		-- fontSize = 15,
		defaultFile = "Gambar3/play.png",
		overFile = "Gambar3/playPress.png",
		width = 100,
		height = 50,
		-- textOnly = true,
		onRelease = onPlayBtnRelease -- listener, methodnya harus sudah di declare di atas
	}
	playBtn.x = 380 -- todo move to constant
	playBtn.y = display.contentHeight *3/5
	playBtn.isVisible = true

instructionBtn = widget.newButton
	{
		-- label = "Instruction",
		font = "font",
		-- fontSize = 10,
		defaultFile = "Gambar3/instruction.png",
		overFile = "Gambar3/instructionPress.png",
		width = 60,
		height = 60,
		-- textOnly = true,
		onRelease = onInstructionBtnRelease -- listener, methodnya harus sudah di declare di atas
	}
	instructionBtn.x = 330 -- todo move to constant
	instructionBtn.y = display.contentHeight *5/6
	instructionBtn.isVisible = true
	
aboutBtn = widget.newButton
	{ 
		-- label = "About      ",
		font = "font",
		-- fontSize = 15,
		defaultFile = "Gambar3/about.png",
		overFile = "Gambar3/aboutPress.png",
		width = 60,
		height = 60,
		-- labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
		-- textOnly = true,
		onRelease = onAboutBtnRelease -- listener, methodnya harus sudah di declare di atas
	}
	aboutBtn.x = 440 -- todo move to constant
	aboutBtn.y = display.contentHeight *5/6
	aboutBtn.isVisible = true

nextBtn = widget.newButton
	{ 
		-- label = "About      ",
		font = "font",
		-- fontSize = 15,
		defaultFile = "Gambar3/next.png",
		overFile = "Gambar3/nextPress.png",
		width = 40,
		height = 40,
		-- labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
		-- textOnly = true,
		onRelease = onNextBtnRelease -- listener, methodnya harus sudah di declare di atas
	}
	nextBtn.x = 400 -- todo move to constant
	nextBtn.y = display.contentHeight *5/6
	nextBtn.isVisible = false
	aboutDetailGroup:insert(nextBtn)
	
beforeBtn = widget.newButton
	{ 
		-- label = "About      ",
		font = "font",
		-- fontSize = 15,
		defaultFile = "Gambar3/previous.png",
		overFile = "Gambar3/previousPress.png",
		width = 40,
		height = 40,
		-- labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
		-- textOnly = true,
		onRelease = onBeforeBtnRelease -- listener, methodnya harus sudah di declare di atas
	}
	beforeBtn.x = 80 -- todo move to constant
	beforeBtn.y = display.contentHeight *5/6
	beforeBtn.isVisible = false
	soundDetailGroup:insert(beforeBtn)

	-- settingBtn = widget.newButton
	-- { 
		-- label = "About      ",
		-- font = "font",
		-- fontSize = 15,
		-- defaultFile = "Gambar3/setting.png",
		-- overFile = "Gambar3/settingPress.png",
		-- width = 60,
		-- height = 60,
		-- labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
		-- textOnly = true,
		-- onRelease = onSettingBtnRelease -- listener, methodnya harus sudah di declare di atas
	-- }
	-- settingBtn.x = 380 -- todo move to constant
	-- settingBtn.y = display.contentHeight *5/6
	-- settingBtn.isVisible = true
	
	-- soundOptionOnBtn = widget.newButton
	-- {
		-- label = "Sound : ON",
		-- font = "childsPlay",
		-- fontSize = 20,
		-- labelColor = { default=mainMenuItemColor, over=mainMenuItemColorOver },
		-- defaultFile = "Gambar3/soundOn.png",
		-- overFile = "Gambar3/soundOn.png",
		-- width = 200,
		-- height = 70,
		-- onRelease = onSoundOptionBtnRelease
	-- }
	-- soundOptionOnBtn.x = display.contentCenterX
	-- soundOptionOnBtn.y = display.contentCenterY + 20
	-- soundOptionOnBtn.isVisible = true
	-- settingDetailGroup:insert(soundOptionOnBtn)
	
	-- soundOptionOffBtn = widget.newButton
	-- {
		-- label = "Sound : ON",
		-- font = "childsPlay",
		-- fontSize = 20,
		-- labelColor = { default=mainMenuItemColor, over=mainMenuItemColorOver },
		-- defaultFile = "Gambar3/soundOff.png",
		-- overFile = "Gambar3/soundOff.png",
		-- width = 200,
		-- height = 70,
		-- onRelease = onSoundOptionBtnRelease
	-- }
	-- soundOptionOffBtn.x = display.contentCenterX
	-- soundOptionOffBtn.y = display.contentCenterY + 20
	-- soundOptionOffBtn.isVisible = false
	-- settingDetailGroup:insert(soundOptionOffBtn)
---------------- END MM BUTTON --------------
	
	-----------------------------------------------------------
	-- untuk title teks
	-----------------------------------------------------------
	aboutTitle = display.newImageRect("Gambar3/aboutTitle.png", 130, 40)
	aboutTitle.x = display.contentCenterX
	aboutTitle.y = 50
	aboutDetailGroup:insert(aboutTitle)
	
	soundTitle = display.newImageRect("Gambar3/soundTitle.png", 130, 40)
	soundTitle.x = display.contentCenterX
	soundTitle.y = 50
	soundDetailGroup:insert(soundTitle)
	
	instructionTitle = display.newImageRect("Gambar3/instructionTitle.png", 160, 40)
	instructionTitle.x = display.contentCenterX
	instructionTitle.y = 50
	instructionDetailGroup:insert(instructionTitle)
	
	-----------------------------------------------------------
	-- untuk teks
	-----------------------------------------------------------
	-- local aboutTitle =
	-- {
		-- text = "About",
		-- font = "font",
		-- fontSize = 42,
		-- x = display.contentCenterX,
		-- y = 50,
	-- }
	-- local instructionTitle =
	-- {
		-- text = "Instruction",
		-- font = "font",
		-- fontSize = 42,
		-- x = display.contentCenterX,
		-- y = 50,
	-- }
	-- local soundTitle =
	-- {
		-- text = "Sound",
		-- font = "font",
		-- fontSize = 42,
		-- x = display.contentCenterX,
		-- y = 50,
	-- }
	local instruction =
	{
		text = "Tombol atas untuk melompat\n \nTombol bawah untuk terjun\n \nAktifkan tombol kemampuan\n \nHindari roket untuk mendapat nilai",
		font = "font",
		fontSize = 20,
		x = display.contentCenterX + 25,
		y = 170,
	}
	local about =
	{
		text = "Programmer: Topan Ardianto\nIlustrator: Topan dan Yuenia\nLayout: Fandy\n \nSupport by:",
		font = "font",
		fontSize = 20,
		x = display.contentCenterX,
		y = 150,
	}
	local sound =
	{
		text = "\"Ambler\" Kevin MacLeod (incompetech.com)\nLicensed under Creative Commons:\nBy Attribution 3.0\n \nthemushroomkingdom.net",
		font = "font",
		fontSize = 18,
		x = display.contentCenterX,
		y = 150,
	}
	
-------------- Embossed Text -----------
-- aboutTitleTxt = display.newEmbossedText(aboutTitle)
	-- aboutTitleTxt:setFillColor(250/255, 239/255, 207/255)
	-- aboutDetailGroup:insert(aboutTitleTxt)
	-- local color = 
	-- {
		-- highlight = { r=135/255, g=201/255, b=237/255 },
		-- shadow = { r=135/255, g=201/255, b=237/255 }
	-- }
	-- aboutTitleTxt:setEmbossColor( color )
	-- aboutTitleTxt.strokeWidth = 5
	-- aboutTitleTxt:setStrokeColor(135/255, 201/255, 237/255)
	
-- instructionTitleTxt = display.newEmbossedText(instructionTitle)
	-- instructionTitleTxt:setFillColor(250/255, 239/255, 207/255)
	-- instructionDetailGroup:insert(instructionTitleTxt)
	-- local color1 = 
	-- {
		-- highlight = { r=135/255, g=201/255, b=237/255 },
		-- shadow = { r=135/255, g=201/255, b=237/255 }
	-- }
	-- instructionTitleTxt:setEmbossColor( color1 )
	
-- soundTitleTxt = display.newEmbossedText(soundTitle)
	-- soundTitleTxt:setFillColor(250/255, 239/255, 207/255)
	-- soundDetailGroup:insert(soundTitleTxt)
	-- local color2 = 
	-- {
		-- highlight = { r=135/255, g=201/255, b=237/255 },
		-- shadow = { r=135/255, g=201/255, b=237/255 }
	-- }
	-- soundTitleTxt:setEmbossColor( color2 )
	
instructionTxt = display.newText(instruction)
	instructionTxt:setFillColor(250/255, 239/255, 207/255)
	instructionDetailGroup:insert(instructionTxt)
	
aboutTxt = display.newText(about)
	aboutTxt:setFillColor(250/255, 239/255, 207/255)
	aboutDetailGroup:insert(aboutTxt)
	
soundTxt = display.newText(sound)
	soundTxt:setFillColor(250/255, 239/255, 207/255)
	soundDetailGroup:insert(soundTxt)
	
-- settingTitleTxt = display.newEmbossedText(settingTitle)
	-- settingTitleTxt:setFillColor(250/255, 239/255, 207/255)
	-- settingDetailGroup:insert(settingTitleTxt)
	-- local color = 
	-- {
		-- highlight = { r=135/255, g=201/255, b=237/255 },
		-- shadow = { r=135/255, g=201/255, b=237/255 }
	-- }
	-- settingTitleTxt:setEmbossColor( color )
	-- settingTitleTxt.strokeWidth = 5
	-- settingTitleTxt:setStrokeColor(135/255, 201/255, 237/255)
------------------ END TEXT ---------------------

-------------- INSTRUCTION ------------------
tapAtas = display.newImageRect("Gambar3/buttonUp.png", 30, 30)
	tapAtas.x = 70 
	tapAtas.y = display.contentCenterY - 55
	instructionDetailGroup:insert(tapAtas)
	
tapBawah = display.newImageRect("Gambar3/buttonDown.png", 30, 30)
	tapBawah.x = 70
	tapBawah.y = display.contentCenterY - 10
	instructionDetailGroup:insert(tapBawah)
	
skill = display.newImageRect("Gambar3/pu1.png", 30, 30)
	skill.x = 70
	skill.y = display.contentCenterY + 35
	instructionDetailGroup:insert(skill)
	
roket = display.newImageRect("Gambar3/rudal.png", 40, 20)
	roket.x = 70
	roket.y = display.contentCenterY + 80
	instructionDetailGroup:insert(roket)
	
logo = display.newImageRect("Gambar3/sekolahGame.png", 100, 50)
	logo.x = display.contentCenterX
	logo.y = display.contentHeight - 70
	aboutDetailGroup:insert(logo)
------------ END INSTRUCTION --------------------
	
	
	-------------------------------------------------------
	-- close button
	-------------------------------------------------------
instructionClose = widget.newButton
	{
		label = "X",
		font = "font",
		fontSize = 27,
		labelColor = { default={ 250/255, 239/255, 207/255 }, over={ 0, 0, 0, 0.5 } },
		textOnly = true,
		onRelease = onCloseInstructionRelease
	}
	instructionClose.x = display.contentWidth - 60
	instructionClose.y = 35
	instructionDetailGroup:insert(instructionClose)
	
aboutClose = widget.newButton
	{
		label = "X",
		font = "font",
		fontSize = 27,
		labelColor = { default={ 250/255, 239/255, 207/255 }, over={ 0, 0, 0, 0.5 } },
		textOnly = true,
		onRelease = onCloseAboutRelease
	}
	aboutClose.x = display.contentWidth - 60
	aboutClose.y = 35
	aboutDetailGroup:insert(aboutClose)
	
soundClose = widget.newButton
	{
		label = "X",
		font = "font",
		fontSize = 27,
		labelColor = { default={ 250/255, 239/255, 207/255 }, over={ 0, 0, 0, 0.5 } },
		textOnly = true,
		onRelease = onCloseSoundRelease
	}
	soundClose.x = display.contentWidth - 60
	soundClose.y = 35
	soundDetailGroup:insert(soundClose)
	
-- settingClose = widget.newButton
	-- {
		-- label = "X",
		-- font = "font",
		-- fontSize = 27,
		-- labelColor = { default={ 250/255, 239/255, 207/255 }, over={ 0, 0, 0, 0.5 } },
		-- textOnly = true,
		-- onRelease = onCloseSettingRelease
	-- }
	-- settingClose.x = display.contentWidth - 60
	-- settingClose.y = 35
	-- settingDetailGroup:insert(settingClose)
---------------- END CLOSE BUTTON -------------------

	-- check channel
	-- local result = audio.usedChannels
	-- print( "channel yang dipakai: " .. result )
	
	sceneGroup:insert(background)
	sceneGroup:insert(backgroundBlur)
	sceneGroup:insert(playBtn)
	sceneGroup:insert(instructionBtn)
	sceneGroup:insert(aboutBtn)
	-- sceneGroup:insert(settingBtn)

	sceneGroup:insert(aboutDetailGroup)
	sceneGroup:insert(instructionDetailGroup)
	sceneGroup:insert(soundDetailGroup)
	sceneGroup:insert(nextBtn)
	sceneGroup:insert(beforeBtn)
	-- sceneGroup:insert(settingDetailGroup)
	-- sceneGroup:insert(soundOptionBtn)
	-- sceneGroup:insert(soundOption2Btn)
	
	
end

-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view
	
	if bgmPlayer then
		bgmPlayer:removeSound()
	end
	
	if sfxClickPlayer then
		sfxClickPlayer:removeSound()
	end
	
	if background then
		background:removeSelf()
		background = nil
	end
	
	if playBtn then
		playBtn:removeSelf()
		playBtn = nil
	end
	
	if instructionBtn then
		instructionBtn:removeSelf()
		instructionBtn = nil
	end
	
	if aboutBtn then
		aboutBtn:removeSelf()
		aboutBtn = nil
	end
	
	if settingBtn then
		settingBtn:removeSelf()
		settingBtn = nil
	end
	
	if soundOptionBtn then
		soundOptionBtn:removeSelf()
		soundOptionBtn = nil
	end

	if aboutTitleTxt then
		aboutTitleTxt:removeSelf()
		aboutTitleTxt = nil
	end

	if instructionTitleTxt then
		instructionTitleTxt:removeSelf()
		instructionTitleTxt = nil
	end

	if instructionTxt then
		instructionTxt:removeSelf()
		instructionTxt = nil
	end

	if aboutTxt then
		aboutTxt:removeSelf()
		aboutTxt = nil
	end

	if settingTitleTxt then
		settingTitleTxt:removeSelf()
		settingTitleTxt = nil
	end
	
	if soundTxt then
		soundTxt:removeSelf()
		soundTxt = nil
	end
	
	if soundTitleTxt then
		soundTitleTxt:removeSelf()
		soundTitleTxt = nil
	end

	if tapAtas then
		tapAtas:removeSelf()
		tapAtas = nil
	end

	if tapBawah then
		tapBawah:removeSelf()
		tapBawah = nil
	end

	if skill then
		skill:removeSelf()
		skill = nil
	end

	if roket then
		roket:removeSelf()
		roket = nil
	end

	if logo then
		logo:removeSelf()
		logo = nil
	end

	if instructionClose then
		instructionClose:removeSelf()
		instructionClose = nil
	end

	if aboutClose then
		aboutClose:removeSelf()
		aboutClose = nil
	end

	if settingClose then
		settingClose:removeSelf()
		settingClose = nil
	end
	
	if soundClose then
		soundClose:removeSelf()
		soundClose = nil
	end
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene