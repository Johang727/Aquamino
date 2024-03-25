local gc=love.graphics
local bg={}
local n=12
function bg.draw()
    gc.clear(.04,.04,.04)
    gc.setLineWidth(450/n)
    for i=1,n do
        gc.setColor(COLOR.hsv((i-1)/n*6,.5,1,.4))
        gc.circle('line',0,0,900/n*(i+.5))
        local t=(scene.time*(1-(i-1)/n))%2
        gc.arc('line','open',0,0,900/n*(i+.5),(t)*math.pi,(t+.5)*math.pi)
        gc.arc('line','open',0,0,900/n*(i+.5),(t+1)*math.pi,(t+1.5)*math.pi)
    end
end
return bg