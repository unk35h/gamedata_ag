slot0 = class("DrawToggleItem", ReduxView)

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

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.poolId, uv0.activityId)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.poolId = slot1
	slot3 = DrawData:GetPollUpID(slot0.poolId)

	if DrawData:IsOnePrefabPool(slot1) then
		slot0.bgImg_.sprite = getSpriteWithoutAtlas("Textures/Treasure/" .. 140035 .. SettingData:GetCurrentLanguageKey())
	else
		slot0:RefreshBgImg(slot3)
	end

	slot0.nameText_.text = DrawPoolCfg[slot0.poolId].name
end

function slot0.SetSelect(slot0, slot1)
	if slot0.poolId == slot1 then
		slot0.selectController:SetSelectedIndex(1)
	else
		slot0.selectController:SetSelectedIndex(0)
	end
end

function slot0.RefreshBgImg(slot0, slot1)
	slot2 = slot0.poolId

	if DrawPoolCfg[slot0.poolId].optional_bgId ~= "" and #DrawPoolCfg[slot0.poolId].optional_bgId > 1 then
		slot2 = (not table.indexof(DrawPoolCfg[slot0.poolId].optional_lists, slot1) or DrawPoolCfg[slot0.poolId].optional_bgId[slot3]) and DrawPoolCfg[slot0.poolId].optional_bgId[1]
	end

	slot0.bgImg_.sprite = getSpriteWithoutAtlas("Textures/Treasure/" .. slot2 .. SettingData:GetCurrentLanguageKey())
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
