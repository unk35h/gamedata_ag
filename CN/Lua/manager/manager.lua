manager = {}
slot0 = import("game.tools.ViewTools")
LoginAction = require("game.action.LoginAction")
manager.managerInit = false

function manager.init()
	manager.path = PathManager.inst
	manager.net = NetManager.New()
	manager.notify = NotificationCenter.GetInstance()

	require("game/action/ActionInclude")

	manager.gc = GCManager.New()
	manager.time = TimeMgr.New()
	manager.audio = AudioMgr.New()
	manager.redPoint = RedPointMgr.New()
	manager.resourcePool = ResourcesPool.New()
	manager.guide = GuideManager.New()
	manager.achievementTips = AchievementTipsMgr.New()
	manager.share = ShareMgr.New()
	manager.loadScene = LoadSceneMgr.New()

	require("game/redPoint/RedPointInclude")
end

function manager.uiInit()
	print("manager.uiInit")

	if manager.managerInit then
		return
	end

	manager.managerInit = true
	manager.ui = UIManager.New()
	manager.tips = TipsMgr.New()
	manager.messageBox = ShowMessageMgr.New()
	manager.loadui = LoadUIMgr.New()
	manager.effect = EffectMgr.New()
	manager.story = StoryMgr.New()
	manager.inputWindow = InputWindowMgr.New()

	manager.audio:InitListener()

	manager.windowBar = WindowBarMgr.New()
	manager.transition = ShowTransitionMgr.New()

	manager.transition:RegistCanEndFunc(uv0.GetIsLoadied)

	manager.objectPool = ObjectPool.New()
	manager.commonItemPool = LuaItemPool.New(CommonItem, "UI/Common/CommonItem")
	manager.classPool = ClassesPool.New()
	manager.matrixPop = MatrixPopMgr.New()
	manager.video = VideoPlayMgr.New()

	print("Initialize Complete")
end

function manager.destroy()
	if manager.managerInit == false then
		return
	end

	manager.managerInit = false

	manager.ui:Dispose()
	ReduxFactory.GetInstance():ClearCacheViews()
	manager.tips:Dispose()
	manager.messageBox:Dispose()
	manager.loadui:Dispose()
	manager.effect:UnloadAllEffect()
	manager.story:Dispose()
	manager.inputWindow:Dispose()
	manager.windowBar:Dispose()
	manager.resourcePool:Dispose()
	manager.objectPool:Dispose()
	manager.commonItemPool:Dispose()
	manager.classPool:Dispose()
	manager.transition:Dispose()
	manager.redPoint:Dispose()
	manager.matrixPop:Dispose()
	manager.loadScene:Dispose()
	manager.video:Dispose()
	ReduxFactory.GetInstance():PrintExistingObjectInfo()
	manager.gc:Collect()
	manager.guide.view:Dispose()
end
