--[[
kicktable={
R={ 0->R , R->2 , 2->L , L->0 },
L={ 0->L , R->0 , 2->R , L->2 },
F={ 0->2 , R->L , 2->0 , L->R }
}
]]
local function getSymTable(table)--生成对称的踢墙表给对称的块用
    local newTable={R={{},{},{},{}},L={{},{},{},{}},F={{},{},{},{}}}
    for i=1,4 do
        local k=1+(1-i)%4
        for j=1,#table.R[i] do
            newTable.L[i][j]={-table.R[k][j][1],table.R[k][j][2]}
        end
        for j=1,#table.L[i] do
            newTable.R[i][j]={-table.L[k][j][1],table.L[k][j][2]}
        end
        for j=1,#table.F[i] do
            newTable.F[i][j]={-table.F[k][j][1],table.F[k][j][2]}
        end
    end
    return newTable
end

--[[
AqRS：增加大量实用踢墙，对于I、T、O，会根据周围砖格选择踢墙表
]]
local AqRS={}--Aqua(mino) Rotation System
AqRS.kickTable={
    L={
        R={
            {{0,0},{-1, 0},{-1, 1},{ 0,-2},{-1,-2},{-1,-1},{ 0, 1},{ 1, 1},{ 1, 0},{ 0,-1}},--0->R
            {{0,0},{ 1, 0},{ 1,-1},{ 0, 1},{ 0, 2},{ 1, 1},{ 1, 2},{-1, 1},{ 0,-1},{-1, 0}},--R->2
            {{0,0},{ 1, 0},{ 1, 1},{ 0,-2},{ 1,-1},{ 1,-2},{ 0,-1},{-1,-1},{-1, 0},{ 0, 1}},--2->L
            {{0,0},{-1, 0},{-1,-1},{ 0,-1},{ 0, 2},{-1, 1},{-1, 2},{ 1,-1},{ 0, 1},{ 1, 0}} --L->0
        },
        L={
            {{0,0},{ 1, 0},{ 1, 1},{ 0,-2},{ 1,-2},{ 0, 1},{ 1,-1},{-1, 1},{ 0,-1},{-1, 0}},--0->L
            {{0,0},{ 1, 0},{ 1,-1},{ 1, 1},{ 0, 2},{ 1, 2},{ 0,-1},{-1,-1},{-1, 0},{ 0, 1}},--R->0
            {{0,0},{-1, 0},{-1,-1},{ 0,-1},{ 0,-2},{-1, 1},{-1,-2},{ 1,-1},{ 0, 1},{ 1, 0}},--2->R
            {{0,0},{-1, 0},{-1,-1},{-1, 1},{ 0, 2},{-1, 2},{ 0, 1},{ 1, 1},{ 1, 0},{ 0,-1}} --L->2
        },
        F={
            {{0,0},{ 0, 1},{-1, 0},{ 1, 0},{ 1,-1},{-1,-1},{-2, 0},{ 0,-2}},--0->2
            {{0,0},{ 1, 0},{ 0, 1},{ 0,-1},{-1,-1},{-1, 1},{ 0,-2},{-2, 0}},--R->L
            {{0,0},{ 0,-1},{ 1, 0},{-1, 0},{-1, 1},{ 1, 1},{ 2, 0},{ 0, 2}},--2->0
            {{0,0},{-1, 0},{ 0,-1},{ 0, 1},{ 1, 1},{ 1,-1},{ 0, 2},{ 2, 0}} --L->R
        }
    },
    T={
        R={
            {{0,0},{-1, 0},{-1, 1},{ 0,-2},{-1,-1},{-1,-2},{ 0, 1},{ 1, 1},{-2, 0}},
            {{0,0},{ 1, 0},{ 1,-1},{ 0, 1},{ 0, 2},{ 1, 1},{ 1, 2},{-1, 1},{ 2, 0}},
            {{0,0},{ 1, 0},{ 1, 1},{ 0,-2},{ 1,-1},{ 1,-2},{ 0,-1},{-1,-1},{ 2, 0}},
            {{0,0},{-1, 0},{-1,-1},{ 0,-1},{ 0, 2},{-1, 1},{-1, 2},{ 1,-1},{-2, 0}}
        },
        L={
            {{0,0},{ 1, 0},{ 1, 1},{ 0,-2},{ 1,-1},{ 1,-2},{ 0, 1},{-1, 1},{ 2, 0}},
            {{0,0},{ 1, 0},{ 1,-1},{ 0,-1},{ 0, 2},{ 1, 1},{ 1, 2},{-1,-1},{ 2, 0}},
            {{0,0},{-1, 0},{-1, 1},{ 0,-2},{-1,-1},{-1,-2},{ 0,-1},{ 1,-1},{-2, 0}},
            {{0,0},{-1, 0},{-1,-1},{ 0, 1},{ 0, 2},{-1, 1},{-1, 2},{ 1, 1},{-2, 0}}
        },
        FL={
            {{0,0},{ 0, 1},{-1, 0},{ 1, 0},{-1, 1},{ 1, 1},{-2, 0},{ 2, 0},{ 0,-2}},
            {{0,0},{ 1, 0},{ 0,-1},{ 0, 1},{ 1, 1},{ 1,-1},{ 2, 0},{ 0,-2},{-2, 0}},
            {{0,0},{ 0,-1},{ 1, 0},{-1, 0},{ 1,-1},{-1,-1},{ 2, 0},{-2, 0},{ 0, 2}},
            {{0,0},{-1, 0},{ 0,-1},{ 0, 1},{-1, 1},{-1,-1},{-2, 0},{ 0, 2},{ 2, 0}}
        },
        FR={
            {{0,0},{ 0, 1},{ 1, 0},{-1, 0},{ 1, 1},{-1, 1},{ 2, 0},{-2, 0},{ 0,-2}},
            {{0,0},{ 1, 0},{ 0,-1},{ 0, 1},{ 1, 1},{ 1,-1},{ 2, 0},{ 0,-2},{-2, 0}},
            {{0,0},{ 0,-1},{-1, 0},{ 1, 0},{-1,-1},{ 1,-1},{-2, 0},{ 2, 0},{ 0, 2}},
            {{0,0},{-1, 0},{ 0,-1},{ 0, 1},{-1, 1},{-1,-1},{-2, 0},{ 0, 2},{ 2, 0}}
        }
    },

    I={
        RU={--平放时钻洞优先
            {{0,0},{ 1, 0},{-2,-1},{ 0,-1},{-2, 0},{ 1, 2},{ 0, 2},{ 1, 1},{ 0, 1},{-1,-1},{-1, 0},{-1, 1}},--0->R
            {{0,0},{-1, 0},{ 2,-1},{ 0,-1},{ 2, 0},{-1, 2},{ 0, 2},{-1, 1},{ 0, 1},{-1, 1},{ 1, 0},{ 1, 1}},--R->2
            {{0,0},{-1, 0},{-1,-2},{ 0, 1},{ 2, 0},{ 2, 1},{ 0,-2},{-1,-1},{ 0,-1},{ 1, 1},{ 1, 0},{ 1,-1}},--2->L
            {{0,0},{ 1, 0},{ 1,-2},{ 0, 1},{-2, 0},{-2, 1},{ 0,-2},{ 1,-1},{ 0,-1},{ 1,-1},{-1, 0},{-1,-1}} --L->0
        },
        R={--平放时翻越优先
            {{0,0},{ 1, 0},{ 1, 2},{ 0,-1},{-2, 0},{-2,-1},{ 0, 2},{ 1, 1},{ 0, 1},{-1,-1},{-1, 0},{-1, 1}},--0->R
            {{0,0},{-1, 0},{ 2,-1},{ 0,-1},{ 2, 0},{-1, 2},{ 0, 2},{-1, 1},{ 0, 1},{-1, 1},{ 1, 0},{ 1, 1}},--R->2
            {{0,0},{-1, 0},{ 2, 1},{ 0, 1},{ 2, 0},{-1,-2},{ 0,-2},{-1,-1},{ 0,-1},{ 1, 1},{ 1, 0},{ 1,-1}},--2->L
            {{0,0},{ 1, 0},{ 1,-2},{ 0, 1},{-2, 0},{-2, 1},{ 0,-2},{ 1,-1},{ 0,-1},{ 1,-1},{-1, 0},{-1,-1}} --L->0
        },
        LU={--平放时钻洞优先
            {{0,0},{-1, 0},{ 2,-1},{ 0,-1},{ 2, 0},{-1, 2},{ 0, 2},{-1, 1},{ 0, 1},{-1, 1},{ 1, 0},{ 1, 1}},--0->L
            {{0,0},{-1, 0},{-1,-2},{ 0, 1},{ 2, 0},{ 2, 1},{ 0,-2},{-1,-1},{ 0,-1},{ 1, 1},{ 1, 0},{ 1,-1}},--R->0
            {{0,0},{ 1, 0},{ 1,-2},{ 0, 1},{-2, 0},{-2, 1},{ 0,-2},{ 1,-1},{ 0,-1},{ 1,-1},{-1, 0},{-1,-1}},--2->R
            {{0,0},{ 1, 0},{-2,-1},{ 0,-1},{-2, 0},{ 1, 2},{ 0, 2},{ 1, 1},{ 0, 1},{-1,-1},{-1, 0},{-1, 1}} --L->2
        },
        L={--平放时翻越优先
            {{0,0},{-1, 0},{-1, 2},{ 0,-1},{ 2, 0},{ 2,-1},{ 0, 2},{-1, 1},{ 0, 1},{-1, 1},{ 1, 0},{ 1, 1}},--0->L
            {{0,0},{-1, 0},{-1,-2},{ 0, 1},{ 2, 0},{ 2, 1},{ 0,-2},{-1,-1},{ 0,-1},{ 1, 1},{ 1, 0},{ 1,-1}},--R->0
            {{0,0},{ 1, 0},{ 1,-2},{ 0, 1},{-2, 0},{-2, 1},{ 0,-2},{ 1,-1},{ 0,-1},{ 1,-1},{-1, 0},{-1,-1}},--2->R
            {{0,0},{ 1, 0},{-2,-1},{ 0,-1},{-2, 0},{ 1, 2},{ 0, 2},{ 1, 1},{ 0, 1},{-1,-1},{-1, 0},{-1, 1}} --L->2
        },
        F={
            {{0,0},{ 1, 0},{-1, 0},{ 0,-1},{-1,-1},{ 1,-1},{ 0, 1}},
            {{0,0},{ 0,-1},{ 0, 1},{-1, 0},{-1,-1},{-1, 1},{ 1, 0}},
            {{0,0},{-1, 0},{ 1, 0},{ 0, 1},{-1, 1},{ 1, 1},{ 0,-1}},
            {{0,0},{ 0, 1},{ 0,-1},{ 1, 0},{ 1,-1},{ 1, 1},{-1, 0}}
        }
    },
    O={--嵌套少一层
        RT={{ 0,-1},{ 1,-1},{ 1,-2},{ 1, 0},{ 1, 1},{ 1, 2},{ 3, 0},{ 2,-1},{ 2,-2},{ 0, 1},{ 2, 1},{ 2, 2},{0,0}},
        RL={{ 1, 0},{ 1, 1},{ 1, 2},{ 3, 0},{0,0}},
        LT={{ 0,-1},{-1,-1},{-1,-2},{-1, 0},{-1, 1},{-1, 2},{-3, 0},{-2,-1},{-2,-2},{ 0, 1},{-2, 1},{-2, 2},{0,0}},
        LL={{-1, 0},{-1, 1},{-1, 2},{-3, 0},{0,0}},
        FT={{ 0,-3},{0,0}},
        FL={{ 0,-3},{ 0, 3},{0,0}},
        default={{0,0}}
    }
}
--AqRS.kickTable.S=getSymTable(AqRS.kickTable.Z)
AqRS.kickTable.J=getSymTable(AqRS.kickTable.L)
AqRS.kickTable.S=AqRS.kickTable.L AqRS.kickTable.Z=AqRS.kickTable.J

