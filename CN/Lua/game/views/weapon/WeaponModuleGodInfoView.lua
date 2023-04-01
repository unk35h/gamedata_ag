slot0 = class("WeaponModuleGodInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Hero/HeroModuleUI/HeroModuleGodPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.curIndex_, getAstrolabeID(slot0.effectList_[slot1], 0))
	slot2:SetSelectCallBack(slot0.selectStageItemHandler_)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.curIndex_ = 1
	slot0.selectStageItemHandler_ = handler(slot0, slot0.OnSelectStageItem)
	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, WeaponModuleGodItem)
end

function slot0.OnSelectStageItem(slot0, slot1)
	slot0.curIndex_ = slot1

	slot0.list_:Refresh()
	slot0:RefreshDes()
end

function slot0.RefreshDes(slot0)
	slot1 = getAstrolabeID(slot0.effectList_[slot0.curIndex_], 0)
	slot2 = HeroAstrolabeCfg[slot1]
	slot0.nameText1_.text = slot2.suit_name .. "·" .. slot2.name
	slot0.nameText2_.text = slot2.suit_name .. "·" .. slot2.name
	slot7 = 1
	slot0.frontDesText_.text = GetCfgDescription(AstrolabeEffectCfg[slot1].desc[1], slot7)

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.frontcontentTrans_)

	slot3 = nil

	for slot7, slot8 in pairs(AstrolabeEffectCfg[slot1].equip_orange_desc) do
		if slot8[1] == 0 and slot8[3] == slot0.effectList_[slot0.curIndex_] then
			slot3 = slot8[2]
		end
	end

	slot0.nextDesText_.text = GetCfgDescription(slot3, 1)

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.nextcontentTrans_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.effectList_ = slot0.params_.effectList
	slot0.heroID_ = slot0.params_.heroID
	slot0.curIndex_ = 1

	if #slot0.effectList_ > 1 then
		SetActive(slot0.listGo_, true)
		slot0.list_:StartScroll(#slot0.effectList_)
	else
		SetActive(slot0.listGo_, false)
	end

	slot0:RefreshDes()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
