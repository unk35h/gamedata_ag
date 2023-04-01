slot0 = class("ActivityMatrixMiniHeroView", MatrixMiniHeroView)

function slot0.OnCtor(slot0)
	uv0.super.OnCtor(slot0)

	slot0.ClassList_ = {
		ActivityMatrixHeroAttributePage,
		ActivityMatrixHeroSkillPage,
		ActivityMartixHeroWeaponPage,
		ActivityMatrixHeroEquipPage,
		ActivityMatrixHeroAstrolabePage
	}
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in pairs(slot0.toggles_) do
		slot6 = slot5.onValueChanged

		slot6:AddListener(function (slot0)
			if slot0 then
				uv0:SwitchPage(uv1)

				if uv0.pages_[uv1] then
					uv0.pages_[uv1]:SetMatirxHeroInfo(uv0.matrix_activity_id, uv0.curHeroId_)
				end
			end
		end)
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, slot0.matrix_activity_id)
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	uv0.super.OnEnter(slot0)
end

function slot0.UpdateHeroView(slot0)
	slot0:UpdateAvatarView()

	for slot4, slot5 in pairs(slot0.pages_) do
		slot5:SetMatirxHeroInfo(slot0.matrix_activity_id, slot0.curHeroId_)
	end
end

function slot0.GetHeroData(slot0, slot1)
	return ActivityMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

function slot0.GetHeroSkin(slot0, slot1)
	return ActivityMatrixData:GetHeroSkin(slot0.matrix_activity_id, slot1)
end

return slot0
