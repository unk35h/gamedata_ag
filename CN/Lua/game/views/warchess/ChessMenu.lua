slot0 = class("ChessMenu", ReduxView)

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessMenu"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:BindCfgUI(slot0.summercontextTrs_)

	slot0.themeCon_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelbtnBtn_, nil, function ()
		ShowMessageBox({
			content = GetTips("CONFIRM_TO_QUIT_CHESS"),
			OkCallback = function ()
				OnExitChessScene(true)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		OnExitChessScene(false)
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()

		if uv0.callback_ then
			uv0.callback_()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.callback_ = slot0.params_.callback

	if table.indexof(WarchessLevelCfg[manager.ChessManager.ChapterID].extra_gameplay, 3) then
		slot0.themeCon_:SetSelectedState("summer")
		slot0:RefreshSummerUI()
	else
		slot0.themeCon_:SetSelectedState("normal")
		slot0:RefreshUI()
	end
end

function slot0.RefreshUI(slot0)
	slot1 = manager.ChessManager.ChapterID
	slot0.progressText_.text = WarChessData:GetBoxNum(slot1, ChessConst.BOX.SMALL) * WarchessLevelCfg[slot1].sbox_progress + WarChessData:GetBoxNum(slot1, ChessConst.BOX.BIG) * WarchessLevelCfg[slot1].lbox_progress > 100 and 100 or slot4 + slot5
	slot0.box1Text_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", slot2, WarchessLevelCfg[slot1].sbox_num)
	slot0.box2Text_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", slot3, WarchessLevelCfg[slot1].lbox_num)
	slot0.progressimgImg_.fillAmount = (slot4 + slot5) / 100
	slot8 = WarchessLevelCfg[slot1].success_progress / 100 * 2 * math.pi
	slot0.progressmarkerTrs_.localPosition = Vector2(math.sin(slot8), math.cos(slot8)) * slot0.progressimgImg_.transform.rect.width / 2
	slot0.chapternameText_.text = ChapterClientCfg[slot1] and ChapterClientCfg[slot1].name or WarchessLevelCfg[slot1].name_level
end

function slot0.RefreshSummerUI(slot0)
	slot1 = manager.ChessManager.ChapterID
	slot2 = WarChessData:GetBoxNum(slot1, ChessConst.BOX.SMALL)
	slot3 = WarChessData:GetBoxNum(slot1, ChessConst.BOX.BIG)
	slot4 = WarChessData:GetItemData()[ChessConst.BOX.CLUE] or 0
	slot8 = slot4 * 100 / WarchessLevelCfg[slot1].clue_sum
	slot0.progressleftText_.text = slot2 * WarchessLevelCfg[slot1].sbox_progress + slot3 * WarchessLevelCfg[slot1].lbox_progress > 100 and 100 or slot5 + slot6
	slot0.boxupText_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", slot2, WarchessLevelCfg[slot1].sbox_num)
	slot0.boxdownText_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", slot3, WarchessLevelCfg[slot1].lbox_num)
	slot0.progressrightText_.text = string.format("%d", slot8)
	slot0.clueText_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", slot4, WarchessLevelCfg[slot1].clue_sum)
	slot0.progressleftImg_.fillAmount = (slot5 + slot6) / 100
	slot0.progressrightImg_.fillAmount = slot8 / 100
	slot0.chaptername2Text_.text = ChapterClientCfg[slot1] and ChapterClientCfg[slot1].name or WarchessLevelCfg[slot1].name_level
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
