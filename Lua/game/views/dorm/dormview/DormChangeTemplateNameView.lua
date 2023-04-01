slot0 = class("DormChangeTemplateNameView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/DormPopupChangeNameUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:GetOrAddComponent(slot0.nameinput_.gameObject, typeof(InputFieldHelper))
	dealEnter(slot0.nameinput_.gameObject)
end

function slot0._onValidateInput(slot0, slot1, slot2)
	if #slot0 >= 24 then
		return 0
	end

	return slot2
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelbtnBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		slot0 = DormitoryData:GetDormTemplateInfo(uv0.templateID).name

		if uv0.nameinput_.text == "" then
			ShowTips(GetTips("DORM_MOULD_NAME_NULL"))

			return
		end

		if slot0 == slot1 then
			ShowTips(GetTips("DORM_MOULD_NAME_SAME"))

			return
		end

		slot2, slot3 = textLimit(slot1, GameDisplayCfg.dorm_mould_name_max.value[1])
		uv0.nameinput_.text = slot2

		if not nameRule(slot2) then
			ShowTips("ERROR_USER_NAME_VER_WORD")

			return
		end

		if not slot3 then
			return
		end

		WordVerifyBySDK(slot1, function (slot0)
			if not slot0 then
				ShowTips("ERROR_USER_NAME_VER_WORD")
			else
				DormAction:ReviseFurTemplateName(uv0.templateID, uv1)
			end
		end, JUDGE_MESSAGE_TYPE.DORM_TEMPLATE)
	end)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(DOMR_RENAME_TEMPLATE_SUCCESS, function ()
		ShowTips(GetTips("DORM_MOULD_NAME_CHANGE"))
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.nameinput_.text = ""
	slot0.templateID = slot0.params_.template_ID
	slot0.placeholderText_.text = GetTips("DORM_MOULD_NAME_SET_TIPS")

	slot0:RegisterEvent()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.nameinput_.onValueChanged:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
