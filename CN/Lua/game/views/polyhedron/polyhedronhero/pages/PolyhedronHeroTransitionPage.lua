slot0 = class("PolyhedronHeroTransitionPage", NewHeroTransitionPage)

function slot0.AddUIListeners(slot0)
	for slot4, slot5 in ipairs(slot0.item_) do
		slot5:RegistClickFunc(function (slot0)
			slot4 = uv1
			slot5 = slot0

			uv0:OpenInfoView(slot4, slot5)

			for slot4, slot5 in ipairs(uv0.item_) do
				slot5:SetSelected(uv1)
			end
		end)
	end

	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:CloseInfoView()
	end)
	slot0:AddBtnListener(slot0.changeBtn_, nil, function ()
		if uv0.isChangeable_ then
			JumpTools.OpenPageByJump("/transitionSkill", {
				index = uv0.defaultIndex_,
				heroID = uv0.heroID_
			})
		else
			ShowTips("NO_EXCLUSIVE_CORE")
		end
	end)
	SetActive(slot0.m_cultureBtn.gameObject, false)
end

function slot0.OpenInfoView(slot0, slot1, slot2)
	slot3 = {}

	if slot0.useList_[slot1] then
		slot3 = slot0.useList_[slot1]
	end

	SetActive(slot0.infoViewGo_, true)
	slot0.infoView_:SetData(slot1, slot3, slot2, slot0.heroID_, slot0.isAdd_, {})

	if slot1 <= 3 then
		slot0.infoViewCon_:SetSelectedState("right")
	else
		slot0.infoViewCon_:SetSelectedState("left")
	end
end

return slot0
