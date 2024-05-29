local bg={
    --Y=Asin(ωx+φ)+c
    base=0,--基础亮度
    amp=.5,--振幅
    ring=60,--塞进去多少个环（采样点）
    freq=5,--波频
    speed=.75,--背景时间流速
    edge=8,--环有几条边
}
local hsv=COLOR.hsv
local tau=2*math.pi
function bg.init(base,amp,ring,freq,speed,edge)
    bg.base=base or 0  bg.amp=amp or .5  bg.ring=ring or 60  bg.freq=freq or 5  bg.speed=speed or .75  bg.edge=edge or 8
end
function bg.update(dt)
    --wave.freq=(wave.freq+2*dt)%wave.ring
end
function bg.draw()
    local W=bg
    gc.setColor(hsv(scene.time,1,.16))
    gc.rectangle('fill',-960,-540,1920,1080)
    for i=1,W.ring do
        gc.setColor(1,1,1,W.base+W.amp*sin( (i*W.freq/W.ring-scene.time*W.speed) *tau) *(i/W.ring))
        gc.setLineWidth(2400/W.ring*sin( (1-2/W.edge) *math.pi/2) )
        gc.circle('line',0,0,2400/W.ring*(i-.5),W.edge)
    end
    gc.setColor(1,1,1)
end
return bg
