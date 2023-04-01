slot0 = class("SuitSelectItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.itemBtn_, nil, "OnClick")
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		SetSpriteWithoutAtlasAsync(slot0.iconImg_, SpritePathCfg.EquipIcon.path .. slot1.id)
	end
end

function slot0.TurnToStart(slot0)
	slot0.bgImg_.color = Color.New(1, 1, 1, 1)
	slot0.iconImg_.color = Color.New(1, 1, 1, 1)
end

function slot0.ShowSelect(slot0, slot1)
	SetActive(slot0.selectGo_, slot1)
end

function slot0.ShowCurrentUp(slot0, slot1)
	SetActive(slot0.currentGo_, slot1)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.info_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
