slot0 = class("HeroPortraitView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroPreview/PortraitPanel"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scaleImage_ = slot0:FindCom("UIScaleImage", nil, slot0.portriatTrans_)
end

function slot0.OnEnter(slot0)
	manager.windowBar:HideBar()

	slot0.heroID_ = slot0.params_.heroID
	slot0.skinID_ = slot0.params_.skinID
	slot0.scaleImage_.enabled = true
	slot1 = nil
	slot0.portriatImg_.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. ((slot0.skinID_ == nil or SkinCfg[slot0.skinID_].picture_id) and HeroTools.HeroUsingSkinInfo(slot0.heroID_).picture_id))
end

function slot0.OnExit(slot0)
	slot0.scaleImage_:ResetContent()

	slot0.scaleImage_.enabled = false
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBth_, nil, function ()
		uv0:Back()
	end)
	slot0:AddToggleListener(slot0.scaleImage_, function ()
		uv0:Back()
	end)
end

return slot0
