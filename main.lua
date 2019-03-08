local tapCount = 0
local tapToStartLabel
local physics = require( "physics" )
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

local ball = display.newImageRect("ball.png",100,100)
ball.x = display.contentCenterX
ball.y = display.contentCenterY
ball.id = "ball"
ball.isball = true

local tapText = display.newText( tapCount, display.contentCenterX, 20, native.systemFont, 40 )

-- The menu
local function Menu()
tapToStartLabel = display.newText("Tap To Start",display.contentCenterX, 200, native.systemFont, 40)
tapToStartLabel:setFillColor(0,0,1)
end

Menu()


-- Starting the game
local function startGame( event )
  display.remove(tapToStartLabel)
  if ( event.phase == "began" ) then
    tapCount = 1000
    display.remove(tapToStartLabel)
  end
physics.start()
physics.setGravity( 0, 20 )
physics.addBody( platform, "static" )
physics.addBody( platform1, "static" )
physics.addBody( platform2, "static" )
physics.addBody( ball, "dynamic", { radius=50, bounce=-1 } )
end


local function pushBall()
ball:applyForce(math.random()*50-25, -80, ball.x,ball.y)
ball:applyTorque( math.random()*50 - 15 )
tapCount = tapCount + 1
tapText.text = tapCount
end


function GameOver(event)
    if event.phase == "began" then
        local target = event.other
            if target.isplatform then
                tapCount = 0
                tapText.text = tapCount
                tapToStartLabel.text = "Game Over"
                tapToStartLabel.isVisible = true
                tapToStartLabel:setFillColor( 1, 0, 0 )
                tapToStartLabel.text = "Game Over"
                tapToStartLabel.isVisible = true
                tapToStartLabel:setFillColor( 1, 0, 0 )

            end
    end
end

background:addEventListener("tap", startGame )
ball:addEventListener( "tap", startGame )
ball:addEventListener( "tap", pushBall )
ball:addEventListener( "collision", GameOver )


local function call_VK_event()
    local args={}
    args.user_id='33251324'
    args.activity_id=2
    args.value=tapCount
    vk.api('secure.addAppEvent', args)
end
