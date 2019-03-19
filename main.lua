local tapCount = 0
local getReady
local gameOver
local board
local physics = require( "physics" )
local widget = require( "widget" )

local background = display.newImageRect( "background.png", 360, 570 )
background.x = display.contentCenterX
background.y = display.contentCenterY

local platform = display.newImageRect( "platform.png", 500, 20 )
platform.x = display.contentCenterX
platform.y = display.contentHeight+44
platform.myName = "platform"

local platform1 = display.newImageRect( "platform1.png", 20, 2000 )
platform1.x = display.contentCenterX-170
platform1.y = display.contentHeight

local platform2 = display.newImageRect( "platform1.png", 20, 2000 )
platform2.x = display.contentCenterX+170
platform2.y = display.contentHeight


local ball = display.newImageRect("ball.png",100,100)
ball.x = display.contentCenterX
ball.y = display.contentCenterY
ball.myName = "ball"


local score = display.newText( tapCount, display.contentCenterX, 20, native.systemFont, 40 )

local GameoverLabel = display.newText("Game Over",display.contentCenterX, 200, native.systemFont, 40)
GameoverLabel:setFillColor(0,0,1)
GameoverLabel.isVisible = false

tapToStartLabel = display.newText("Tap Here To Start",display.contentCenterX, 450, native.systemFont, 40)
tapToStartLabel:setFillColor(0,0,1)


local function balloonUp(event)
	if event.phase == "began" then
		print("tapStarted")

	elseif event.phase == "ended" then
		print("tapEnded")
end
end

-- Starting the game
local function startGame(event)
  ball.x = display.contentCenterX
  ball.y = display.contentCenterY
  if event.phase == "began" then
  		-- Start the game here
  	elseif event.phase == "ended" then
      display.remove(tapToStartLabel)
    end
physics.start()
physics.setGravity( 0, 20 )
physics.addBody( platform, "static" )
physics.addBody( platform1, "static" )
physics.addBody( platform2, "static" )
physics.addBody( ball, "dynamic", { radius=50, bounce=-1 } )
end
tapToStartLabel:addEventListener( "touch", startGame )


function ball.tap()
ball:applyForce(math.random()*50-25, -80, ball.x,ball.y)
ball:applyTorque( math.random()*50 - 15 )
tapCount = tapCount + 1
score.text = tapCount
end
ball:addEventListener( "tap" )

local function onLocalCollision( self, event )
    if ( event.phase == "began" ) then
    score.text = 0
    elseif ( event.phase == "ended" ) then
        physics.pause()
        GameoverLabel.isVisible = true
      --startGame()
    end
end
platform.collision = onLocalCollision
platform:addEventListener( "collision" )

          -- Start application point
