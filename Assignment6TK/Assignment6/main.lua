---------------------------------------------------------------------
-- Assignment 6
-- Thomas Kushner
-- ICS2O
-- Description: This displays my company logo on the splash screen.
---------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- create background 
local backgroundImage = display.newImageRect("Images/bkg.png", 2048, 1536)

-- Create the objects in the splash screen
local jet = display.newImageRect("Images/jet.png", 200, 200)
local panzer = display.newImageRect("Images/panzer.png", 400, 400)
local logo = display.newImageRect("Images/tLogo.png", 1050, 836)

---------------------------------------------------------------------
-- SOUNDS
---------------------------------------------------------------------
local trumpet = audio.loadSound("Sounds/horn.mp3")
local hornSoundChannel

---------------------------------------------------------------------


-- set the intial (x,y) position of jet
jet.x = 100
jet.y = display.contentHeight/7


-- set the initial (x,y) position of panzer
panzer.x = 350
panzer.y = display.contentHeight/1.7

-- set the initial (x,y) position of logo
logo.x = 500
logo.y = display.contentHeight/2
logo.isVisible = false


-- global variables
scrollSpeed = 10

--------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------

-- Function: MoveJet
-- Input: this function accepts an event listener
-- Output: none
-- Description: this function adds the scroll speed to the x-value of squid
local function MoveJet(event)
    -- add the scroll speed to the x-value of squid
    jet.x = jet.x + scrollSpeed
    
    -- play audio
    hornSoundChannel = audio.play( trumpet )
end

Runtime:addEventListener("enterFrame", MoveJet)

-- Function: MovePanzer
-- Input: this function accepts an event listener
-- Output: none
-- Description: This changes the position of an object
local function MovePanzer(event)
    -- move the tank
    panzer.x = panzer.x - scrollSpeed
end

Runtime:addEventListener("enterFrame", MovePanzer)

-- Function: FadePanzer
-- Input: this function accepts an event listener
-- Output: none
-- Description: This changes the transparency of an object
local function FadePanzer(event)
    -- change the transparency of the object
    panzer.alpha = panzer.alpha - 0.02
end

Runtime:addEventListener("enterFrame", FadePanzer)

-- Function: LOGO
-- Input: this function accepts an event listener
-- Output: none
-- Description: This changes the transparency of an object
local function LOGO( event )
    -- change the transparency of the object
    logo.alpha = logo.alpha + 0.01
end