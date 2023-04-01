slot0 = class("WarChessChoose", ReduxView)

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessChoosePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.selectItem_ = 1
	slot0.itemList_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_tickBtn_, nil, function ()
		slot0 = manager.ChessManager:GetExecutingChess()

		WarChessAction.GetTreasure({
			x = slot0.x,
			z = slot0.z
		}, uv0.state[uv0.selectItem_])
		OperationRecorder.Record("chess", "check_select_artifact")
	end)
end

function slot0.OnGetTreasure(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		WarChessData:ModifyArtifactData(slot2.param, 1)
		slot0:Back()
		manager.ChessManager:DoNextEvent()
	else
		manager.ChessManager:EventsEnd()
		ShowTips(slot1.result)
	end
end

function slot0.OnEnter(slot0)
	slot0.state = slot0.params_.state

	SetActive(slot0.btn_tickBtn_.gameObject, false)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.selectItem_ = 1

	for slot4 = 1, 3 do
		if not slot0.itemList_[slot4] then
			slot0.itemList_[slot4] = ChessChooseItem.New(slot0.battleflagitemGo_)
		end

		slot0.itemList_[slot4]:RefreshUI(slot4, slot0.state[slot4])
		slot0.itemList_[slot4]:RegisterListener(function (slot0, slot1)
			SetActive(uv0.btn_tickBtn_.gameObject, true)

			if slot0 then
				uv0.selectItem_ = slot1

				for slot5 = 1, 3 do
					uv0.itemList_[slot5]:SetSelectState(uv0.selectItem_ == slot5)
				end
			end
		end)
		slot0.itemList_[slot4].controller_:SetSelectedState(0)
	end
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:ResetToggle()
	end
end

function slot0.Dispose(slot0)
	for slot4 = 1, 3 do
		slot0.itemList_[slot4]:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
