slot0 = class("DormFurTemplateItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.canUseController = ControllerUtil.GetController(slot0.transform_, "btnuse")
	slot0.preViewController = ControllerUtil.GetController(slot0.transform_, "ues")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.previewBtn_, nil, function ()
		if uv0.previewCallBack then
			uv0.previewCallBack(uv0.templateID, uv0.pos)
		end
	end)
	slot0:AddBtnListenerScale(slot0.useBtn_, nil, function ()
		if uv0.useTemplateCallBack then
			uv0.useTemplateCallBack(uv0.templateID, uv0.pos)
		end
	end)
	slot0:AddBtnListenerScale(slot0.btn_editnameBtn_, nil, function ()
		if uv0.ReviseCallBack then
			uv0.ReviseCallBack(uv0.templateID, uv0.pos)
		end
	end)
	slot0:AddBtnListenerScale(slot0.saveBtn_, nil, function ()
		if uv0.SaveTemplate then
			uv0.SaveTemplate(uv0.templateID, uv0.pos)
		end
	end)
	slot0:AddBtnListenerScale(slot0.deleteBtn_, nil, function ()
		if uv0.DelTemplate then
			uv0.DelTemplate(uv0.templateID, uv0.pos)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.templateID = slot1
	slot0.pos = slot2
	slot0.canPreView = slot3
	slot0.indexText_.text = slot2

	if slot1 < 0 then
		slot0.nameText_.text = string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), tostring(slot2))
		slot0.furNumText_.text = 0

		slot0.preViewController:SetSelectedState("unedited")

		return
	end

	slot0.canUseController:SetSelectedState("on")
	slot0.preViewController:SetSelectedState("normal")

	slot4 = DormitoryData:GetDormTemplateInfo(slot1)
	slot0.nameText_.text = slot4.name
	slot0.furNumText_.text = slot4:GetDormTemplateFurNumInfo()

	if not slot3 then
		slot0.canUseController:SetSelectedState("off")
	end
end

function slot0.RegisterUseTemplateCallBack(slot0, slot1)
	if slot1 and slot0.canPreView ~= false then
		slot0.useTemplateCallBack = slot1
	end
end

function slot0.RegisterPreviewCallBack(slot0, slot1)
	if slot1 and slot0.canPreView ~= false then
		slot0.previewCallBack = slot1
	end
end

function slot0.DelTemplateCallBack(slot0, slot1)
	if slot1 then
		slot0.DelTemplate = slot1
	end
end

function slot0.SaveTemplateCallBack(slot0, slot1)
	if slot1 then
		slot0.SaveTemplate = slot1
	end
end

function slot0.ReviseNameCallBack(slot0, slot1)
	if slot1 then
		slot0.ReviseCallBack = slot1
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
