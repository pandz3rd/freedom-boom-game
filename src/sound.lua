-----------------------------------------------------------------------------------------
--
-- sound.lua - Sound
--
-----------------------------------------------------------------------------------------

-- global var
local globalData = require("src.globalData")
local cSound = {}

function cSound.new( channel ) -- init sound
	local self = {}
	
	self.sounds = {}
	self.channel = channel
	
-------------------------------------------------
	function self:loadSound( soundFile ) -- load sound @param: soundFile = string file name

		if soundFile ~= "" then
			self.sounds.handle = audio.loadSound( soundFile )
			-- print("sound -",soundFile,"loaded to",self.sounds.handle)
			return self.sounds.handle
		end

		return nil
	end
-------------------------------------------------
	function self:playBgm( ) -- play bgm (loop = -1)
		
		local channelActive = audio.isChannelActive(1) -- prevent abuse

		if not(globalData.soundEnable) or channelActive then -- channel pause or stop: don't play (prevent error)
			return false
		end

		local idx = audio.play(self.sounds.handle, {channel=1, loops=-1})

		if idx ~= 0 then
			-- print("play bgm on channel",idx)
			return true
		end
		
		return false
	end
-------------------------------------------------
	function self:playSfx( resumeSfx ) -- play sfx (loop = 1)

		local channelActive = audio.isChannelActive(2)

		if not(globalData.soundEnable) then
			return false
		end

		-- print("resume sfx",resumeSfx)
		if channelActive and not(resumeSfx) then -- if resumeSfx then complete previous sfx
			audio.stop(self.channel)
		end

		local idx = audio.play(self.sounds.handle, {channel=2, loops=0})

		if idx ~= 0 then
			-- print("play sfx on channel",idx)
			return true
		end

		return false
	end
-------------------------------------------------
	function self:playSfxTap( resumeSfx ) -- play sfx (loop = 1)

		local channelActive = audio.isChannelActive(3)

		if not(globalData.soundEnable) then
			return false
		end

		-- print("resume sfx",resumeSfx)
		if channelActive and not(resumeSfx) then -- if resumeSfx then complete previous sfx
			audio.stop(self.channel)
		end

		local idx = audio.play(self.sounds.handle, {channel=3, loops=0})

		if idx ~= 0 then
			-- print("play sfx on channel",idx)
			return true
		end

		return false
	end
-------------------------------------------------
	function self:playSfxCollision( resumeSfx ) -- play sfx (loop = 1)

		local channelActive = audio.isChannelActive(4)

		if not(globalData.soundEnable) then
			return false
		end

		-- print("resume sfx",resumeSfx)
		if channelActive and not(resumeSfx) then -- if resumeSfx then complete previous sfx
			audio.stop(self.channel)
		end

		local idx = audio.play(self.sounds.handle, {channel=4, loops=0})

		if idx ~= 0 then
			-- print("play sfx on channel",idx)
			return true
		end

		return false
	end
-------------------------------------------------
	function self:playSfxPowerUp( resumeSfx ) -- play sfx (loop = 1)

		local channelActive = audio.isChannelActive(5)

		if not(globalData.soundEnable) then
			return false
		end

		-- print("resume sfx",resumeSfx)
		if channelActive and not(resumeSfx) then -- if resumeSfx then complete previous sfx
			audio.stop(self.channel)
		end

		local idx = audio.play(self.sounds.handle, {channel=5, loops=0})

		if idx ~= 0 then
			-- print("play sfx on channel",idx)
			return true
		end

		return false
	end
-------------------------------------------------
	function self:stopSound( ) -- stop sound on self.channel

		if not(globalData.soundEnable) then
			return false
		end

		local idx = audio.stop( self.channel )

		if idx ~= 0 then
			-- print("stop sound on channel",idx)
			return true
		end

		return false
	end
-------------------------------------------------
	function self:pauseSound( ) -- pause sound on self.channel

		if not(globalData.soundEnable) then
			return false
		end	

		local idx = audio.pause( self.channel )

		if idx ~= 0 then
			-- print("pause sound on channel",idx)
			return true
		end

		return false
	end
-------------------------------------------------
	function self:setSoundVolume( volume ) -- set sound volume on self.channel

		if not(globalData.soundEnable) then
			return false
		end

		-- print("set volume on channel",self.channel,"to",volume .. "x")
		return audio.setVolume(volume, {channel=self.channel})
	end
-------------------------------------------------
	function self:removeSound( ) -- remove sound

		audio.stop(self.channel)
		
		-- print("remove sound",self.sounds.handle,"in channel-",self.channel)
		audio.dispose( self.sounds.handle )
		self.sounds.handle = nil
		self.sounds = nil
		self = nil
	end
-------------------------------------------------
	function self:toggleSound() -- sound on/off

		if globalData.soundEnable then
			self:stopSound()
			globalData.soundEnable = false
		else
			globalData.soundEnable = true
			if self.channel == globalData.bgmChannel then
				self:playBgm()
			elseif self.channel <= globalData.numOfChannel then
				self:playSfx()
			end
		end

		
	end
-------------------------------------------------
	return self
	
end

return cSound