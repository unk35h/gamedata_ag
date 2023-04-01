slot1 = class("BattleChipSchemeItem", import("game.views.chip.scheme.ChipSchemeItem"))

function slot1.SetTeamInfo(slot0, slot1, slot2, slot3, slot4)
	slot0.stageType_ = slot1
	slot0.activityID_ = slot2
	slot0.cont_id_ = slot3
	slot0.team_id_ = slot4
end

function slot1.OnEnabledBtn(slot0)
	BattleFieldAction.SetMimirChipInfo(slot0.stageType_, slot0.activityID_, slot0.schemeData_.chipList, slot0.cont_id_, slot0.team_id_)
	manager.notify:Invoke(ENABLED_SCHEME)
end

return slot1
