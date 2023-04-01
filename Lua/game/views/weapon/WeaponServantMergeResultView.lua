slot0 = class("WeaponServantWakeUpView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Obtain/Weapon/WeaponServantWakeUp_anim"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		if uv0.weaponservantwakeup_animAni_:GetCurrentAnimatorStateInfo(0).normalizedTime <= 0.0505 then
			uv0.weaponservantwakeup_animAni_:Play(slot0.fullPathHash, -1, 0.0505)
			manager.audio:StopEffect()
		elseif uv0.params_.backThrice then
			uv0:Back()
			uv0:Back()
			uv0:Back(1, {
				uid = uv0.uid_
			})
		else
			uv0:Back()
			uv0:Back()
		end
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0.servantID_ = slot0.params_.servantID
	slot0.sleepyID_ = ServantTools.GetSleepyServantByServant(slot0.servantID_)
	slot0.uid_ = slot0.params_.uid
	slot0.name_.text = ItemCfg[slot0.servantID_].name
	slot0.campImg_.sprite = getSprite("Atlas/CampItem", string.format("icon_group_%d_c", WeaponServantCfg[slot0.servantID_].race))
	slot0.sleepyiconImg_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Portrait/" .. slot0.sleepyID_)
	slot0.portrait_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Portrait/" .. slot0.servantID_)

	manager.audio:PlayEffect("ui_system", "key_awakening")
end

function slot0.OnExit(slot0)
end

function slot0.Cacheable(slot0)
	return false
end

return slot0
