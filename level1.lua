-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- Single Grid Item size
	local gridSize = display.contentWidth/13


	-- create a grey rectangle as the backdrop
	-- local background = display.newRect( 0, 0, screenW, screenH )
	-- background.anchorX = 0
	-- background.anchorY = 0
	-- background:setFillColor( .5 )
	
	-- make a crate (off-screen), position it, and rotate slightly
	-- local crate = display.newImageRect( "crate.png", gridSize, gridSize )
	-- crate.x, crate.y = 160, 100
	--crate.rotation = 15



	-- Make the walls
	local walls = {
        { x=5, y=2 },
        { x=6, y=2 },
        { x=7, y=2 },
        { x=5, y=3 },
        { x=7, y=3 },
        { x=5, y=4 },
        { x=7, y=4 },
        { x=8, y=4 },
        { x=9, y=4 },
        { x=10, y=4 },
        { x=3, y=5 },
        { x=4, y=5 },
        { x=5, y=5 },
        { x=10, y=5 },
        { x=3, y=6 },
        { x=8, y=6 },
        { x=9, y=6 },
        { x=10, y=6 },
        { x=3, y=7 },
        { x=4, y=7 },
        { x=5, y=7 },
        { x=6, y=7 },
        { x=8, y=7 },
        { x=6, y=8 },
        { x=8, y=8 },
        { x=6, y=9 },
        { x=7, y=9 },
        { x=8, y=9 },
    }

    local wallBlock = {}

	for i=1,#walls do

	wallBlock[i] = display.newImageRect( "wall.png", gridSize, gridSize )
	wallBlock[i].x, wallBlock[i].y = walls[i].x * gridSize, walls[i].y * gridSize
	physics.addBody( wallBlock[i], "static", { density=1.6, friction=0.5, bounce=0.2 } )

    end




    -- Player create
	local player = display.newImageRect( "player.png", gridSize, gridSize )
	player.x, player.y = 7 * gridSize, 6* gridSize
	physics.addBody( player, "dynamic", { density=1.6, friction=0.5, bounce=0.2 } )





	-- SPAWN the crates
	local crates = {
        { x=6, y=5 },
        { x=6, y=6 },
        { x=7, y=7 },
        { x=8, y=5 },
    }

    local crate = {}

	for i=1,#crates do

	crate[i] = display.newImageRect( "crate.png", gridSize, gridSize )
	crate[i].x, crate[i].y = crates[i].x * gridSize, crates[i].y * gridSize
	physics.addBody( crate[i], "dynamic", { density=1.6, friction=0.5, bounce=0.2 } )

    end





	
	-- add physics to the crate
	-- physics.addBody( crate, { density=1.0, friction=0.3, bounce=0.3 } )
	
	-- -- create a grass object and add physics (with custom shape)
	-- local grass = display.newImageRect( "grass.png", screenW, 82 )
	-- grass.anchorX = 0
	-- grass.anchorY = 1
	-- grass.x, grass.y = 0, display.contentHeight
	
	-- -- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	-- local grassShape = { -halfW,-34, halfW,-34, halfW,34, -halfW,34 }
	-- physics.addBody( grass, "static", { friction=0.3, shape=grassShape } )
	
	-- all display objects must be inserted into group
	--sceneGroup:insert( background )
	--sceneGroup:insert( grass)
	-- sceneGroup:insert( crate )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene