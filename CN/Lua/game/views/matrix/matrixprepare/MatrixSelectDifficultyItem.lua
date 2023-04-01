slot0 = class("MatrixSelectDifficultyItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.m_controller, "state")
	slot0.difficultyController_ = ControllerUtil.GetController(slot0.m_controller, "difficulty")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_clickBtn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc()
		end
	end)
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.stateController_:SetSelectedIndex(slot2 and 1 or 0)
	slot0.difficultyController_:SetSelectedIndex(slot1 - 1)

	if slot1 == 1 then
		slot0.difficultText_.text = GetTips("HARDLEVEL_EASY")
	else
		slot0.difficultText_.text = GetTips("HARDLEVEL_HARD")
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

return slot0
