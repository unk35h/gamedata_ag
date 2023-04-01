slot1 = class("ActivityRaceReservesView", import("game.views.stage.bossChallenge.normal.info.ReservesView"))

function slot1.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.reservesTempTeams_[slot1].hero_list

	slot2:RefreshUI(slot0.reservesTempTeams_[slot1], slot0:IsCurTeam(slot3), slot0:IsInList(slot0.reservesTempTeams_[slot1].index, slot3), slot0:IsInTempList(slot0.reservesTempTeams_[slot1].index, slot3, slot0.params_.lastParams))
	slot2:RegistChangeBtn(function (slot0)
		for slot5, slot6 in ipairs(BattleTeamData:GetReservesTeam(slot0)) do
			if slot6 ~= 0 and table.indexof(uv0.lockList_, slot6) then
				ShowTips("FORMATION_PLAN_CHANGE_FAILED")

				return
			end

			if uv0.params_.race and slot6 ~= 0 and HeroCfg[slot6].race ~= uv0.params_.race then
				ShowTips("FORMATION_PLAN_CHANGE_FAILED")

				return
			end
		end

		uv0:Back(1, {
			isReserves = true,
			index = slot0
		})
		ShowTips("FORMATION_PLAN_CHANGED")
	end)
end

return slot1
