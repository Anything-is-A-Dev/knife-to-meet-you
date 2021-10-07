
local anim8 = require "anim8"
local cmpl = require "cpml-master.modules.vec2"
Player = {}
--LOAD
function Player:load()
    self.sprite = love.graphics.newImage("Assets/0x72_16x16DungeonTileset.v1.png")
    self.grid = anim8.newGrid(16,16, self.sprite:getWidth(), self.sprite:getHeight())
    self.anim = anim8.newAnimation(self.grid(1,5), 0.1)
    self.flip = false
    self.x = 200
    self.y = 100
    self.vel = 66
    knife = {}
    knife.sprite = love.graphics.newImage("Assets/KNIFE.png")
    knife.grid = anim8.newGrid(16,16, knife.sprite:getWidth(), knife.sprite:getHeight())
    knife.anim = anim8.newAnimation(knife.grid(9,7), 0.1)
    knife.rot = 0

end

--MOVEMENT
function Player:move(dt)
    if love.keyboard.isDown("d") then
        self.flip = false
        self.x = self.x + self.vel *dt
    end
    if love.keyboard.isDown("a") then
        self.flip = true
        self.x = self.x - self.vel *dt
    end
    if love.keyboard.isDown("w") then
        self.y = self.y - self.vel *dt
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + self.vel *dt
    end
end

-- LOOK AT MOUSE
function Player:look()
    mousex = love.mouse.getX()/2
    if mousex >= self.x then
        self.flip = false
    elseif mousex <= self.x then
        self.flip = true
    end
end

--BOUNDRY COLLISION
function Player:boundries()
    if self.x <= 25/2 then
        self.x = 25/2
    end
    if self.x >= 1222/2 then
        self.x = 1222/2
    end
    if self.y <= 55/2 then
        self.y = 55/2
    end
    if self.y >= 600/2 then
        self.y = 600/2
    end
end

--ATTACK
function Player:attack()
        love.mouse.setVisible(false)
        knife.x = love.mouse.getX()/2 
        knife.y = love.mouse.getY()/2
         knuf = cmpl.new(knife.x,knife.y)
         playa = cmpl.new(self.x,self.y)
         love.mouse.isVisible(false)
        angul = cmpl.angle_between(knuf,playa)/2
        knife.rot = -angul
        if knife.x > self.x+100/2 then
            knife.x = self.x+100/2
        end
        if knife.x < self.x-100/2 then
            knife.x = self.x-100/2
        end
        if knife.y > self.y+100/2 then
            knife.y = self.y+100/2
        end
        if knife.y < self.y-100/2 then
            knife.y = self.y-100/2
        end
        if love.mouse.getX() > self.x*2+100 then
            love.mouse.setX(self.x*2+100)
        end
        if love.mouse.getX() < self.x*2-100 then
            love.mouse.setX(self.x*2-100)
        end
        if love.mouse.getY() > self.y*2+100 then
             love.mouse.setY(self.y*2+100)
        end
        if love.mouse.getY()  < self.y*2-100 then
            love.mouse.setY(self.y*2-100)
        end


    

end

function Player:scoree()
    if score > highscore then
        highscore = score
        print(score)
        print(highscore)
    end
end

--UPDATE 
function Player:update(dt)
    self.anim:update(dt)
    self.anim.flippedH = self.flip
    self:move(dt)
    self:look()
    self:boundries()
    self:attack()
    self:scoree()

end

--DRAW
function Player:draw()
    knife.anim:draw(knife.sprite, knife.x,knife.y, knife.rot)
    self.anim:draw(self.sprite, self.x, self.y)
end

