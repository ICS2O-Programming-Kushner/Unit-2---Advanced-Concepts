-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Thomas Kushner
-- ICS2O
-- Description: 
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local playButton
local creditsButton
local instructionsButton 
local backgroundMusic = audio.loadSound("Sounds/bkg.mp3")
local backgroundMusicChannel
local textObject
-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "slideUp", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "zoomInOutRotate", time = 1000})
end    

-- INSERT LOCAL FUNCTION DEFINITION THAT GOES TO INSTRUCTIONS SCREEN 

-----------------------------------------------------------------------------------------

-- Creating Transition Function to Instructions Page
local function InstructionsTransition( )
    composer.gotoScene( "instructions_screen", {effect = "slideDown", time = 500})
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/logo.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton()
          
            -- Set its position on the screen relative to the screen size
            x = 400
            y = 500
            width = 270
            height = 80

            -- Insert the images here
            defaultFile = newImageRect("Images/greenbutton.png", 200, 100, nil, 50)
            overFile = newImageRect("Images/greenbutton", 200, 100, nil, 50)

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton() 
        
            -- Set its position on the screen relative to the screen size
            x = 300,
            y = 200,
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/bluebutton.png"
            overFile = "Images/bluebutton.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 

    -----------------------------------------------------------------------------------------

    -- Creating Instructions Button 
    instructionsButton = widget.newButton() 
        { 
            -- Set its position on the screen relative to the screen size 
            x = display.contentWidth*1.5/8,
            y = display.contentHeight*6.5/8,
            width = 270,
            height = 80,

            -- Inset the images here 
            defaultFile = "Images/bluebutton.png.png", 
            overFile = "Images/bluebutton.png", 

            -- When the button is released, call the Instuctions transition function
            onRelease = InstructionsTransition
         } )


    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    
    -- INSERT INSTRUCTIONS BUTTON INTO SCENE GROUP

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

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

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then    
    -- Start background music 
    backgroundMusicChannel = audio.play( backgroundMusic )
        
    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        -- Stop background music for this screen 
        audio.stop(backgroundMusicChannel)
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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