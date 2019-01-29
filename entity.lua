require "class"

Entity = class()
function Entity:init(x,y, img, type)
  local type = type or "dynamic"
  self.img = img
  self.w = scale * img:getWidth()
  self.h = scale * img:getHeight()
  self.body = love.physics.newBody(world, x,y, type)
  self.shape = love.physics.newRectangleShape(self.w, self.h)
  self.fixture = love.physics.newFixture(self.body, self.shape)
end
function Entity:x() return self.body:getX()-self:width()/2 end
function Entity:y() return self.body:getY()-self:height()/2 end
function Entity:draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(self.img,
    self:x(), self:y(),
    0,    -- rotation
    scale,scale, -- scale
    0,0 ) -- origin
end
function Entity:width() return scale * self.img:getWidth() end
function Entity:height() return scale * self.img:getHeight() end
function Entity:hitbox()
  love.graphics.setColor(0,255,0)
  local x = self.body:getX()
  local y = self.body:getY()
  love.graphics.rectangle("line", x-self:width()/2,y-self:height()/2, self:width(), self:height())
end
function Entity:capDown(cap)
  x,y = self.body:getLinearVelocity()
  if y > cap then self.body:setLinearVelocity(x, cap) end
end
function Entity:capUp(cap)
  x,y = self.body:getLinearVelocity()
  if y < cap then self.body:setLinearVelocity(x, cap) end
end
function Entity:capLeft(cap)
  x,y = self.body:getLinearVelocity()
  if x > cap then self.body:setLinearVelocity(cap, y) end
end
function Entity:capRight(cap)
  x,y = self.body:getLinearVelocity()
  if x < cap then self.body:setLinearVelocity(cap, y) end
end
function Entity:onGround()
  _,y = self.body:getLinearVelocity()
  return y == 0
end
Ground = class(Entity)
function Ground:init()
  local img = love.graphics.newImage("ground.png")
  Entity.init(self, screenw/2,screenh-64, img, "static", 1,1)
end

Block = class(Entity)

Player = class(Entity)
function Player:init()
  local img = love.graphics.newImage("player.png")
  Entity.init(self, screenw/scale/2,screenh/scale/2, img)
end
function Player:draw()

end