slot0 = class("AbyssTeamCheckItemView", ReduxView)

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

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, AbyssTeamCheckHeroItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.userId_, slot0.heroInfoList_[slot1])
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.index_ = slot1
	slot0.layerId_ = slot2
	slot0.userId_ = slot3
	slot0.stageRankInfo_ = slot4
	slot0.heroInfoList_ = slot4.heroList

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameText_.text = BattleAbyssCfg[AbyssCfg[slot0.layerId_].stage_list[slot0.index_][2]].name or "关卡" .. slot0.index_

	slot0.uiList_:StartScroll(#slot0.heroInfoList_)
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
