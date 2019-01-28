require "entity"
screenw = 512
screenh = screenw/2*1.5
scale = 1--screenw/256

function love.load()
  love.window.setMode(screenw, screenh)
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.physics.setMeter(32)
  local gravity = 0--9.81 * love.physics.getMeter()
  world = love.physics.newWorld(0, gravity, true)
  love.graphics.setBackgroundColor(255, 255, 255)
  love.window.setTitle("avalanche")
  player = Player(1,1)
  --ground = Ground(0,0)
end

function love.draw()
  love.graphics.scale(scale)
  player:draw()
end

function key(v) return love.keyboard.isDown(v) end

function love.update(dt)
  world:update(dt)
  if     key('a') then -- right
    player.body:applyForce(-100, 0)
  elseif key('d') then -- left
    player.body:applyForce( 100, 0)
  end
  if key('w') or key("space") then -- up
    player.body:applyForce(0, -250)
  end
end