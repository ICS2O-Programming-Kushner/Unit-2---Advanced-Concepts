-- splash_screen
-- Thomas Kushner
-- ISC2O
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
local scrollXSpeed = 1.7
local scrollYSpeed = 2
local scrollXSpeed2 = 3.2

local background 
local Panzer
local logo
local jet



----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
local bkgMusic = audio.loadSound("Sounds/bell.mp3")
local bkgSoundsChannel

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that will make jet move halfway across the screen 
local function moveJet() 
    jet.x = jet.x + scrollXSpeed
    jet.y = jet.y + scrollYSpeed
    jet.alpha = jet.alpha + 0.01 
    jet.xScale = jet.xScale + .002
end

local function movePanzer()
    if ( reverse == 0 ) then 
        reverse = 1 
        transition.to( Panzer, { rotation = -90, time = 900, transition = easing.inOutCubic } )
    else
        reverse = 0 
        transition.to ( Panzer, { rotation = 90, time = 900, transition = easing.inOutCubic } )
    end
end

timer.performWithDelay( 600, movePanzer, 0 )


local function movePanzer2()
    Panzer.x = Panzer.x - scrollXSpeed2
end

local function moveLogo()
    logo.alpha = logo.alpha + 0.0079
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu", {effect = "fade", time = 800} )
end


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Insert the background image
    background = display.newImageRect("Images/bkg.png", 1024, 768)
    background.anchorX = 0
    background.anchorY = 0

    -- Insert the jet image and set its intial x and y position 
    jet = display.newImageRect("Images/jet.png", 890, 690)
    jet.x = 310 
    jet.y = 700
    jet.alpha = 0 
    jet.xScale = .5

    -- Insert the panzer image set its intial x and y position 
    Panzer = display.newImageRect("Images/panzer.png", 720, 620)
    Panzer.x = 980 
    Panzer.y = 490

    -- Insert the logo text image and set its initial x and y position 
    logo = display.newImageRect("Images/Logo.png", 200, 65)
    logo.x = 655
    logo.y = 380
    logo.alpha = 0 

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( background )

    -- Insert objects into the scene group in order to ONLY be associated with this scene 
    sceneGroup:insert( jet )

    -- Insert obejcts into the scene group in order to ONLY be associated with this scene 
    sceneGroup:insert( panzer )

    sceneGroup:insert( logo )

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
        backgroundMusicChannel = audio.play( bkgMusic )

        -- Call the moveDeer function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveJet)

        -- Call the moveFlower function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", movePanzer)

        -- Call the moveText function as soon as we enter the frame. 
        Runtime:addEventListener("enterFrame", moveLogo)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
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
        audio.stop(bkgChannel)
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



