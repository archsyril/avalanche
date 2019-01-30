require "class"

Entity = class()
function Entity:init(x,y, img, type, w,h)
  local type = type or "dynamic"
  self.img = img
  self.sw = w or scale
  self.sh = h or scale
  self.w = self.sw * img:getWidth()
  self.h = self.sh * img:getHeight()
  self.body = love.physics.newBody(world, x,y, type)
  self.shape = love.physics.newRectangleShape(self.w, self.h)
  self.fixture = love.physics.newFixture(self.body, self.shape)
end
--function Entity:width() return scale * self.img:getWidth() end
--function Entity:height() return scale * self.img:getHeight() end
function Entity:x() return self.body:getX()-self.w/2 end
function Entity:y() return self.body:getY()-self.h/2 end
function Entity:draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(self.img,
    self:x(), self:y(),
    0,    -- rotation
    self.sw,self.sh, -- scale
    0,0 ) -- origin
end
function Entity:hitbox()
  love.graphics.setColor(0,255,0)
  local x = self.body:getX()
  local y = self.body:getY()
  love.graphics.rectangle("line", x-self.w/2,y-self.h/2, self.w, self.h)
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
  return y > -1 and y < 1
end