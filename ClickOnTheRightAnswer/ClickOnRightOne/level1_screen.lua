-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Gil Robern
-- Modified by: Thomas Kushner
-- ICS2O
-- Description: This is the level 1 screen of the game.
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
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg

-- determine the range for the numbers to add
local MIN_NUM = 1
local MAX_NUM = 10

-- the variables containing the first and second numbers to add for the equation
local firstNumber
local secondNumber

-- the variables that will hold the correct answer and the wrong answers
local answer 
local wrongAnswer1
local wrongAnswer2

-- the text object that will hold the addition equation
local addEquationTextObject 

-- the text objects that will hold the correct answer and the wrong answers
local answerTextObject 
local wrongAnswer1TextObject
local wrongAnswer2TextObject

-- displays the number correct that the user has
local numberCorrectText 

-- displays the number of lives the user has
local livesText 

-- the text displaying congratulations
local congratulationText 

-- Displays text that says correct.
local correct 

-- Displays the level text of time text
local level1Text 

-- Boolean variable that states if user clicked the answer or not
local alreadyClickedAnswer = false


-----------------------------------------------------------------------------------------
-- SOUND
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function DetermineAnswers()
    -- calculate the correct answer as well as the wrong answers
    answer = firstNumber + secondNumber
    wrongAnswer1 = answer + math.random(1,4)
    wrongAnswer2 = answer + math.random(5,8)
end

-- Function that changes the answers for a new question and places them randomly in one of the positions
local function DisplayAnswers( )

    local answerPosition = math.random(1,3)
    answerTextObject.text = tostring( answer )
    wrongAnswer1TextObject.text = tostring( wrongAnswer1 )
    wrongAnswer2TextObject.text = tostring( wrongAnswer2 )

    if (answerPosition == 1) then                
        
        answerTextObject.x = display.contentWidth*.3        
        wrongAnswer1TextObject.x = display.contentWidth*.2
        wrongAnswer2TextObject.x = display.contentWidth*.1 

    elseif (answerPosition == 2) then
       
        answerTextObject.x = display.contentWidth*.2        
        wrongAnswer1TextObject.x = display.contentWidth*.1
        wrongAnswer2TextObject.x = display.contentWidth*.3 

    else
       
        answerTextObject.x = display.contentWidth*.1        
        wrongAnswer1TextObject.x = display.contentWidth*.2
        wrongAnswer2TextObject.x = display.contentWidth*.3
    end

end

-- Function that transitions to Lose Screen
local function LoseScreenTransition( )        
    composer.gotoScene( "you_lose", {effect = "zoomInOutFade", time = 1000})
end 

-- The function that displays the equation and determines the answer and the wrong answers
local function DisplayAddEquation()
    -- local variables to this function
    local addEquationString

    -- choose the numbers to add randomly
    firstNumber = math.random(MIN_NUM, MAX_NUM)
    secondNumber = math.random(MIN_NUM, MAX_NUM)

    -- create the addition equation to display
    addEquationString = firstNumber .. " + " .. secondNumber .. " = " 

    -- displays text on text object
    addEquationTextObject.text = addEquationString

    
end


local function RestartScene()

    alreadyClickedAnswer = false
    correct.isVisible = false

    livesText.text = "Number of lives = " .. tostring(lives)
    numberCorrectText.text = "Number correct = " .. tostring(numberCorrect)

    -- if they have 0 lives, go to the You Lose screen
    if (lives == 0) then
        composer.gotoScene("you_lose")
    else 

        DisplayAddEquation()
        DetermineAnswers()
        DisplayAnswers()
    end
end

-- Functions that checks if the buttons have been clicked.
local function TouchListenerAnswer(touch)
    -- get the user answer from the text object that was clicked on
    local userAnswer = answerTextObject.text

    if (touch.phase == "ended") and (alreadyClickedAnswer == false) then

        alreadyClickedAnswer = true

        -- if the user gets the answer right, display Correct and call RestartSceneRight
        if (answer == tonumber(userAnswer)) then     
            correct.isVisible = true
            -- increase the number correct by 1
            numberCorrect = numberCorrect + 1
            -- call RestartScene after 1 second
            timer.performWithDelay( 1000, RestartScene )
        end        

    end
end

local function TouchListenerWrongAnswer1(touch)
    -- get the user answer from the text object that was clicked on
    local userAnswer = wrongAnswer1TextObject.text

    if (touch.phase == "ended") and (alreadyClickedAnswer == false) then

        alreadyClickedAnswer = true


        if (answer ~= tonumber(userAnswer)) then
            -- decrease a life
            lives = lives - 1
            -- call RestartScene after 1 second
            timer.performWithDelay( 1000, RestartScene )            
        end        

    end
