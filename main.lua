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
platform.id = "platform"
platform.isplatform = true

local platform1 = display.newImageRect( "platform1.png", 20, 2000 )
platform1.x = display.contentCenterX-170
platform1.y = display.contentHeight

local platform2 = display.newImageRect( "platform1.png", 20, 2000 )
platform2.x = display.contentCenterX+170
platform2.y = display.contentHeight

local tapText = display.newText( tapCount, display.contentCenterX, 20, native.systemFont, 40 )

local GameoverLabel = display.newText("Game Over",display.contentCenterX, 200, native.systemFont, 40)
GameoverLabel:setFillColor(0,0,1)
GameoverLabel.isVisible = false

-- The menu
local function Menu()
tapToStartLabel = display.newText("Tap To Start",display.contentCenterX, 200, native.systemFont, 40)
tapToStartLabel:setFillColor(0,0,1)
end

Menu()

local ball = display.newImageRect("ball.png",100,100)
ball.x = display.contentCenterX
ball.y = display.contentCenterY

-- Starting the game
local function startGame()
  ball.x = display.contentCenterX
  ball.y = display.contentCenterY
  ball.id = "ball"
  ball.isball = true
display.remove(tapToStartLabel)
physics.start()
physics.setGravity( 0, 20 )
physics.addBody( platform, "static" )
physics.addBody( platform1, "static" )
physics.addBody( platform2, "static" )
physics.addBody( ball, "dynamic", { radius=50, bounce=-1 } )
end
--background:addEventListener("tap", startGame )
--ball:addEventListener( "tap", startGame )

local function initGame()
  transition.to( ball, { time=300, x=xBird, y=yBird, rotation = 0 } )
  transition.to( getReady, { time=600, y=yReady, transition=easing.outBounce, onComplete=prompt   } )
  ball.rotation =  -30*math.atan(30)

end

function ball.tap()
ball:applyForce(math.random()*50-25, -80, ball.x,ball.y)
ball:applyTorque( math.random()*50 - 15 )
tapCount = tapCount + 1
tapText.text = tapCount
end
ball:addEventListener( "tap" )


function platform.collision(event,self)
  if( event.phase == "began" and event.other.isplatform ) then
                tapCount = 0
                tapText.text = tapCount
                GameoverLabel.isVisible = true
                --physics.pause()
              end
end
platform:addEventListener( "collision" )

local function Restart(event)
  if ( event.phase == "began" ) then
            GameoverLabel.isVisible = false
    elseif ( event.phase == "ended" ) then
    -- physics.pause()
     restartlabel = display.newText("Tap To Start",display.contentCenterX, 200, native.systemFont, 40)
     restartlabel:setFillColor(0,0,1)
     --ball.x = display.contentCenterX
    -- ball.y = display.contentCenterY
end
--restartlabel.isVisible = false
          end
          background:addEventListener( "touch", Restart )

          -- Start application point
          startGame()
          initGame()
