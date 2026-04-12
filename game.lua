local Ball = require('ball')
local Paddle = require('paddle')
local Obstacle = require('obstacle')

local Game = {}

function Game.load()
   Game.resetGame()
end

function Game.spawnObstacle()
   Game.obstacle = Obstacle:new(
      math.random(50, GAME_CONFIG.resolutionW - 70),
      math.random(50, GAME_CONFIG.resolutionH - 70),
      50,
      50
   )
end

function Game.update(dt)

   if Game.ballResetActive then
        Game.ballResetTimer = Game.ballResetTimer + dt
        if Game.ballResetTimer >= Game.ballResetDelay then
            -- reset and center ball
            ball.x = GAME_CONFIG.resolutionW / 2
            ball.y = GAME_CONFIG.resolutionH / 2
            ball.speedX = 200
            ball.speedY = 200

            Game.scoreLeft = Game.pendingScoreLeft
            Game.scoreRight = Game.pendingScoreRight

            Game.ballResetActive = false
        end

        return
    end

   -- ball update
   ball:update(dt, GAME_CONFIG.resolutionH)
   -- left paddle (W/S)
   leftPaddle:update(
      dt,
      love.keyboard.isDown("w"),
      love.keyboard.isDown("s")
   )

   -- right paddle (UP/DOWN)
   rightPaddle:update(
      dt,
      love.keyboard.isDown("up"),
      love.keyboard.isDown("down")
   )

   -- Paddle 1 obstincles (top and bottom)
   if leftPaddle.y < 0 then 
      leftPaddle.y = 0 
   end

   if leftPaddle.y > (GAME_CONFIG.resolutionH - leftPaddle.h) then 
      leftPaddle.y = GAME_CONFIG.resolutionH - leftPaddle.h
   end

   -- Paddle 2 obstincles (top and bottom)
   if rightPaddle.y < 0 then 
      rightPaddle.y = 0 
   end

   if rightPaddle.y > (GAME_CONFIG.resolutionH - rightPaddle.h) then 
      rightPaddle.y = GAME_CONFIG.resolutionH - rightPaddle.h 
   end

   -- ball and paddle speed up factor
   local speedUpFactor = 1.05
   local paddleSpeedUp = 1
   local obstacleSpawnChance = 0.2

   -- Ball bounce from the first paddle
   if ball.speedX < 0 and
      ball.x - ball.radius <= leftPaddle.x + leftPaddle.w and
      ball.y >= leftPaddle.y and
      ball.y <= leftPaddle.y + leftPaddle.h then
      
      ball.speedX = ball.speedX * speedUpFactor
      ball.speedY = ball.speedY * speedUpFactor

      leftPaddle.speed = leftPaddle.speed + paddleSpeedUp
      rightPaddle.speed = rightPaddle.speed + paddleSpeedUp

      ball.speedX = -ball.speedX
      ball.x = leftPaddle.x + leftPaddle.w + ball.radius + 1

      if math.random() < obstacleSpawnChance then
         Game.spawnObstacle()
      end
   end

   -- Ball bounce from the second paddle
   if ball.speedX > 0 and
      ball.x + ball.radius >= rightPaddle.x and
      ball.y >= rightPaddle.y and
      ball.y <= rightPaddle.y + rightPaddle.h then
      
      ball.speedX = ball.speedX * speedUpFactor
      ball.speedY = ball.speedY * speedUpFactor

      leftPaddle.speed = leftPaddle.speed + paddleSpeedUp
      rightPaddle.speed = rightPaddle.speed + paddleSpeedUp

      ball.speedX = -ball.speedX
      ball.x = rightPaddle.x - ball.radius - 1

      if math.random() < obstacleSpawnChance then
         Game.spawnObstacle()
      end
   end

   if ball.x > GAME_CONFIG.resolutionW + ball.radius and ball.x > rightPaddle.x + rightPaddle.w + ball.radius then
      Game.ballResetActive = true
      Game.ballResetTimer = 0
      Game.pendingScoreLeft = Game.scoreLeft + 1
      Game.pendingScoreRight = Game.scoreRight
   end

   if ball.x <= GAME_CONFIG.resolutionW and ball.x < leftPaddle.x - leftPaddle.w - ball.radius then
      Game.ballResetActive = true
      Game.ballResetTimer = 0
      Game.pendingScoreRight = Game.scoreRight + 1
      Game.pendingScoreLeft = Game.scoreLeft
   end

   if Game.obstacle and Game.obstacle:checkCollision(ball) then
      -- bounce from obstacle 
      ball.speedX = -ball.speedX * 0.9
      ball.speedY = -ball.speedY * 0.9

      -- obstacle dissapears
      Game.obstacle = nil
   end
end

function Game.resetGame()
   -- score
   Game.scoreLeft = 0
   Game.scoreRight = 0

   ball = Ball:new();
   leftPaddle = Paddle:new(10,0);
   rightPaddle = Paddle:new(770,0);
	
   ball.y = (GAME_CONFIG.resolutionH + ball.radius) / 2
   ball.x = (GAME_CONFIG.resolutionW + ball.radius) / 2
    -- resolution
	GAME_CONFIG.resolutionH= 640
	GAME_CONFIG.resolutionW = 800
	-- dimensions of a ball 
	ball.radius = 20
   ball.y = (GAME_CONFIG.resolutionH + ball.radius) / 2
   ball.x = (GAME_CONFIG.resolutionW + ball.radius) / 2
   -- speed of a ball
	ball.speedY = 200
	ball.speedX = 200
	----------------------
	-- first rectangle dimensions
	leftPaddle.x = 10
	leftPaddle.y = 0
	leftPaddle.w = 15
	leftPaddle.h = 100
	-- second rectangle dimensions
	rightPaddle.x = 770
	rightPaddle.y = 0
	rightPaddle.w = 15
	rightPaddle.h = 100

   -- paddles speed
	leftPaddle.speed = 300
   rightPaddle.speed = 300

	-- ball timer
   Game.ballResetTimer = 0
   Game.ballResetDelay = 2       -- sekundy
   Game.ballResetActive = false

   -- score
   Game.pendingScoreLeft = 0
   Game.pendingScoreRight = 0
end

function Game.draw()
   drawMiddleLine()

   ball:draw()
   leftPaddle:draw()
   rightPaddle:draw()
   
   if Game.obstacle then
      Game.obstacle:draw()
   end

   love.graphics.print(Game.scoreLeft, GAME_CONFIG.resolutionW / 4, 20)
   love.graphics.print(Game.scoreRight, GAME_CONFIG.resolutionW * 3 / 4, 20)
end

function drawMiddleLine()
   local lineWidth = 5       
   local lineHeight = 20      
   local gap = 10              

   local x = GAME_CONFIG.resolutionW / 2
   local y = 0

   love.graphics.push()      
   love.graphics.setColor(0,0,0)
   while y < GAME_CONFIG.resolutionH do
      love.graphics.rectangle("fill", x - lineWidth/2, y, lineWidth, lineHeight)
      y = y + lineHeight + gap
   end
   love.graphics.pop()               
end


return Game