-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local alien
local scrollXSpeed = 8
local scrollYSpeed = -3
local alienSounds = audio.loadSound("Sounds/ufo.mp3")
local alienSoundsChannel


--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the alien across the screen
local function moveAlien()
    alien.x = alien.x + scrollXSpeed
    alien.y = alien.y + scrollYSpeed
    alien.alpha = alien.alpha - 0.01
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu", {effect = "fromRight", time = 1000} )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 0, 0, 0)

    -- Insert the beetleship image
    alien = display.newImageRect("Images/ufo.png", 250, 180)

    -- set the initial x and y position of the beetleship
    alien.x = 200
    alien.y = display.contentHeight/2
    alien.alpha = 1

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( alien )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

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

    elseif ( phase == "did" ) then
        -- start the splash screen music
        alienSoundsChannel = audio.play( alienSounds )

        -- Call the moveAlien function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveAlien)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 1500, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(alienSoundsChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene