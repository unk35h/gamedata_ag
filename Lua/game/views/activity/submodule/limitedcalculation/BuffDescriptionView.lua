slot0 = class("BuffDescriptionView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, BuffDescriptionItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.list_[slot1])
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.id_ = slot1
	slot0.type_ = slot2
	slot0.cfg_ = ActivityLimitCalculationCfg[slot0.id_]

	if slot0.type_ == "buff" then
		slot0.title_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_PLAYER_LEVEL"), slot0.cfg_.player_level)
		slot0.list_ = slot0.cfg_.player_affix
	elseif slot0.type_ == "debuff" then
		slot0.title_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_ENEMY_LEVEL"), slot0.cfg_.enemy_level)
		slot0.list_ = slot0.cfg_.enemy_affix
	end

	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
