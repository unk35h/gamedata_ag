slot0 = class("SectionSelectHeroBuffView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.buffUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, SectionSelectHeroBuffItem)
end

function slot0.OnEnter(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.stageID_ = slot2
	slot0.enabledBuff_ = SequentialBattleData:GetChapterData(slot1).team[table.keyof(SequentialBattleChapterCfg[slot1].stage_id, slot2)].enabledBuff

	slot0.buffUIList_:StartScroll(#slot0.enabledBuff_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.buffUIList_:Dispose()

	slot0.buffUIList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		JumpTools.OpenPageByJump("sequentialBattleBuffInfo", {
			activityID = uv0.activityID_,
			stageID = uv0.stageID_
		})
	end)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.enabledBuff_[slot1])
end

return slot0
