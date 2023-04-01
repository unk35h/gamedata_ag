slot0 = class("PlayerDisplayHeroItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot2

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockedController_ = ControllerUtil.GetController(slot0.transform_, "locked")
	slot0.campController_ = ControllerUtil.GetController(slot0.transform_, "camp")
	slot0.gradeController_ = ControllerUtil.GetController(slot0.transform_, "grade")
	slot0.sizeController_ = ControllerUtil.GetController(slot0.transform_, "size")
	slot0.selectedController_ = ControllerUtil.GetController(slot0.transform_, "selected")
	slot0.hpController_ = ControllerUtil.GetController(slot0.transform_, "hp")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selfBtn_, nil, function ()
		slot0 = ForeignInfoAction

		slot0:TryToCheckForeignHeroInfo(uv0.userID_, uv0.data_.hero_id, 1, function ()
			JumpTools.OpenPageByJump("/newHero", {
				isEnter = true,
				isForeign = true,
				notShowBar = true,
				hid = uv0.data_.hero_id
			}, ViewConst.SYSTEM_ID.PLAYER_INFO)
		end)
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.SetHeroData(slot0, slot1, slot2)
	slot0.userID_ = slot1
	slot0.data_ = slot2

	slot0:UpdataView()
end

function slot0.UpdataView(slot0)
	slot0.headIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", slot0.data_.using_skin == 0 and slot0.data_.hero_id or slot0.data_.using_skin)

	slot0.headIcon_:SetNativeSize()
	slot0.campController_:SetSelectedState(HeroCfg[slot0.data_.hero_id].race)
	slot0.gradeController_:SetSelectedState(HeroStarCfg[slot0.data_.star] ~= nil and slot1.star or 1)
	slot0.lockedController_:SetSelectedState("false")
	slot0.sizeController_:SetSelectedState("short")
	slot0.selectedController_:SetSelectedState("false")
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
