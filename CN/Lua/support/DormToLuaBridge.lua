Dorm.timer = {}

function Dorm.NewTimer(...)
	slot0 = Timer.New(...)

	table.insert(Dorm.timer, slot0)

	return slot0
end

function OnEnterDormScene()
	DormLuaBridge.CalcDormSpawnBounds()

	if DormData:GetCurrectSceneID() >= 1000 then
		Dorm.DormEntityManager.EnablePlayerInput = false
	else
		Dorm.DormEntityManager.EnablePlayerInput = true
	end

	Dorm.storage = DormStorage.GetInstance()

	Dorm.storage:Reset()
	manager.uiInit()
	DormRegisterCMDEvent()
	DormCharacterManager.GetInstance():Init()
	DormFurnitureManager.GetInstance():Init()
	DormCharacterActionManager:Init()
	DormCharacterInteractBehaviour:Init()

	if DormTools:GetFlag() then
		gameContext:Go("/dormVisitView")
		DormTools:VisitFlag(nil)
	else
		gameContext:Go("/dorm")
	end

	manager.windowBar:SetWhereTag("dorm")
	DormTools:GenerateFurnitureWhenEnterScene()
	DormTools:GenerateHeroWhenEnterScene()
	Dorm.Enter()
end

function OnExitDormScene(slot0)
	Dorm.Leave()
	manager.windowBar:ClearWhereTag()
	DestroyLua()
	DormCharacterManager.GetInstance():Reset()
	DormFurnitureManager.GetInstance():Reset()
	DormCharacterInteractBehaviour:Reset()
	DormCharacterActionManager:Reset()
end

function OnClickFurniture(slot0, slot1)
	JumpTools.OpenPageByJump("/furnitureEdit", {
		type = "edit",
		itemId = slot0,
		furEntityID = slot1
	})
end

function OnEnterCanteenScene()
	Dorm.DormEntityManager.EnablePlayerInput = false
	Dorm.sceneItemInfo = {}

	DormItemTag.RecordInfo()

	Dorm.timer = {}
	Dorm.storage = DormStorage.GetInstance()

	Dorm.storage:Reset()

	Dorm.restaurant = CanteenManager.GetInstance()

	LuaForUtil.UpdateCameraSetting()
	manager.uiInit()
	DormRegisterCMDEvent()
	manager.windowBar:SetWhereTag("canteen")
	Dorm.restaurant:RegisterEvent()
	Dorm.restaurant:Init()
	gameContext:Go("/restaurantMain")
	CanteenData:ConsumeNotification(RedPointConst.CANTEEN_BUSINESS_STOPPED, CanteenData.RedPointType.Session)
	Dorm.Enter()
end

function OnExitCanteenScene()
	Dorm.Leave()

	for slot3, slot4 in pairs(Dorm.timer) do
		slot4.Stop(slot4)
	end

	manager.windowBar:ClearWhereTag()
	Dorm.restaurant:RemoveEvent()
	Dorm.restaurant:Reset()

	Dorm.sceneItemInfo = nil

	CanteenData.GetInstance():Dispose()
	DestroyLua()
end

function ChangeDormScene()
	DestroyLua()
end
