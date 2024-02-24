local SRS={}
--[[
SRS Extend 180踢的设计：
1.{0,0} 2.踢离墙面/地面 3.翻离一格高的洞/穿梭一格远的隧道
4.传送sqrt(2)的距离（如果可以） 5.翻离两格高的洞/穿梭两格远的隧道 6.量子隧穿
]]
SRS={kickTable={
    Z={
        R={
            {{0,0},{-1, 0},{-1, 1},{ 0,-2},{-1,-2}}, --0->R
            {{0,0},{ 1, 0},{ 1,-1},{ 0, 2},{ 1, 2}}, --R->2
            {{0,0},{ 1, 0},{ 1, 1},{ 0,-2},{ 1,-2}}, --2->L
            {{0,0},{-1, 0},{-1,-1},{ 0, 2},{-1, 2}}  --L->0
        },
        L={
            {{0,0},{ 1, 0},{ 1, 1},{ 0,-2},{ 1,-2}},--0->L
            {{0,0},{ 1, 0},{ 1,-1},{ 0, 2},{ 1, 2}},--R->0
            {{0,0},{-1, 0},{-1, 1},{ 0,-2},{-1,-2}},--2->R
            {{0,0},{-1, 0},{-1,-1},{ 0, 2},{-1, 2}} --L->2
        },
        F={
            {{0,0},{ 0, 1},{ 1, 0},{-1, 0},{-1,-1},{ 1,-1},{ 2, 0},{ 0,-2}},--0->2
            {{0,0},{ 1, 0},{ 0,-1},{ 0, 1},{-1, 1},{-1,-1},{ 0, 2},{-2, 0}},--R->L
            {{0,0},{ 0,-1},{-1, 0},{ 1, 0},{ 1, 1},{-1, 1},{-2, 0},{ 0, 2}},--2->0
            {{0,0},{-1, 0},{ 0, 1},{ 0,-1},{ 1,-1},{ 1, 1},{ 0,-2},{ 2, 0}} --L->R
        }
    },

    I={
        R={
            {{0,0},{ 1, 0},{-2, 0},{-2,-1},{ 1, 2}},--0->R
            {{0,0},{-1, 0},{ 2, 0},{ 2,-1},{-1, 2}},--R->2
            {{0,0},{-1, 0},{ 2, 0},{ 2, 1},{-1,-2}},--2->L
            {{0,0},{ 1, 0},{-2, 0},{-2, 1},{ 1,-2}},--L->0
        },
        L={
            {{0,0},{-1, 0},{ 2, 0},{ 2,-1},{-1, 2}},--0->L
            {{0,0},{-1, 0},{ 2, 0},{ 2, 1},{-1,-2}},--R->0
            {{0,0},{ 1, 0},{-2, 0},{-2, 1},{ 1,-2}},--2->R
            {{0,0},{ 1, 0},{-2, 0},{-2,-1},{ 1, 2}} --L->2
        },
        F={
            {{0,0},{ 1, 0},{-1, 0},{ 0,-1},                { 0, 1}},
            {{0,0},{ 0,-1},{ 0, 1},{-1, 0},{-1,-1},{-1, 1},{ 1, 0}},
            {{0,0},{-1, 0},{ 1, 0},{ 0, 1},                { 0,-1}},
            {{0,0},{ 0, 1},{ 0,-1},{ 1, 0},{ 1,-1},{ 1, 1},{-1, 0}}
        }
    },
    O={
        R={{{0,0},{ 0,-1},{ 1,-1},{ 1, 0},{ 1, 1},{ 0, 1},{ 0, 2}}},
        L={{{0,0},{ 0,-1},{-1,-1},{-1, 0},{-1, 1},{ 0, 1},{ 0,-2}}},
        F={{{0,0},{ 0,-1},{ 0,-2},{ 0, 1},{ 0, 2}}}
    }
}}
for k,v in pairs(SRS.kickTable.O) do v[2],v[3],v[4]=v[1],v[1],v[1] end
SRS.kickTable.S={
    R=SRS.kickTable.Z.R,L=SRS.kickTable.Z.L,
    F={
        {{0,0},{ 0, 1},{-1, 0},{ 1, 0},{ 1,-1},{-1,-1},{-2, 0},{ 0,-2}},
        {{0,0},{ 1, 0},{ 0, 1},{ 0,-1},{-1,-1},{-1, 1},{ 0,-2},{-2, 0}},
        {{0,0},{ 0,-1},{ 1, 0},{-1, 0},{-1, 1},{ 1, 1},{ 2, 0},{ 0, 2}},
        {{0,0},{-1, 0},{ 0,-1},{ 0, 1},{ 1, 1},{ 1,-1},{ 0, 2},{ 2, 0}}
    }
}
SRS.kickTable.T={
    R=SRS.kickTable.Z.R,L=SRS.kickTable.Z.L,
    F={
        {{0,0},{ 0, 1},{ 1, 0},{-1, 0},{-2, 0},{ 2, 0},{ 0,-2}},
        {{0,0},{ 1, 0},{ 1, 1},{ 0, 1},{ 2, 0},{ 0,-2},{-2, 0}},
        {{0,0},{ 0,-1},{-1, 0},{ 1, 0},{-2, 0},{ 2, 0},{ 0, 2}},
        {{0,0},{-1, 0},{-1, 1},{ 0, 1},{-2, 0},{ 0, 2},{ 2, 0}}
    }
}
SRS.kickTable.J=SRS.kickTable.Z SRS.kickTable.L=SRS.kickTable.S
return SRS