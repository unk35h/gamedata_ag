slot0 = class("ActivityMatrixComboSkillInfoView", MatrixComboSkillInfoView)

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixMiniHero")
	end)
end

return slot0
