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

-- stop playing the trumpet

hornSoundChannel = audio.stop( trumpet )

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Insert the background image
   backgroundImage = display.newImageRect("Images/bkg.png", 2048, 1536)
   backgroundImage.x = display.contentWidth / 2
   backgroundImage.y = display.contentHeight / 2

    -- Insert the jet
    jet = display.newImageRect("Images/jet.png", 200, 200)
    jet.x = display.contentWidth * 3 / 5
    jet.y = display.contentWidth * 3.5 / 5

    -- Insert the panzer

    panzer = display.newImageRect("Images/panzer.png", 400, 400)
    panzer.x = display.contentWidth/5 
    panzer.y = display.contentHeight*6.1/7

    -- Inset the logo

    logo = display.newImageRect("Images/tLogo.png", 1050, 836)
    logo.x = display.contentWidth /2
    logo.y = display.contentHeight/2

---------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------
        -- start the physics engine
        physics.start()
    
    elseif ( phase == "did" ) then

        --Make the logo dynamic so that it will move
        physics.addBody(logo, "dynamic", {density=0.04, friction=0})

        logo:applyForce( 0, 1000, logo.x, logo.y )

        --make the bottom static so that it won't move
        physics.addBody(bottom, "static")

        -- Call the GameStart function as soon as we enter the frame.
        SplashStart( )

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 4500, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase 

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then

        --Make the logo dynamic so that it will move
        physics.removeBody(logo)

        --make the bottom static so that it won't move
        physics.removeBody(bottom)
        
    elseif ( phase == "did") then

        physics.stop()
    end

    -----------------------------------------------------------------------------------------
end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

----------------------------------------------------------------------

return scene