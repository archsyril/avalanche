require "class"

Entity = class()
function Entity:init(x,y, img, type)
  type = type or "dynamic"
  self.img = img
  local w = scale * img:getWidth()
  local h = scale * img:getHeight()
  self.body = love.physics.newBody(world, w/2+x, h/2+y, type)
  self.shape = love.physics.newRectangleShape(w, h)
  self.fixture = love.physics.newFixture(self.body, self.shape)
end
function Entity:draw()
  love.graphics.draw(self.img,
    self.body:getX(), self.body:getY(),
    0,   -- rotation
    scale, scale, -- scale
    0,0  -- origin
  )
end
Ground = class(Entity)
function Ground:init()
  local img = love.graphics.newImage("ground.png")
  Entity.init(self, x,y, img, "static")
end
Block = class(Entity)
Player = class(Entity)
function Player:init()
  local img = love.graphics.newImage("player.png")
  Entity.init(self, screenw/2,screenh/2, img)
end