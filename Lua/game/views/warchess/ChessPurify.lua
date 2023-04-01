slot0 = class("ChessPurify", ReduxView)

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessPurifyUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.itemList_ = {}
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, ChessPurifyItem)
	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_tickBtn_, nil, function ()
		if uv0.selectItem_ == 0 then
			ShowTips("未选中负面效果")
		else
			slot0 = manager.ChessManager:GetExecutingChess()

			WarChessAction.PurifyDeBuff({
				x = slot0.x,
				z = slot0.z
			}, uv0.itemList_[uv0.selectItem_])
		end
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
		manager.ChessManager:EventsEnd()
	end)
end

function slot0.OnPurifyDeBuff(slot0, slot1, slot2)
	if slot2.param ~= 0 then
		if isSuccess(slot1.result) then
			WarChessData:ModifyArtifactData(slot2.param, -1)
			slot0:Back()
			manager.ChessManager:DoNextEvent()
			ShowTips("PURIFY_SUCCESS")
		else
			slot0:Back()
			manager.ChessManager:EventsEnd()
			ShowTips(slot1.result)
		end
	end
end

function slot0.RefreshUI(slot0)
	slot0.selectItem_ = 0

	slot0:UpdateData()
	slot0.scrollHelper_:StartScroll(#slot0.itemList_)

	if #slot0.itemList_ == 0 then
		slot0.controller_:SetSelectedState("1")
	else
		slot0.controller_:SetSelectedState("0")
	end
end

function slot0.UpdateData(slot0)
	slot0.itemList_ = {}

	for slot5, slot6 in pairs(WarChessData:GetArtifactData()) do
		if WarchessItemCfg[slot5].identify_buff == 1 then
			table.insert(slot0.itemList_, slot5)
		end
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot1, {
		id = slot0.itemList_[slot1]
	})
	slot2:SetSelectedState(slot1 == slot0.selectItem_)
	slot2:RegisterListener(function (slot0)
		if slot0 ~= uv0.selectItem_ then
			uv0.selectItem_ = slot0

			uv0.scrollHelper_:Refresh()

			uv0.btn_tickBtn_.interactable = true

			SetActive(uv0.itemiconGo_, true)

			uv0.itemiconImg_.sprite = getSprite("Atlas/BattleFlag", WarchessItemCfg[uv0.itemList_[slot0]].icon)
			uv0.nameText_.text = WarchessItemCfg[uv0.itemList_[slot0]].name
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	SetActive(slot0.itemiconGo_, false)

	slot0.btn_tickBtn_.interactable = false
	slot0.nameText_.text = ""
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
