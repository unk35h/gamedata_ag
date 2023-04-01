slot0 = class("MardukSpecialRankContentView", ReduxView)

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

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, MardukSpecialRankItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.data_.rankList[slot1])
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.activityId_ = slot1
	slot0.activityCfg_ = ActivityCfg[slot1]
	slot0.battleId_ = slot2
	slot0.battleCfg_ = BattleQuickTrainingCfg[slot2]
	slot0.data_ = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.uiList_:StartScroll(#slot0.data_.rankList)

	slot0.frame_.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo() and slot2.icon_frame)
	slot0.name_.text = slot2.nick
	slot0.rankNameLabel_.text = slot0.battleCfg_.name
	slot0.icon_.sprite = ItemTools.getItemSprite(slot2 and slot2.portrait)

	if slot0.data_.myRank and slot1.score > 0 then
		slot3 = slot1.score

		if slot1.rank >= 1 and slot4 <= 100 then
			slot0.rank_.text = slot4
			slot0.score_.text = slot3
		else
			slot0.rank_.text = string.format("%.2f", slot4 / (slot0.data_.total or 1) * 100) .. "%"
			slot0.score_.text = slot3
		end
	else
		slot0.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
		slot0.score_.text = GetTips("MATRIX_RANK_NO_INFO")
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