end

local function TouchListenerWrongAnswer2(touch)
    -- get the user answer from the text object that was clicked on
    local userAnswer = wrongAnswer2TextObject.text

      
        if (touch.phase == "ended") and (alreadyClickedAnswer == false) then

            alreadyClickedAnswer = true


            if (answer ~= tonumber(userAnswer)) then
                -- decrease a life
                lives = lives - 1
                -- call RestartScene after 1 second
                timer.performWithDelay( 1000, RestartScene )            
            end        
    
        end
end
    
-- Function that adds the touch listeners to each of the answer objects
local function AddTextObjectListeners()

    answerTextObject:addEventListener("touch", TouchListenerAnswer)
    wrongAnswer1TextObject:addEventListener("touch", TouchListenerWrongAnswer1)
    wrongAnswer2TextObject:addEventListener("touch", TouchListenerWrongAnswer2)

end

-- Function that removes the touch listeners from each of the answer objects
local function RemoveTextObjectListeners()

    answerTextObject:removeEventListener("touch", TouchListenerAnswer)
    wrongAnswer1TextObject:removeEventListener("touch", TouchListenerWrongAnswer1)
    wrongAnswer2TextObject:removeEventListener("touch", TouchListenerWrongAnswer2)

end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------


-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg = display.newImageRect("Images/Level 1 Screen.png", display.contentWidth, display.contentHeight)
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    bkg.width = display.contentWidth
    bkg.height = display.contentHeight

    -- create the text object that will hold the add equation. Make it empty for now.
    addEquationTextObject = display.newText( "", display.contentWidth*1/4, display.contentHeight*2/5, nil, 50 )

    -- sets the color of the add equation text object
    addEquationTextObject:setTextColor(155/255, 42/255, 198/255)

    -- create the text objects that will hold the correct answer and the wrong answers
    answerTextObject = display.newText("", display.contentWidth*.4, display.contentHeight/2, nil, 50 )
    wrongAnswer1TextObject = display.newText("", display.contentWidth*.3, display.contentHeight/2, nil, 50 )
    wrongAnswer2TextObject = display.newText("", display.contentWidth*.2, display.contentHeight/2, nil, 50 )
    numberCorrectText = display.newText("", display.contentWidth*4/5, display.contentHeight*6/7, nil, 25)

    -- create the text object that will hold the number of lives
    livesText = display.newText("", display.contentWidth*4/5, display.contentHeight*8/9, nil, 25) 

    -- create the text object that will say congratulations, set the colour and then hide it
    congratulationText = display.newText("Good job!", display.contentWidth/2, display.contentHeight*2/5, nil, 50 )
    congratulationText:setTextColor(57/255, 230/255, 0)
    congratulationText.isVisible = false

    -- create the text object that will say Correct, set the colour and then hide it
    correct = display.newText("Correct", display.contentWidth/2, display.contentHeight*1/3, nil, 50 )
    correct:setTextColor(100/255, 47/255, 210/255)
    correct.isVisible = false

    -- create the text object that will say Out of Time, set the colour and then hide it
    outOfTimeText = display.newText("Out of Time!", display.contentWidth*2/5, display.contentHeight*1/3, nil, 50)
    outOfTimeText:setTextColor(100/255, 47/255, 210/255)
    outOfTimeText.isVisible = false

    -- display the level text of time text and set the colour
    level1Text = display.newText("Level 1", display.contentWidth*2/12, display.contentHeight*2/12, nil, 50)
    level1Text:setTextColor(0, 0, 0)
    
    -- Insert objects into scene group
    sceneGroup:insert( bkg )  
    sceneGroup:insert( numberCorrectText )
    sceneGroup:insert( livesText )
    sceneGroup:insert( addEquationTextObject )
    sceneGroup:insert( answerTextObject )
    sceneGroup:insert( wrongAnswer1TextObject )
    sceneGroup:insert( wrongAnswer2TextObject )
    sceneGroup:insert( congratulationText )
    sceneGroup:insert( correct )
    sceneGroup:insert( level1Text )
end

-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    --local sceneGroup = self.view
    local phase = event.phase


    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- initialize the number of lives and number correct 
        lives = 3
        numberCorrect = 0

        -- listeners to each of the answer text objects
        AddTextObjectListeners()        

        -- call the function to restart the scene
        RestartScene()
    end

end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then


        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        
        -- remove the listeners when leaving the scene
        RemoveTextObjectListeners()

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
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

-- Adding Event Listeners for Scene
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene