local anim8 = require "anim8"
require('collision')
Enemy = {}
function Enemy:load()
    math.randomseed(os.time())
    self.sprite = love.graphics.newImage("Assets/0x72_16x16DungeonTileset.v1.png")
    self.grid = anim8.newGrid(16,16, self.sprite:getWidth(), self.sprite:getHeight())
    self.anim = anim8.newAnimation(self.grid(6,7), 0.1)
    self.x = math.random(25/2,1222/2)
    self.y = math.random(55/2,600/2)
    self.vel = 50
    dead = false
end

function Enemy:update(dt,Kx,Ky,px,py)
    self:behaviour(Kx,Ky)
    self:movment(px,py,dt)
    self:murder(px,py)
    self:dead()
end


function Enemy:behaviour(Kx,Ky)
    H = math.random(0,1)
    if math.random() < 0.003 then 
        enemys = {}
    
        enemys.sprite = love.graphics.newImage("Assets/0x72_16x16DungeonTileset.v1.png")
        enemys.grid = anim8.newGrid(16,16, self.sprite:getWidth(), self.sprite:getHeight())
        enemys.anim = anim8.newAnimation(self.grid(6,7), 0.1)
        if H == 1 then
            enemys.x = math.random(25/2,30/2)
            enemys.y = math.random(55/2,600/2)
        end
        if H == 0  then
            enemys.x = math.random(1222/2,1222/2)
            enemys.y = math.random(55/2,600/2)
        end
           
        enemys.vel = 50
        table.insert(self,enemys)
    end

    for i = #self, 1, -1 do
        enemys = self[i]
        if AABB(enemys.x,enemys.y,16,16,Kx,Ky,12,12) then
            knef:play()
            table.remove(self, i)
            score = score + 1
        end

    end
end

function Enemy:movment(px,py,dt)
    for i=#self,1,-1 do
        enemys = self[i]
        local player_dx = px - enemys.x
        local player_dy = py - enemys.y
        enemys.angle = math.atan2(player_dy, player_dx)

        local vx = enemys.vel * math.cos(enemys.angle)
        local vy = enemys.vel * math.sin(enemys.angle)
    
    
        local d = math.sqrt(player_dx^2 + player_dy^2)
        if d > 10 then
            enemys.x = enemys.x + vx * dt
            enemys.y = enemys.y + vy * dt
        end
    end
  
end

function Enemy:dead()
    if dead == true then
        for i = #self, 1, -1 do
            enemys = self[i]
            table.remove(self, i)
        end
        score = 0
    end
end
function Enemy:murder(px,py)
    for i = #self, 1, -1 do
        enemys = self[i]
        if AABB(enemys.x,enemys.y,16,16,px,py,16,16) then
            death:play()
            dead = true
            background:stop()
        end 
    end
end

function Enemy:draw()
    for i = #self, 1, -1 do
        enemys = self[i]
        self.anim:draw(enemys.sprite, enemys.x, enemys.y)
    end
end



