slot0 = class("TeachStageHeroItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.indexcontroller_ = ControllerUtil.GetController(slot0.transform_, "index")
	slot0.selectcontroller_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if HeroData:GetHeroData(uv0.heroID_).unlock ~= 1 then
			ShowTips("ERROR_HERO_NOT_UNLOCK")

			return
		end

		uv0.selectCallBack_(uv0.index_)
		BattleTeachData:SetCacheTeachHeroID(uv0.heroID_)
		uv0:Go("teachSectionInfo", {
			section = HeroCfg[uv0.heroID_].study_stage[1],
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING
		})
	end)
end

function slot0.RefreshSelect(slot0, slot1)
	slot0.selectcontroller_:SetSelectedState(slot1 == slot0.index_ and "true" or "false")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.selectCallBack_ = nil
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("teachSectionInfo")
end

function slot0.SetHeroID(slot0, slot1)
	if slot0.heroID_ ~= slot1 then
		slot0.heroID_ = slot1
		slot0.icon_.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[slot1].picture_id)
	end

	SetActive(slot0.lockGo_, HeroData:GetHeroData(slot1).unlock ~= 1)
	SetActive(slot0.greyMask_, slot2.unlock ~= 1)

	slot0.nameText_.text = HeroCfg[slot1].name

	SetActive(slot0.clearGo_, BattleTeachData:GetHeroTeachInfo(slot0.heroID_, HeroCfg[slot0.heroID_].study_stage[1]) > 0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1

	slot0.indexcontroller_:SetSelectedState(slot1 % 3)

	if not slot3 then
		slot0.selectcontroller_:SetSelectedState(slot2 == slot0.index_ and "true" or "false")
	end
end

function slot0.SetSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

return slot0
