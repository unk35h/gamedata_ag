slot0 = class("PopItemSourceView", import("game.views.pop.PopItemView"))

function slot0.Init(slot0)
	uv0.super.Init(slot0)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.itemList_ = {}

	slot0:RefreshItem()
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil
end

function slot0.CustomInitUI(slot0)
	SetActive(slot0.mergeBtn_.gameObject, false)
	SetActive(slot0.operatePanel_, false)
	SetActive(slot0.sourceDesGo_, false)
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.sourceBtn_, nil, function ()
		SetActive(uv0.sourcePanel_, true)
		SetActive(uv0.infoPanel_, false)
		OperationRecorder.Record(uv0.lastRecord_, "popSourceItem_sourceBtn")
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		SetActive(uv0.sourcePanel_, false)
		SetActive(uv0.infoPanel_, true)
	end)
end

function slot0.RefreshItem(slot0)
	slot1 = ItemCfg[slot0.itemInfo_[1]].source
	slot3 = {}

	if ItemCfg[slot0.itemInfo_[1]].type == ItemConst.ITEM_TYPE.HERO_PIECE then
		for slot7, slot8 in ipairs(slot1) do
			if slot8[1] == ViewConst.SYSTEM_ID.DRAW then
				table.insert(slot3, slot8)
			elseif slot8[1] == ViewConst.SYSTEM_ID.LIMIT_DRAW then
				if HeroTools:CanBeDraw(slot8[2]) then
					table.insert(slot3, slot8)
				end
			elseif slot8[1] == ViewConst.SYSTEM_ID.NEWS_SHOP or slot8[1] == ViewConst.SYSTEM_ID.DREAM_SHOP then
				if HeroTools.GetHeroIsUnlock(slot2.id - 10000) then
					table.insert(slot3, slot8)
				end
			else
				table.insert(slot3, slot8)
			end
		end
	else
		slot3 = slot1
	end

	if #slot3 > 0 then
		SetActive(slot0.sourceBtn_.gameObject, true)

		slot7 = true

		SetActive(slot0.infoBtn_.gameObject, slot7)

		for slot7, slot8 in ipairs(slot3) do
			if slot8[1] == 0 then
				slot0.itemList_[slot7] = PopSourceDisplayItemView.New(slot0.displayItem_, slot0.sourceParent_, slot8)
			elseif SystemLinkCfg[slot8[1]].text_invalid ~= 0 then
				slot0.itemList_[slot7] = PopSourceInvalidItemView.New(slot0.lockItem_, slot0.sourceParent_, slot8)
			else
				slot0.itemList_[slot7] = PopSourceUnlockItemView.New(slot0.unlockItem_, slot0.sourceParent_, slot8)

				slot0.itemList_[slot7]:SetJumpCallback(handler(slot0, slot0.OnJumpCallback))
			end
		end
	else
		SetActive(slot0.sourceBtn_.gameObject, false)
		SetActive(slot0.infoBtn_.gameObject, false)
	end
end

function slot0.OnJumpCallback(slot0)
	OperationRecorder.Record(slot0.lastRecord_, "jump")
end

return slot0
