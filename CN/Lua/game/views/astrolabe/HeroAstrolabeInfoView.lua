slot0 = class("HeroAstrolabeInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot4 = "State"
	slot0.styleController_ = ControllerUtil.GetController(slot0.transform_, slot4)
	slot0.itemSGo_ = {}
	slot0.itemS_ = {}

	for slot4 = 1, 3 do
		slot0.itemSGo_[slot4] = {}
		slot0.itemS_[slot4] = {}

		for slot8 = 1, 3 do
			slot0.itemSGo_[slot4][slot8] = slot0[string.format("item%d_%dGo_", slot4, slot8)]
			slot0.itemS_[slot4][slot8] = AstrolabeItem.New(slot0, slot0.itemSGo_[slot4][slot8])
		end
	end

	slot0.lineSGo_ = {}
	slot0.lineBgImg_ = {}

	for slot4 = 1, 3 do
		slot0.lineSGo_[slot4] = {}
		slot0.lineBgImg_[slot4] = {}

		for slot8 = 1, 3 do
			slot0.lineSGo_[slot4][slot8] = slot0[string.format("line%d_%dGo_", slot4, slot8)]
			slot0.lineBgImg_[slot4][slot8] = slot0.lineSGo_[slot4][slot8].transform.parent:GetComponent(typeof(Image))
		end
	end
end

function slot0.AddUIListener(slot0)
end

function slot0.ChangeStyle(slot0, slot1)
	slot0.styleController_:SetSelectedState(slot1)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.heroInfo_ = slot1
	slot0.extra_ = slot2
	slot6 = slot0.extra_
	slot0.astrolabeInfo_ = AstrolabeTools.GetHeroAstrolabeS(slot0.heroInfo_, slot6)

	for slot6, slot7 in ipairs(slot0.itemS_) do
		slot8 = slot0.astrolabeInfo_[slot6]

		for slot12, slot13 in ipairs(slot7) do
			slot14 = slot8.astrolabe[slot12]

			slot13:RefreshUI(slot14)

			slot0.lineBgImg_[slot6][slot12].enabled = not slot14.isEquiped

			SetActive(slot0.lineSGo_[slot6][slot12], slot14.isEquiped)
		end
	end
end

function slot0.RefreshRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0.itemS_) do
		for slot9, slot10 in ipairs(slot5) do
			slot11 = slot10:GetItemInfo()

			if slot0.extra_ and (slot0.extra_.isPreview or slot0.extra_.isPolyhedron) then
				slot10:SetRedPoint(false)
			else
				slot10:SetRedPoint(AstrolabeTools.GetIsCanUnlock(slot11.id, slot11.heroId))
			end
		end
	end
end

function slot0.OnEnter(slot0, slot1)
	slot0.isForeign_ = slot1
end

function slot0.OnExit(slot0)
end

function slot0.GetFirstSelectItem(slot0)
	if slot0.heroInfo_ and slot0.astrolabeInfo_ and slot0.heroInfo_.using_astrolabe[#slot0.heroInfo_.using_astrolabe] then
		for slot5, slot6 in ipairs(slot0.itemS_) do
			for slot10, slot11 in ipairs(slot6) do
				if slot11:GetItemInfo().id == slot1 then
					return slot11
				end
			end
		end
	end

	return slot0:GetItem(1, 1)
end

function slot0.GetItem(slot0, slot1, slot2)
	return slot0.itemS_[slot1][slot2]
end

function slot0.RegistCallBack(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.itemS_) do
		for slot10, slot11 in ipairs(slot6) do
			slot11:RegistCallBack(slot1)
		end
	end
end

function slot0.Dispose(slot0)
	if slot0.itemS_ then
		for slot4, slot5 in ipairs(slot0.itemS_) do
			for slot9, slot10 in ipairs(slot5) do
				slot10:Dispose()
			end
		end
	end

	slot0.itemSGo_ = nil
	slot0.itemS_ = nil
	slot0.astrolabeInfo_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
