slot0 = class("EquipRecItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.starController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "star")
end

function slot0.SetEquipId(slot0, slot1, slot2, slot3, slot4)
	slot0.index_ = slot1
	slot0.heroId_ = slot2
	slot0.equipId_ = slot3
	slot0.equipStruct_ = EquipStruct.New(0, slot3)
	slot0.isHave_ = slot4

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.equipStruct_.star > 0 then
		slot0.starController_:SetSelectedState(tostring(slot0.equipStruct_.star))
	end

	slot0.icon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.EquipIcon.path .. ItemCfg[slot0.equipId_].icon)

	SetActive(slot0.btnGet_.gameObject, not slot0.isHave_)
	SetActive(slot0.btnEquip_.gameObject, slot0.isHave_)
	SetActive(slot0.hadGo_, false)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btnGet_, nil, function ()
		ShowPopItemSource(uv0.equipId_)
	end)
	slot0:AddBtnListener(slot0.btnEquip_, nil, function ()
		uv0:Go("/heroEquipBag", {
			needRefresh = true,
			isClearPos = true,
			isOpenInfo = false,
			heroId = uv0.heroId_,
			suitPos = uv0.index_,
			suit = EquipCfg[uv0.equipId_].suit
		})
	end)
	slot0:AddBtnListener(nil, , function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			uv0.equipId_
		})
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
