slot0 = class("SequentialBattleFactoryTeamHero", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.heroIndex_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.stageIndex_ = slot2

	slot0:RefreshHero(SequentialBattleData:GetHeroTeam(slot1, slot2)[slot0.heroIndex_])
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.teamButton_, nil, function ()
		SequentialBattleData:CacheChapterData(uv0.activityID_)
		uv0:Go("/sectionSelectHeroSequentialBattle", {
			section = SequentialBattleChapterCfg[uv0.activityID_].stage_id[uv0.stageIndex_],
			sectionType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
			activityID = uv0.activityID_
		})
	end)
end

function slot0.RefreshHero(slot0, slot1)
	if slot1 and slot1.heroID and slot1.heroID ~= 0 then
		slot0.icon_.sprite = HeroTools.GetHeadSprite(slot1.heroID)

		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

return slot0
