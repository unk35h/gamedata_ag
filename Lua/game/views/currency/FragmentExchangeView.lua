slot0 = class("FragmentExchangeView", ReduxView)
slot1 = import("game.tools.HeroTools")

function slot0.UIName(slot0)
	return "UI/PopUp/NewFragmentExchangeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot4 = slot0.listGo_
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot4, CommonItem)
	slot0.itemGo_ = {}
	slot0.itemName_ = {}
	slot0.commonItems_ = {}
	slot0.itemAddNum_ = {}

	for slot4 = 1, 3 do
		slot0.itemGo_[slot4] = slot0:FindGo("Canvas/panel/message/itemS/item" .. slot4)
		slot0.itemName_[slot4] = slot0[string.format("itemName%d", slot4)]
		slot0.commonItems_[slot4] = CommonItem.New(slot0[string.format("commonItem%d", slot4)])
		slot0.itemAddNum_[slot4] = slot0[string.format("num%d", slot4)]
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.btnOK_, nil, function ()
		if #uv0.itemList_ == 0 then
			uv0:Back()
		else
			ShopAction.ResolveFragment()
		end
	end)
	slot0:AddBtnListener(slot0.btnCancel_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnResolveFragment(slot0, slot1)
	if #slot0.itemList_ == 0 then
		return
	end

	if slot1.result == 0 then
		for slot5 = 1, #slot0.pieceList_ do
			HeroAction.HeroPieceModify(ItemCfg[slot0.pieceList_[slot5].id].hero_id, slot0.pieceList_[slot5].number * -1)
		end

		for slot5 = 1, #slot0.itemList_ do
			MaterialAction.MaterialModify(slot0.itemList_[slot5].id, slot0.itemList_[slot5].num)
		end

		ShowTips("EXCHANGE_SUCCESS")
		slot0:Back()
	else
		ShowTips(slot1.result)

		return
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.pieceList_[slot1])
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.Render(slot0)
end

function slot0.RefreshPiece(slot0)
	slot0.pieceList_ = uv0.GetCanExchangeHero()

	slot0.scrollHelper:StartScroll(#slot0.pieceList_)
end

function slot0.RefreshGetItemNum(slot0)
	if not slot0.pieceList_ then
		return
	end

	slot0.itemExchangeNum_ = {}

	for slot4 = 1, #slot0.pieceList_ do
		slot8 = GameSetting.fragment_break_num.value[ItemCfg[slot0.pieceList_[slot4].id].rare - 2]
		slot0.itemExchangeNum_[slot8[1]] = (slot0.itemExchangeNum_[slot8[1]] or 0) + slot5.number * slot8[2]
	end

	slot0.itemList_ = {}

	for slot4, slot5 in pairs(slot0.itemExchangeNum_) do
		if slot5 > 0 then
			table.insert(slot0.itemList_, {
				id = slot4,
				num = slot5
			})
		end
	end

	if #slot0.itemList_ == 0 then
		SetActive(slot0.null_, true)
		SetActive(slot0.message_, false)
		SetActive(slot0.textbg_, false)
	else
		SetActive(slot0.null_, false)
		SetActive(slot0.message_, true)

		slot4 = true

		SetActive(slot0.textbg_, slot4)

		for slot4 = 1, 3 do
			if slot0.itemList_[slot4] then
				slot5 = slot0.itemList_[slot4]

				SetActive(slot0.itemGo_[slot4], true)
				slot0.commonItems_[slot4]:RefreshData({
					id = slot5.id
				})
				slot0.commonItems_[slot4]:SetBottomText("")

				slot0.itemName_[slot4].text = ItemCfg[slot5.id].name
				slot0.itemAddNum_[slot4].text = "+" .. slot5.num
			else
				SetActive(slot0.itemGo_[slot4], false)
			end
		end
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0:RefreshPiece()
	slot0:RefreshGetItemNum()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper:Dispose()

	if slot0.commonItems_ then
		for slot4, slot5 in ipairs(slot0.commonItems_) do
			slot5:Dispose()
		end

		slot0.commonItems_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
