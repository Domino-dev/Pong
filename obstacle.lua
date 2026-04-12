local Obstacle = {}

function Obstacle:new(x, y, w, h)
    local obj = {
        x = x or 0,
        y = y or 0,
        w = w or 50,
        h = h or 50,
        active = true
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Obstacle:draw()
    if self.active then
        love.graphics.push()        
        love.graphics.setColor(0, 0, 0)   
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
        love.graphics.pop()         
    end
end

function Obstacle:checkCollision(ball)
    if not self.active then return false end

    if ball.x + ball.radius > self.x and
       ball.x - ball.radius < self.x + self.w and
       ball.y + ball.radius > self.y and
       ball.y - ball.radius < self.y + self.h then

        self.active = false
        return true
    end
    return false
end

return Obstacle;