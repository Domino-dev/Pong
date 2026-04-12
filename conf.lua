function love.conf(t)
    t.window.title = "Pong2018"
    t.window.width = 800
    t.window.height = 640
    t.window.resizable = false
    t.window.vsync = true
end

GAME_CONFIG = {
    ballSpeed = 200,
    paddleSpeed = 300,
    paddleWidth = 15,
    paddleHeight = 250,
    resolutionW = 800,
    resolutionH = 640
}