require "entity"
screenw = 512
screenh = screenw/2*1.5
scale = 1
player_jump = -200 --negative means up
max_down = 150

function love.load()
  love.window.setMode(screenw, screenh)
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.physics.setMeter(64 * scale)
  local gravity = 9.81 * love.physics.getMeter()
  world = love.physics.newWorld(0, gravity, true)
  love.graphics.setBackgroundColor(255, 255, 255)
  love.window.setTitle("avalanche")
  player = Player()
  ground = Ground()
end

function love.draw()
  --love.graphics.scale(scale)
  ground:draw() --ground:hitbox()
  player:draw() --player:hitbox()
end

function key(v) return love.keyboard.isDown(v) end

function love.update(dt)
  world:update(dt)
  if     key('a') then -- right
    player.body:applyForce(-100, 0)
    player:capRight(-500)
  elseif key('d') then -- left
    player.body:applyForce( 100, 0)
    player:capLeft(500)
  end
  if player:onGround() and (key('w') or key("space")) then -- up
    player.body:applyForce(0, player_jump)
    player:capUp(player_jump)
  else
    player:capDown(max_down)
  end
  if key('r') then
    player.body:setPosition(screenw/2,screenh/2)
    player.body:setLinearVelocity(0,0)
  end
  player.body:setAngle(0)
end