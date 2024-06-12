local anim={}--animation的缩写

function anim.init()--第一帧不能用来画图，会出问题
end
function anim.cover(inT,keepT,outT,r,g,b)
    if scene.swapT>keepT then 
        gc.setColor(r,g,b,1-((scene.swapT-keepT)/inT))
    elseif scene.swapT>0 then
        gc.setColor(r,g,b)
    else
        gc.setColor(r,g,b,scene.outT/outT)
    end
    gc.rectangle('fill',-960,-540,1920,1080)
end

function anim.enterMenu(inT,keepT,outT)
    gc.setColor(.05,.05,.05)
    if scene.swapT>0 then
        local rect_w=1-((scene.swapT-keepT)/inT)^3
        if scene.swapT>keepT then
            gc.rectangle('fill',-960,-540,960*rect_w,1080)
            gc.rectangle('fill',960-960*rect_w,-540,960*rect_w,1080)
            gc.setColor(1,1,1)
            gc.setLineWidth(15)
            gc.arc('line','open',-960+960*rect_w,0,150,math.pi/2,3*math.pi/2,2)
            gc.arc('line','open', 960-960*rect_w,0,150,-math.pi/2, math.pi/2,2)
        else
            local angle=mymath.clamp((scene.swapT/keepT-1/2)*2,0,1)^2*math.pi/2
            gc.rectangle('fill',-960,-540,1920,1080)
            gc.setColor(1,1,1)
            gc.setLineWidth(15)
            gc.arc('line','closed',0,0,150,-math.pi/2+angle,math.pi+angle,3)
        end
    else
        local sz=1920*(-(1-scene.outT/outT)^3+1)
        gc.circle('fill',-960,960,sz,4) gc.circle('fill',960,-960,sz,4)
        gc.circle('fill',960,960,sz,4) gc.circle('fill',-960,-960,sz,4)
        gc.setColor(1,1,1)
        gc.setLineWidth(1920-sz<=150 and 15 or 5+10*(1920-sz-150)/(1920-150))
        gc.arc('line','open',0,0,max(150,1920-sz),-math.pi/2,3*math.pi/2,4)
    end
end

local r6=960*2/3^.5
function anim.confSelect(inT,keepT,outT)
    if scene.swapT>0 then
        local w=1-((scene.swapT-keepT)/inT)
        if scene.swapT>keepT then
            gc.setColor(.1,.1,.1)
            gc.setLineWidth(1920*w)
            gc.arc('fill','closed',0,0,r6*w,math.pi/2,5*math.pi/2,6)
        else
            gc.setColor(.1,.1,.1)
            gc.rectangle('fill',-960,-540,1920,1080)
        end
    else
        gc.setColor(.1,.1,.1)
        local w=(-(1-scene.outT/outT)+1)
        gc.setLineWidth(1920*w)
        gc.arc('line','closed',0,0,r6,math.pi/2,5*math.pi/2,6)
    end
end
function anim.confBack(inT,keepT,outT)
    if scene.swapT>0 then
        local w=1-((scene.swapT-keepT)/inT)
        if scene.swapT>keepT then
            gc.setColor(.1,.1,.1)
            gc.setLineWidth(1920*w)
            gc.arc('line','closed',0,0,r6,math.pi/2,5*math.pi/2,6)
        else
            gc.setColor(.1,.1,.1)
            gc.rectangle('fill',-960,-540,1920,1080)
        end
    else
        local w=(-(1-scene.outT/outT)+1)
        gc.setColor(.1,.1,.1)
        gc.setLineWidth(1920*w)
        gc.arc('fill','closed',0,0,r6*w,math.pi/2,5*math.pi/2,6)
    end
end

function anim.enter2(inT,keepT,outT)
    local rect_w=(1-((scene.swapT-keepT)/inT))^2
    gc.setColor(0,0,0)
    if scene.swapT>0 then
        if scene.swapT>keepT then
            gc.rectangle('fill',-960*rect_w,-550,1920*rect_w,1100)
        else
            gc.rectangle('fill',-960,-540,1920,1080)
            gc.rectangle('line',-960,-540,1920,1080)
        end
    else
        for i=1,8 do for j=1,9 do
            if scene.outT/outT>(j+8)/18 then gc.setColor(0,0,0)
                gc.rectangle('fill',-960+120*(2*i-2),-540+120*(j-1),120,120)
                gc.rectangle('fill',-960+120*(2*i-1),-540+120*(9-j),120,120)
            elseif scene.outT/outT>(j-1)/18 then gc.setColor(0,0,0,.625)
                gc.rectangle('fill',-960+120*(2*i-2),-540+120*(j-1),120,120)
                gc.rectangle('fill',-960+120*(2*i-1),-540+120*(9-j),120,120)
            end
        end end
    end
end

function anim.enterUL(inT,keepT,outT)
    if scene.swapT>0 then
        if scene.swapT>keepT then
        local w=1-(scene.swapT-keepT)/inT
            gc.setColor(.05,.05,.05)
            gc.circle('fill',-960,-540,3000*w,4)
        else
            gc.setColor(.05,.05,.05)
            gc.rectangle('fill',-960,-540,1920,1080)
        end
    else
        local w=-(1-scene.outT/outT)+1
        gc.setColor(.05,.05,.05)
        gc.circle('fill',960,540,3000*w,4)
    end
end
function anim.enterUR(inT,keepT,outT)
    if scene.swapT>0 then
        if scene.swapT>keepT then
        local w=1-(scene.swapT-keepT)/inT
            gc.setColor(.05,.05,.05)
            gc.circle('fill',960,-540,3000*w,4)
        else
            gc.setColor(.05,.05,.05)
            gc.rectangle('fill',-960,-540,1920,1080)
        end
    else
        local w=-(1-scene.outT/outT)+1
        gc.setColor(.05,.05,.05)
        gc.circle('fill',-960,540,3000*w,4)
    end
end
function anim.enterDL(inT,keepT,outT)
    if scene.swapT>0 then
        if scene.swapT>keepT then
        local w=1-(scene.swapT-keepT)/inT
            gc.setColor(.05,.05,.05)
            gc.circle('fill',-960,540,3000*w,4)
        else
            gc.setColor(.05,.05,.05)
            gc.rectangle('fill',-960,-540,1920,1080)
        end
    else
        local w=-(1-scene.outT/outT)+1
        gc.setColor(.05,.05,.05)
        gc.circle('fill',960,-540,3000*w,4)
    end
end
function anim.enterDR(inT,keepT,outT)
    if scene.swapT>0 then
        if scene.swapT>keepT then
        local w=1-(scene.swapT-keepT)/inT
            gc.setColor(.05,.05,.05)
            gc.circle('fill',960,540,3000*w,4)
        else
            gc.setColor(.05,.05,.05)
            gc.rectangle('fill',-960,-540,1920,1080)
        end
    else
        local w=-(1-scene.outT/outT)+1
        gc.setColor(.05,.05,.05)
        gc.circle('fill',-960,-540,3000*w,4)
    end
end
return anim