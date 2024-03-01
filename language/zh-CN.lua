return {
    warning={
        title="光敏性癫痫警告",
        txt="极小部分人可能会在看到特定视觉图像（包括可能出现在视频游戏中的闪烁效果或图案）时出现癫痫症状。\n此类症状包括头晕目眩、视线模糊、眼睛或面部抽搐、四肢抽搐、迷失方向感、精神错乱或短暂的意识丧失。\n\n即使没有癫痫史的人也可能出现此类症状。\n如果你出现任何症状，请立即停止游戏并咨询医生。",
        txtScale=50/128,txtWidth=4000
    },
    intro={
        start="按任意键开始",
        mode={"练习","挑战","秘境","理堂"}
    },
    menu={
        modeName={
            ['40 lines']="40行",
            marathon="马拉松",
            ['ice storm']="冰风暴",
            thunder="雷暴",
            smooth="丝滑40行",
            master="宗师",
            multitasking="多线程",
            sandbox="沙盒子"
        },
        illust="双击/按Enter键开始游戏\n按R键随机跳转",
        iScale=.6
    },
    pause={
        resume="继续",quit="退出",r="重开"
    },
    game={
        nowPlaying="当前播放 : ",
        theme={
            simple={win="胜利",lose="失败"}
        }
    },
    conf={
        back="返回",test="测试",
        main={title="设置 - 主页",audio="音频设置",video="画面设置",custom="个性设置",ctrl="控制设置",keys="键位设置",other="其它..."},
        audio={mus="音乐音量:",sfx="音效音量:",distract="失去焦点自动静音",DOX=0},
        video={
            unableBG="禁用游戏背景",unableTxt="若游戏背景导致你身体不适，请打开此选项。",
            fullScr="全屏",fullScrTxt="按F11可一键切换窗口状态。",
            vsync="垂直同步",vsyncTxt="若感觉画面严重撕裂，尝试调整此选项。一般不建议打开。"
        },
        custom={
            texture="方块材质",color="颜色设置",
            smooth="平滑运动[测试]",smoothTxt="注意，移动和旋转没有中间态，只要终点没有障碍，操作就必定可以成功。",
            smoothOffX=0,smoothOffY=0,
            theme="主题",
            scale="场地缩放",scaleTxt="数值为1时，对于1920*1080的窗口，单格方块大小为36*36。",
            sfx="音效包",sfxWarning={
                otto="该音效包包含音量过大内容，请谨慎选择。"
            },
            colorSet={
                title="调整方块颜色",
                rAll="重置所有",rCur="重置当前",
                adjY="该皮肤可自由调整颜色。",
                adjN="该皮肤不可调整颜色。"
            }
        },
        keys={
            keyName={'左移','右移','顺转','逆转','翻转','软降','硬降','暂存','重开','暂停'},
            kScale=.5,
            info="点击添加键位绑定（最多3个）\nBackspace清空选定键位\n按下已绑定键位以删除该绑定"
        },
        handling={
            ASD="自动移动延迟(ASD,旧称DAS):",ASP="自动移动周期(ASP,旧称ARR):",
            SD_ASD="软降ASD:",SD_ASP="软降ASP:"
        },
        other={title="其它设置",nothing="暂无内容"},
        lang={cur="当前语言：简体中文"}
    }
}