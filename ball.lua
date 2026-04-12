local Ball = {}

function Ball:new()
    local obj = {
        x = 0,
        y = 0,
        radius = 20,
        speedX = 200,
        speedY = 200
    }
    setmetatable(obj,self)
    self.__index = self
    return obj
end

function Ball:update(dt, resolutionH)
    self.x = self.x + self.speedX * dt
    self.y = self.y + self.speedY * dt

    -- bounce top/bottom
    if self.y - self.radius < 0 then
        self.y = self.radius
        self.speedY = -self.speedY
    elseif self.y + self.radius > resolutionH then
        self.y = resolutionH - self.radius
        self.speedY = -self.speedY
    end
end

function Ball:draw()
    love.graphics.circle("fill",self.x,self.y,self.radius)
end

return Ball;