require("anim8")
require("player")
require("enemy")
score = 0
highscore = 0
local STI = require("sti")
love.graphics.setDefaultFilter("nearest", "nearest")
function love.load()
    background = love.audio.newSource("music/background.mp3","stream")
    background:setLooping(true)
    death = love.audio.newSource("music/death sound.mp3", "static")
    knef = love.audio.newSource("music/knife.mp3","static")
    game = "menue"
    font = love.graphics.newFont("Right.ttf", 24)
    Map =  STI("maps/doungeon.lua", {"box2d"})
    world = love.physics.newWorld(0,0)
    Player:load()
    Enemy:load()
    paused = false
    

end

function love.update(dt)
   
	
    
    CLICK()
    if game == "play" then 
        Pause()
        if paused == false and  dead == false then
            background:play()
            Player:update(dt)
            Enemy:update(dt,knife.x,knife.y,Player.x,Player.y)

        end
    end
  
end

function love.draw()

    love.graphics.setFont(font)
    if game == "play" then
        love.graphics.push()
            if paused == false then
                love.graphics.scale(2, 2)
                Map:draw(0,0,2,2)
                Player:draw()
                Enemy:draw()
            end
            if paused == true then
                love.graphics.setBackgroundColor(0.2,0.2,0.2)
                love.mouse.setVisible(true)
            end
            if dead == true then
                love.graphics.setBackgroundColor(0.2,0.2,0.2)
                love.mouse.setVisible(true)
            end
             love.graphics.pop()
            if paused == true then
                love.graphics.print("PAUSED", 600,300)
                love.graphics.print("CONTINUE",590,350)
                love.graphics.print("QUIT",620,400)
            end
            if dead == true then 
                game = "dead"
            end
   
            love.graphics.print("score: ".. score)
            love.graphics.print("highscore: ".. highscore, 0, 25)
    end
    if game == "menue" then
        love.graphics.setBackgroundColor(0.2,0.2,0.2)
        love.graphics.print("Play", 600,300)
        love.graphics.print("Tutorial", 586,340)
        love.graphics.print("Quit",600,380)
    end
    if game == "tutorial" then
        love.graphics.setBackgroundColor(0.2,0.2,0.2)
        love.graphics.print("-Press W, A, S, D to move",450,280)
        love.graphics.print("-Use the mouse to kill enemies",450,320)
        love.graphics.print("-Press e to pause and r/left click to unpause",450,360 )
        love.graphics.print("-Press e to get out of this tutorial", 450,400)
    end
    if game == "dead" then
        love.graphics.setBackgroundColor(0.2,0.2,0.2)
        love.mouse.setVisible(true)
        love.graphics.print("YOU DIED", 600,300)
        love.graphics.print("TRY AGAIN", 595,340)
    end
end

function Pause()
    if love.keyboard.isDown("e")  and dead == false then
        paused = true

    end
    if love.keyboard.isDown("r") then
        paused = false
        
    end

    if dead == true and love.keyboard.isDown("x") then 
        dead = false
    end
end

function CLICK()
    if paused == true then
        if love.mouse.isDown(1) and love.mouse.getY() <= 350  then
            paused = false
        end
        if love.mouse.isDown(1) and love.mouse.getY() >= 400  then
            love.mouse.setPosition(0,0)
            game = "menue"
        end

    end
    if game == "menue" then
    
        if love.mouse.getY() <= 320 and love.mouse.isDown(1) then
            game = "play"
        end
        if love.mouse.getY() >= 340 and love.mouse.isDown(1) then
            game = "tutorial"
        end
        if love.mouse.getY() >= 380 and love.mouse.isDown(1) then
            os.exit()
        end
        

       
    end
    if game == "tutorial" and love.keyboard.isDown("e")then
        game = "menue"
    end
    if game == "dead" and love.mouse.isDown(1) then
        game = "play"
        dead = false
    end

end