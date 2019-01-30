require "entity"
Player = class(Entity)
max_rotation = 0.05
player_jump = 10000 --negative means up
player_jump_cap = 1
player_move = 1280
player_move_cap = 320
max_down = 200
LEFT  =  1
RIGHT = -1
function Player:init()
  local img = love.graphics.newImage("player.png")
  Entity.init(self, screenw/2,screenh/2, img)
  self.fixture:setFriction(1)
  self.facing = RIGHT
  self.rotation = 0
end
function Player:update()
  x,_ = self.body:getLinearVelocity()
  if x > 1 then
    self.facing = LEFT
    self.rotation = self.rotation + 0.01
  elseif x < -1 then
    self.facing = RIGHT
    self.rotation = self.rotation - 0.01
  end
  if self.rotation < -max_rotation then
    self.rotation = -max_rotation
  elseif self.rotation > max_rotation then
    self.rotation = max_rotation
  end
  love.graphics.translate(0, self:y())
end
function Player:keepInBounds()
  local x = self:x()
  if x < -5 then
    self.body:setPosition(screenw-5, self.body:getY()+1) end
  if x > screenw+5  then
    self.body:setPosition(5, self.body:getY()+1) end
end
function Player:x()
  if self.facing == LEFT then 
    return self.body:getX()-self.w/2 end
  return self.body:getX()+self.w/2
end
function Player:y() return self.body:getY()-self.h/2 end
function Player:draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(self.img,
    self:x(), self:y(),
    self.rotation, -- rotation
    self.sw*self.facing,self.sh, -- scale
    0,0 ) -- origin
end