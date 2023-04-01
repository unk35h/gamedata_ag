slot0 = class("WeaponServantListItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.clickFunc = nil
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "select")
	slot0.qualityCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "quality")
	slot0.usingController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "using")
	slot0.lockedController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "lock")
	slot0.starController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "star")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.functionBtn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.info_)
		end
	end)
end

function slot0.RefreshData(slot0, slot1)
	slot0.info_ = slot1
	slot2 = slot0.info_.id
	slot0.roleiconImg_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Icon438x238/" .. slot2)
	slot0.lvText_.text = slot0.info_.number
	slot3 = ItemCfg[slot2].rare

	slot0.qualityCon_:SetSelectedState(slot3 - 3)
	slot0.starController_:SetSelectedState(slot3)

	slot0.raceImg_.sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", WeaponServantCfg[slot2].race))
	slot5 = false
	slot6 = 0

	if slot0.info_.equiping and slot0.info_.equiping.heroId > 0 then
		slot5 = true
		slot6 = slot0.info_.equiping.heroId
	end

	slot0:ShowEquiping(slot5, slot6)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.ShowSelect(slot0, slot1)
	if slot1 == 0 then
		slot0.selectCon_:SetSelectedState("off")
	elseif slot1 == 1 then
		slot0.selectCon_:SetSelectedState("on")
	end
end

function slot0.ShowMask(slot0, slot1)
	if slot1 then
		slot0.roleiconImg_.color = Color(0.6037, 0.6037, 0.6037)
	else
		slot0.roleiconImg_.color = Color(1, 1, 1)
	end
end

function slot0.ShowEquiping(slot0, slot1, slot2)
	slot0.usingController_:SetSelectedState(slot1 and "true" or "false")

	if slot1 then
		slot0.whoiconImg_.sprite = HeroTools.GetSmallHeadSprite(slot2)
	end
end

function slot0.SetSelectType(slot0)
end

function slot0.ShowLock(slot0, slot1)
	slot0.lockedController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
