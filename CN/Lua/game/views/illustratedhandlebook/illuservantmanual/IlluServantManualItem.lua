slot0 = class("IlluServantManualItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
	slot0.raceController_ = ControllerUtil.GetController(slot0.transform_, "race")
	slot0.rareController_ = ControllerUtil.GetController(slot0.transform_, "rare")
end

function slot0.RefreshUI(slot0, slot1)
	slot0.info_ = slot1
	slot0.ID_ = slot1.id
	slot0.nameText_.text = slot1.name
	slot0.iconImg_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/IlluServant/" .. slot0.ID_)

	if slot1.isUnlock then
		slot0.controller_:SetSelectedState("unlock")

		slot0.view_ = IllustratedData:GetIsView(slot0.ID_, 3)

		manager.redPoint:SetRedPointIndependent(slot0.transform_, slot0.view_ == 0)
	else
		slot0.controller_:SetSelectedState("lock")
		manager.redPoint:SetRedPointIndependent(slot0.transform_, false)
	end

	slot0.raceController_:SetSelectedState(WeaponServantCfg[slot0.ID_].race)
	slot0.rareController_:SetSelectedState(WeaponServantCfg[slot0.ID_].starlevel)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		if uv0.info_.isUnlock and uv0.view_ == 0 then
			IllustratedAction.ViewIllustration(uv0.ID_, CollectConst.SERVANT)
		end

		uv0:Go("/showServantView", {
			stage = 5,
			state = "onlydetail",
			id = uv0.ID_
		})
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
