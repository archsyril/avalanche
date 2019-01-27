require "entity"

function love.load()
  local ws = 1024
  scale = ws/8
  love.graphics.setDefaultFilter("nearest", "nearest")
  .lo\\]0   Glove.window.setMode(ws, ws/2*1.5)
  love.physics.setMeter(32)
  local gravity = 9.81 * love.physics.getMeter()
  world = love.physics.newWorld(0, gravity, true)
  love.graphics.setBackgroundColor(255, 255, 255)
  love.window.setTitle("avalanche")
  player = Player(1,1)
end

function love.draw()
  love.graphics.scale(2)
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