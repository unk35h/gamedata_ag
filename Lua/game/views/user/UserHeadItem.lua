slot0 = class("UserHeadItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectCon_ = ControllerUtil.GetController(slot0.iconGo_.transform, "select")
	slot0.lockCon_ = ControllerUtil.GetController(slot0.iconGo_.transform, "lock")
	slot0.useCon_ = ControllerUtil.GetController(slot0.iconGo_.transform, "use")
	slot0.typeCon_ = ControllerUtil.GetController(slot0.iconGo_.transform, "type")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.iconBtn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_()
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot0.itemID_ = slot1
	slot3, slot4 = nil

	if slot2 == "portrait" then
		slot3 = PlayerData:GetPortrait(slot0.itemID_).unlock == 0

		slot0.typeCon_:SetSelectedState("portrait")

		slot0.icon_.sprite = ItemTools.getItemSprite(slot1)

		slot0.icon_:SetNativeSize()
	elseif slot2 == "frame" then
		slot3 = PlayerData:GetFrame(slot0.itemID_).unlock == 0

		slot0.typeCon_:SetSelectedState("frame")

		slot0.frame_.sprite = ItemTools.getItemSprite(slot1)
	end

	slot0.lockCon_:SetSelectedState(slot3 and "lock" or "default")
end

function slot0.SetUsed(slot0, slot1)
	slot0.useCon_:SetSelectedState(slot1 and "used" or "default")
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectCon_:SetSelectedState(slot1 and "select" or "default")
end

function slot0.SetTimer(slot0)
	SetActive(slot0.timeCntGo_, ItemCfg[slot0.itemID_].type == ItemConst.ITEM_TYPE.FRAME and PlayerData:GetFrame(slot0.itemID_).lasted_time > 0)
end

function slot0.SetLastTime(slot0, slot1)
	slot0.timeCntText_.text = slot1
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.clickFunc_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