function AqRS.getData(data,player,fLib)
    data.u=fLib.coincide(player, 0, 1)
    data.d=fLib.coincide(player, 0,-1)
    data.l=fLib.coincide(player,-1, 0)
    data.r=fLib.coincide(player, 1, 0)
end
function AqRS.getKickTable(data,name,ori,mode)
    if name=='O' then
        if mode=='R' then
            if data.d then return AqRS.kickTable[name].RT
            elseif data.r then return AqRS.kickTable[name].RL
            end
        elseif mode=='L' then
            if data.d then return AqRS.kickTable[name].LT
            elseif data.l then return AqRS.kickTable[name].LL
            end
        elseif mode=='F' then
            if data.u then return AqRS.kickTable[name].FL
            elseif data.d then return AqRS.kickTable[name].FT
            end
        end
        return AqRS.kickTable[name]['default']
    elseif name=='T' and mode=='F' then
        if data.l then return AqRS.kickTable[name].FL[ori]
        else return AqRS.kickTable[name].FR[ori] end
    elseif name=='I' and mode~='F' then--根据上方有无方块，判定平放时是钻洞还是翻越
        if mode=='R' then
            if data.u then return AqRS.kickTable[name].RU[ori] else return AqRS.kickTable[name].R[ori] end
        else
            if data.u then return AqRS.kickTable[name].LU[ori] else return AqRS.kickTable[name].L[ori] end
        end
    else return AqRS.kickTable[name][mode][ori]
    end
end
return AqRS