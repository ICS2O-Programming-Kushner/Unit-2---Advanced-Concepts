-----------------------------------------------------------------------------------------
--
-- SceneTemplate.lua
-- Scene Template (Composer API)
--
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Calling Composer Library
local composer = require( "composer" )

local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "you_win"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- FORWARD REFERENCES
-----------------------------------------------------------------------------------------

-- local variables for the scene
local bkg
local mainMenuButton
local winText
local motiony = 2


-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
local WinSound = audio.loadSound("Sounds/Cheer.m4a")
local youWinSoundChannel

----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- this function transitions to the main menu screen 
local function MainMenuTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomInOut", time = 500})
end

local function moveText( )
    winText.alpha = winText.alpha + 0.0079
    winText.y = winText.y + motiony
end

    
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Display background
    bkg = display.newImage("Images/winBackground.png")
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    bkg.width = display.contentWidth
    bkg.height = display.contentHeight

    -- Display the You Lose! text
    winText = display.newImage("Images/winText.png")
    winText.x = 512
    winText.y = -10
    winText.width = 1024
    winText.height = 768
    winText.alpha = 0
   
   
    -- Associating display objects with this scene 
    sceneGroup:insert( bkg )
    sceneGroup:insert( winText )
  
    

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------
 
    -- Creating Back Button
    mainMenuButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*1.2/8,
        y = display.contentHeight*14.5/16,
    

        -- Setting Dimensions
        width = 340,
        height = 140,

        -- Setting Visual Properties
        defaultFile = "Images/mainMenuButton.png",
        overFile = "Images/mainMenuButtonPressed.png",

        -- Setting Functional Properties
        onRelease = MainMenuTransition

    } )

    -----------------------------------------------------------------------------------------
    -- Associating Buttons with this scene
    sceneGroup:insert( mainMenuButton)
end 

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
         -- Call the moveText function as soon as we enter the frame. 
        Runtime:addEventListener("enterFrame", moveText)
        if (soundOn == true) then 
            -- play sound effect 
            youWinSoundChannel = audio.play( youWinSound, {channel = 3, loops = 1})
        end
    end

end

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
        
    end
end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------
