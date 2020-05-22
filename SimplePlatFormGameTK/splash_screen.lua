-----------------------------------------------------------------------------------------
--
-- intro_screen.lua
-- Created by: Ms Raffin
-- Date: Nov. 22nd, 2014
-- Description: This is the splash screen of the game. It displays the app logo and the 
-- company logo with some sort of animation...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- use the physics library
local physics = require("physics")

-- Name the Scene
sceneName = "splash_screen"

-- Create Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local logo
local bottom

--Spring sound effect
 local springsound = audio.loadSound( "Sounds/BoingSoundEffect.mp3" )
 local springSoundChannel

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

--When this function is called, play the springt sound effect
 local function SpringSoundEffect( )
    -- play sound
    springSoundChannel = audio.play(springsound)
 end

--When the game starts, it waits and calls this function
local function SplashStart( )
    timer.performWithDelay(1950, SpringSoundEffect)
end



-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    --Hide the status bar
    display.setStatusBar(display.HiddenStatusBar)

    -- set the background color
    display.setDefault("background", 1, 1, 1)


    -- logo image
    logo = display.newImageRect("Images/CompanyLogoLeo.png", 700, 500)

    -- set the x and y position of the logo
    logo.x = display.contentWidth/2
    logo.y = -300
   
    
    -- create the bottom and set its position on the screen
    bottom = display.newLine(500, 400, 0, 144)
    bottom.x = display.contentCenterX
    bottom.y = 768
    bottom.isVisible = false


    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( logo )
    sceneGroup:insert (bottom)

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