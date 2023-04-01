slot0 = class("PolyhedronBattleTipItem", ReduxView)

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
end

function slot0.SetData(slot0, slot1)
	slot0.tipsinfo_ = slot1

	if slot0.tipsinfo_.attribute_id == PolyhedronAttributeIdCfg.GAME_POLYHEDRON_ATTRIBUTE_BOSS_EVENT_AFTER_EVENT_ADD_REBORN_TIMES.id then
		slot0.m_tip.text = string.format(GetTips("POLYHEDRON_RESURRECTION_TIMES"), slot0.tipsinfo_.delta or 1)
	end

	if slot0.tipsinfo_.attribute_id == PolyhedronAttributeIdCfg.GAME_POLYHEDRON_ATTRIBUTE_ARTIFACT_LEVEL_BONUS_COLD_DOWN.id or slot0.tipsinfo_.attribute_id == PolyhedronAttributeIdCfg.GAME_POLYHEDRON_ATTRIBUTE_BOSS_EVENT_AFTER_EVENT_ARTIFACT_STRENGTH_RATE.id then
		slot0.m_tip.text = string.format(GetTips("POLYHEDRON_TREASURE_LEVEL"), AffixTypeCfg[slot1.target_id].name, slot0.tipsinfo_.delta or 1)
	end

	if slot0.tipsinfo_.attribute_id == PolyhedronAttributeIdCfg.GAME_POLYHEDRON_ATTRIBUTE_HERO_ATTRIBUTE_BONUS_COLD_DOWN.id then
		slot0.m_tip.text = PolyhedronEffectCfg[slot1.target_id].desc
	end
end

function slot0.SetDisposeHandler(slot0, slot1)
	slot0.disposeHandler_ = slot1
end

function slot0.SetIsShow(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	slot0.isShow_ = slot1

	if slot1 then
		slot0.transform_:SetAsLastSibling()
		slot0.m_animator:Play("ani")
		slot0:StartTimer()
	end
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:StopTimer()
			uv0:SetIsShow(false)
			uv0.disposeHandler_(uv0.tipsinfo_)
		end, 3, 1)
	end

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.GetIsShow(slot0)
	return slot0.isShow_
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
