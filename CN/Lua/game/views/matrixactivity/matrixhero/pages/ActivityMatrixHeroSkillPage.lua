slot0 = class("ActivityMatrixHeroSkillPage", MatrixHeroSkillPage)

function slot0.SetMatirxHeroInfo(slot0, slot1, slot2)
	slot0.matrix_activity_id = slot1

	uv0.super.SetMatirxHeroInfo(slot0, slot2)
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 6 do
		slot5 = slot0.skillItem_[slot4]

		slot5:RegistCallBack(function (slot0)
			JumpTools.OpenPageByJump("matrixSkillUpgrade", {
				skillId = slot0.id,
				heroId = slot0.heroId,
				standardId = uv0.standardID,
				servantId = slot0.servantId,
				lv = slot0.lv
			})
		end)
	end

	slot0:AddBtnListener(slot0.buttonComboSkill_, nil, function ()
		uv0:Go("activityMatrixOrigin/activityMatrixComboSkillInfo", {
			heroId = uv0.heroInfo_.id
		})
	end)
end

function slot0.GetHeroData(slot0, slot1)
	return ActivityMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

return slot0
