-- main.lua
-- Created by: Thomas Kushner
-- ICS2O
-- Description: This calls the splash screen of the app to load itself.
-----------------------------------------------------------------------------------------

-- Hiding Status Bar
-- HIDE THE STATUS BAR

-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Go to the intro screen
composer.gotoScene( "main_menu" )

-- hide the status Bar
display.setStatusBar(display.HiddenStatusBar)