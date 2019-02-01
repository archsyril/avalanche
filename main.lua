require "entity"
require "player"
require "ground"
require "block"
math = require "math"

screenw = 512
screenh = screenw/2*1.5
scale = 1
DEF_r = 255--0
DEF_g = 255--0
DEF_b = 255--0
function love.load()
  local cam = gamera.new(0,0,2000,2000)
  love.window.setMode(screenw, screenh)
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.physics.setMeter(32)--64 * scale)
  local gravity = 9.81 * love.physics.getMeter() * 2
  world = love.physics.newWorld(0, gravity, true)
  love.graphics.setBackgroundColor(DEF_r, DEF_g, DEF_b)
  love.window.setTitle("avalanche")
  player = Player()
  ground = Ground()
end

function love.draw()
  --love.graphics.scale(scale)
  ground:draw()-- ground:hitbox()
  player:draw()-- player:hitbox()
  _,y = player.body:getLinearVelocity()
end

function key(v) return love.keyboard.isDown(v) end
 
function love.update(dt)
  world:update(dt)
  if     key('a') then -- right
    player.body:applyForce(-player_move, 0)
    player:capRight(-player_move_cap)
  elseif key('d') then -- left
    player.body:applyForce( player_move, 0)
    player:capLeft(player_move_cap)
  end
  if player:onGround() and (key('w') or key("space")) then -- up
    player.body:applyForce(0, -player_jump)
    player:capDown(-player_jump_cap)
  else
    --player:capDown(max_down)
  end
  if key('r') then
    player.body:setPosition(screenw/2,screenh/2)
    player.body:setLinearVelocity(0,0)
  end
  player.body:setAngle(0)
  player:keepInBounds()
  player:update()
end