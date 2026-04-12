require("conf")

local Game = require("game")

function love.load()
   Game:resetGame()

   -- graphics
   love.graphics.setBackgroundColor({0, 250, 0})
   love.graphics.setColor({0, 0, 0})
end

function love.update(dt) Game.update(dt) end
function love.draw() Game.draw() end

function love.keypressed(key)
   if key == "escape" or key == 'q' then
      love.event.quit()
   end
end
