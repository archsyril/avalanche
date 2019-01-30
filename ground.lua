require "entity"

Ground = class(Entity)
function Ground:init()
  local img = love.graphics.newImage("ground.png")
  Entity.init(self, screenw/2,screenh-32, img, "static", 12, 8)
end