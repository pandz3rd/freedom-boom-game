-- gameOver.lua
--------------------------------------
local globalData = require("src.globalData")
local composer = require( "composer" )

local scene = composer.newScene()

local widget = require "widget"
-- local sound = require ("sound")

------------------------------ local scene variable (will be removed later) -------------------------
-- bg and object
local background

-- animation
local sheet1, sheet2, myAnimation

-- button
local rumahBtn, lagiBtn

-- text
local kalahText, kalah2Text
local hasil, highScore, score_record_1, hasil2

-- sound
local gameOverSound, clickSound
local gameOverMusicChannel, backMusicChannel

local gameOverDetail

local color, color1, color2, color3, color4, color5, color6

function onLagiBtnRelease()
	audio.stop( gameOverMusicChannel )
	audio.play( clickSound )
	
	composer.removeScene("src.gameOver", false)
	composer.gotoScene("src.now", "fade", 200)
end

function onRumahBtnRelease()
	audio.stop( gameOverMusicChannel )

	composer.removeScene("src.gameOver", false)
	composer.gotoScene("src.play", "zoomInOutFade", 250)
end


	
	-- tampilkan animasi
	-- local gamOverAnim1 = display.newImage("Gambar/gamOverAnim1.png", display.contentCenterX, display.contentCenterY)
	-- local gamOverAnim2 = display.newImage("Gambar/gamOverAnim2.png", display.contentCenterX, display.contentCenterY)
local options =
	{
		frames =
		{
			-- frame 1
			{
				x = 0,
				y = 0,
				width = 400,
				height = 141
			}
		}
	}

local options2 =
	{
		-- frame 2
		frames =
		{
			{    
				x = 0,
				y = 0,
				width = 400,
				height = 141
			}
		}
	}

sheet1 = graphics.newImageSheet( "Gambar3/help1.png", options )
sheet2 = graphics.newImageSheet( "Gambar3/help2.png", options )

local sequenceData = {
		{ name="seq1", sheet=sheet1, start=1, count=1, time=100, loopCount=10 },
		{ name="seq2", sheet=sheet2, start=1, count=1, time=100, loopCount=10 }
	}
local cur_sequence = "seq1"

myAnimation = display.newSprite( sheet1, sequenceData )
	myAnimation.x = display.contentCenterX
	myAnimation.y = display.contentCenterY + 80

local function mySpriteListener( event )
	
		if ( event.phase == "ended" ) then
		
		if ( cur_sequence == "seq2" ) then
			cur_sequence = "seq1"
		elseif ( cur_sequence == "seq1" ) then
			cur_sequence = "seq2"
		end
 
		-- print(event.phase.."see seq "..cur_sequence)
 
			local thisSprite = event.target --"event.target" references the sprite
			thisSprite:setSequence( cur_sequence ) --switch to "fastRun" sequence
			thisSprite:play() --play the new sequence; it won't play automatically!
		end
	 
	end

	myAnimation:addEventListener( "sprite", mySpriteListener ) 
		
	

-- tampilkan teks
	-- local gameOverText =
	-- {
		-- text = "Game Over",
		-- font = "font",
		-- fontSize = 36,
		-- x = display.contentCenterX,
		-- y = 40,
	-- }
-- kalahText = display.newEmbossedText(gameOverText)
	-- kalahText:setFillColor(135/255, 201/255, 237/255)
	-- local color = 
	-- {
		-- highlight = { r=135/255, g=201/255, b=237/255 },
		-- shadow = { r=135/255, g=201/255, b=237/255 }
	-- }
	-- kalahText:setEmbossColor( color )

	-- local gameOver2Text =
	-- {
		-- text = "Game Over",
		-- font = "font",
		-- fontSize = 35,
		-- x = display.contentCenterX,
		-- y = 40,
	-- }
-- kalah2Text = display.newEmbossedText(gameOver2Text)
	-- kalah2Text:setFillColor(250/255, 239/255, 207/255)
	-- local colors = 
	-- {
		-- highlight = { r=135/255, g=201/255, b=237/255 },
		-- shadow = { r=135/255, g=201/255, b=237/255 }
	-- }
	-- kalah2Text:setEmbossColor( colors )
	


