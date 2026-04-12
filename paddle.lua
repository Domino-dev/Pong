-- paddle 
local Paddle = {}

function Paddle:new(x, y)
    local obj = {
        x = x,
        y = y,
        w = GAME_CONFIG.paddleWidth,
        h = GAME_CONFIG.paddleHeight,
        speed = GAME_CONFIG.paddleSpeed
    }
    setmetatable(obj,self)
    self.__index = self
    return obj
end

function Paddle:update(dt, moveUp, moveDown)
    if moveUp then self.y = math.max(0, self.y - self.speed * dt) end
    if moveDown then self.y = math.min(love.graphics.getHeight() - self.h, self.y + self.speed * dt) end
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Paddle;