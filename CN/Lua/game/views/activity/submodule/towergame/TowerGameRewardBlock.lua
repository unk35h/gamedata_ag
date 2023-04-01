slot0 = class("TowerGameRewardBlock", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.listgo_, TowerGameRewardItem)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:RefreshItem(slot1, slot0.levelid_)
end

function slot0.Refresh(slot0, slot1)
	slot0.levelid_ = slot1
	slot0.title_.text = BattleTowerGameCfg[TowerGameCfg[slot0.levelid_].stage_id].name

	slot0.list_:StartScroll(#ActivityPointRewardCfg.get_id_list_by_activity_id[slot0.levelid_])
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end
end

return slot0
