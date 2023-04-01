slot0 = class("IlluIllustrationDetailPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/IllustratedHandbook/IlluIllustrationSettingPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "type")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		if GameSetting.loading_pic_max.value[1] <= #IllustratedData:GetAllLoadingSet() then
			ShowTips("SET_FAILED")

			return
		end

		IllustratedAction.ChangeLoadingSet(true, uv0.ID_)
		ShowTips("SET_CONFIRMED")
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.removeBtn, nil, function ()
		IllustratedAction.ChangeLoadingSet(false, uv0.ID_)
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.ID_ = slot0.params_.ID
	slot0.cfg_ = CollectPictureCfg[slot0.ID_]

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.img_.sprite = getSpriteWithoutAtlas("Textures/Story/Background/" .. slot0.cfg_.picture)
	slot0.name_.text = slot0.cfg_.name
	slot0.desc_.text = slot0.cfg_.desc

	if IllustratedData:IsInLoadingSet(slot0.ID_) then
		slot0.typeCon_:SetSelectedState("remove")

		slot0.title_.text = string.format(GetTips("REMOVE_CONFIRMED"), slot0.cfg_.name, #IllustratedData:GetAllLoadingSet() .. "/" .. GameSetting.loading_pic_max.value[1])
	else
		slot0.typeCon_:SetSelectedState("add")

		slot0.title_.text = string.format(GetTips("SET_CONFIRMED_2"), slot0.cfg_.name, #IllustratedData:GetAllLoadingSet() .. "/" .. GameSetting.loading_pic_max.value[1])
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
