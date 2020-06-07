-- Assignment 6
-- Created by: Thomas Kushner
-- ICS2O
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
local logo
local jet
local panzer
local scrollXSpeed = 8
local scrollYSpeed = -3
local trumpetSound = audio.loadSound("Sounds/horn.mp3")
local trumpetSoundsChannel

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the beetleship across the screen
local function moveJet( event )
    jet.x = jet.x + scrollXSpeed
    jet.y = jet.y + scrollYSpeed
end

-- The function that changes the transparency of the panzer
local function fadePanzer( event )
    panzer.alpha = panzer.alpha - 0.01
end

-- This funtion moves the panzer
local function movePanzer ( event )
    panzer.x = panzer.x + scrollXSpeed
    panzer.y = panzer.y + scrollYSpeed
end
   
-- This function fades out the logo
local function FadeLogo( event )
    logo.alpha = logo.alpha - 0.001
end
-- The function that will go to the main menu 
local function gotoMainMenu( event )
    
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    display.newImageRect("Images/logo.png", 1000, 500)
    display.newImageRect("Images/jet.png", 200, 100)
    display.newImageRect("Images/panzer.png", 300, 200)

    -- set the initial x and y position of the objects
    logo.x = 500
    logo.y = contentHeight/2

    jet.x = 200
    jet.y = contentHeight/5

    panzer.x = 200
    panzer.y = contentHeight/7

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( logo )
    sceneGroup:insert( jet )
    sceneGroup:insert( panzer )

end 

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
        trumpetSoundsChannel = audio.play(trumpetSound )

    

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end 
-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
local function scene hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(trumpetSoundsChannel)
    end


-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    
-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", moveJet )
scene:addEventListener( "show", fadePanzer )
scene:addEventListener( "hide", movePanzer )
scene:addEventListener( "destroy", FadeLogo )

-----------------------------------------------------------------------------------------

return scene