-- coba save data score
--------------------------------------------------------------------
-- Load external libraries
local str = require("src.str") --

-- Set location for saved data
local filePath = system.pathForFile( "data.txt", system.DocumentsDirectory ) --

local dataTable = {}--

-- local new_value = 0

local function saveData()--
	
	--local levelseq = table.concat( levelArray, "-" )
	
	file = io.open( filePath, "w" )--
	
	for k,v in pairs( dataTable ) do--
		file:write( k .. "=" .. v .. "," )--
	end--
	
	io.close( file )--
end--

local function loadData()	--

	local file = io.open( filePath, "r" )--
	
	if file then--

		-- Read file contents into a string
		local dataStr = file:read( "*a" )--
		
		-- Break string into separate variables and construct new table from resulting data
		local datavars = str.split(dataStr, ",")--
		
		dataTableNew = {}--
		
		for i = 1, #datavars do--
			-- split each name/value pair
			local onevalue = str.split(datavars[i], "=")--
			dataTableNew[onevalue[1]] = onevalue[2]--
		end--
	
		io.close( file ) -- important!--

		-- Note: all values arrive as strings; cast to numbers where numbers are expected
		dataTable.numValue = tonumber(dataTableNew["numValue"])--

		
		if(dataTable.numValue == nil) then--
			dataTable.numValue = 0--
		end--
		
	else--
		-- print ("no file found")
		dataTable.numValue = 0--
		dataTable.numValue2 = 0--
		dataTable.numValue3 = 0--
	end--
end--

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
	
	-- background.fill.effect = "filter.blurGaussian"
	print("masuk gameover")
	
	-- sound
	gameOverSound = audio.loadSound( "sound/Ambler.mp3" )
	clickSound = audio.loadSound( "sound/clickSound.mp3" )
	
	background = display.newImageRect("Gambar3/backgroundMain.png", 580, 320)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	
	myAnimation:play()
	
	gameOverDetail = display.newRoundedRect(display.contentCenterX, display.contentCenterY, 400, 300, 25)
	gameOverDetail:setFillColor(0,0,0)
	gameOverDetail:setStrokeColor(1,1,1)
	gameOverDetail.strokeWidth = 5
	gameOverDetail.alpha = 0.70 -- transparency
	
	gameOverTitle = display.newImageRect("Gambar3/gameOverTitle.png", 160, 40)
	gameOverTitle.x = display.contentCenterX
	gameOverTitle.y = 50
	
	-- button
rumahBtn = widget.newButton
	{
		-- label = "X",
		-- fontSize = 10,
		defaultFile = "Gambar3/home.png",
		overFile = "Gambar3/homePress.png",
		width = 50,
		height = 50,
		-- textOnly = true,
		onRelease = onRumahBtnRelease -- listener, methodnya harus sudah di declare di atas
	}
	rumahBtn.x = display.contentCenterX + 70
	rumahBtn.y = display.contentHeight *4/6 + 20
	rumahBtn.isVisible = true

	lagiBtn = widget.newButton
	{
		-- label = "About",
		-- fontSize = 10,
		defaultFile = "Gambar3/replay.png",
		overFile = "Gambar3/replayPress.png",
		width = 50,
		height = 50,
		-- textOnly = true,
		onRelease = onLagiBtnRelease -- listener, methodnya harus sudah di declare di atas
	}
	lagiBtn.x = display.contentCenterX + 150
	lagiBtn.y = display.contentHeight *4/6 + 20
	lagiBtn.isVisible = true
	
	hasil = display.newEmbossedText("Score: ", 0, 0, "font", 22)
	hasil:setFillColor(250/255, 239/255, 207/255)
	color3 = 
	{
		highlight = { r=250/255, g=239/255, b=207/255 },
		shadow = { r=250/255, g=239/255, b=207/255 }
	}
	hasil:setEmbossColor( color3 )
	hasil.x = display.contentCenterX - 100
	hasil.y = 90
	
	highScore = display.newEmbossedText("High Score: ", 0, 0, "font", 22)
	highScore:setFillColor(250/255, 239/255, 207/255)
	color4 = 
	{
		highlight = { r=250/255, g=239/255, b=207/255 },
		shadow = { r=250/255, g=239/255, b=207/255 }
	}
	highScore:setEmbossColor( color4 )
	highScore.x = display.contentCenterX + 100
	highScore.y = 90
	
	score_record_1 = display.newEmbossedText("0",0,0, "font", 50 )
	score_record_1:setFillColor(237/255, 135/255, 162/255)
	color5 = 
	{
		highlight = { r=250/255, g=239/255, b=207/255 },
		shadow = { r=250/255, g=239/255, b=207/255 }
	}
	score_record_1:setEmbossColor( color5 )
	score_record_1.x = display.contentCenterX + 90
	score_record_1.y = 140
	
	hasil2 = display.newEmbossedText("0",0,0, "font", 50 )
	hasil2:setFillColor(135/255, 201/255, 237/255)
	color6 = 
	{
		highlight = { r=250/255, g=239/255, b=207/255 },
		shadow = { r=250/255, g=239/255, b=207/255 }
	}
	hasil2:setEmbossColor( color6 )
	hasil2.x = display.contentCenterX - 100
	hasil2.y = 140
	
	gameOverMusicChannel = audio.play( gameOverSound, { channel=1, loops=-1, fadein=300 } )
	
	sceneGroup:insert(background)
	sceneGroup:insert(gameOverDetail)
	sceneGroup:insert(myAnimation)
	-- sceneGroup:insert(kalahText)
	sceneGroup:insert(gameOverTitle)
	sceneGroup:insert(rumahBtn)
	sceneGroup:insert(lagiBtn)
	sceneGroup:insert(hasil)
	sceneGroup:insert(hasil2)
	sceneGroup:insert(score_record_1)
	sceneGroup:insert(highScore)
	-- sceneGroup:insert(btnFacebook)
	-- sceneGroup:insert(btnTweet)
	
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- print("CHECK new SCORE ... "..new_value)
		
		loadData()
		
		if( score >= dataTable.numValue) then
		
			-- print("yang pertama ... "..dataTable.numValue)
		
			dataTable.numValue3 = dataTable.numValue2
			dataTable.numValue2 = dataTable.numValue
			dataTable.numValue = score
			
			score_record_1.text = tostring(score)
			else
			score_record_1.text = tostring(dataTable.numValue)
		end
			saveData()
			print("masuk save")
		
		
		hasil.text = "Score: "
		hasil2.text = tostring(score)
		highScore.text = "High Score: "
		
		sceneGroup:insert(hasil)
		sceneGroup:insert(hasil2)
		sceneGroup:insert(highScore)
		sceneGroup:insert(score_record_1)
		
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

	
----------- remove bg ---------------
	if background then
		background:removeSelf()
		background = nil
	end

----------- remove animation ---------------
	sheet1 = nil
	sheet2 = nil
	
	myAnimation:removeEventListener( "sprite", mySpriteListener )
	if myAnimation then
		myAnimation:removeSelf()
		myAnimation = nil
	end

----------- remove button ---------------
	if rumahBtn then
		rumahBtn:removeSelf()
		rumahBtn = nil
	end
	
	if lagiBtn then
		lagiBtn:removeSelf()
		lagiBtn = nil
	end

----------- remove text ---------------
	if kalahText then
		kalahText:removeSelf()
		kalahText = nil
	end
	
	if kalah2Text then
		kalah2Text:removeSelf()
		kalah2Text = nil
	end

	if hasil then
		hasil:removeSelf()
		hasil = nil
	end
	
	if highScore then
		highScore:removeSelf()
		highScore = nil
	end

	if score_record_1 then
		score_record_1:removeSelf()
		score_record_1 = nil
	end
	
	if hasil2 then
		hasil2:removeSelf()
		hasil2 = nil
	end

----------- remove sound ---------------
	audio.stop()

	audio.dispose( gameOverSound )
	gameOverSound = nil  --prevents the handle from being used again

	audio.dispose( clickSound )
	clickSound = nil

end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene