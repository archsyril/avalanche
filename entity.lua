require "class"

Entity = class()
function Entity:init(x,y, img, type)
  type = type or "dynamic"
  self.img = img
  local w = img:getWidth()
  local h = img:getHeight()
  self.body = love.physics.newBody(world, (x+w)/2, (y+h)/2, type)
  self.shape = love.physics.newRectangleShape(w, h)
  self.fixture = love.physics.newFixture(self.body, self.shape)
end
function Entity:draw()
  love.graphics.draw(self.img,
    self.body:getX(), self.body:getY(),
    0,   -- rotation
    2,2, -- scale
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
function Player:init(x,y)
  local img = love.graphics.newImage("player.png")
  Entity.init(self, x,y, img)
end