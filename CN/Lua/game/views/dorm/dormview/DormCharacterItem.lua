slot0 = class("DormCharacterItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.characterStateController = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.fatigueController = ControllerUtil.GetController(slot0.transform_, "fatigue")
	slot0.positionController = ControllerUtil.GetController(slot0.transform_, "position")
	slot0.curPisitionController = ControllerUtil.GetController(slot0.transform_, "currentPosition")
end

function slot0.AddUIListener(slot0)
	slot0.onClickCom_ = slot0:FindCom("OnClickDownListener")
	slot1 = slot0.onClickCom_.onValueChanged

	slot1:AddListener(function ()
		uv0.downFunc(uv0.heroID)
	end)
	slot0:AddBtnListenerScale(slot0.recallbtnBtn_, nil, function ()
		if uv0.recallHero then
			uv0.recallHero(uv0.heroID)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.heroID = slot1
	slot0.archiveID = DormData:GetHeroArchiveID(slot1)
	slot0.iconImg_.sprite = HeroTools.GetBackHomeHeadSprite(slot1)
	slot3 = DormData:GetHeroTemplateInfo(slot0.heroID)
	slot0.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	slot4 = slot3:GetFatigue()
	slot0.curText_.text = slot4
	slot0.progressImg_.fillAmount = slot4 / GameSetting.canteen_hero_fatigue_max.value[1]

	if slot3:GetFatigue() < GameDisplayCfg.canteen_fatigue_red_warning.value[1] then
		slot0.fatigueController:SetSelectedState("low")
	else
		slot0.fatigueController:SetSelectedState("suff")
	end

	slot0.state = slot3:GetHeroState()

	if slot0.state == DormEnum.DormHeroState.InCanteenRntrust then
		slot0.positionController:SetSelectedState("busy")
		slot0.curPisitionController:SetSelectedState("canteen")
	elseif slot0.state == DormEnum.DormHeroState.InPublicDorm then
		slot0.positionController:SetSelectedState("busy")
		slot0.curPisitionController:SetSelectedState("lobby")
	elseif slot0.state == DormEnum.DormHeroState.InPrivateDorm then
		slot0.positionController:SetSelectedState("busy")
		slot0.curPisitionController:SetSelectedState("dorm")
	elseif slot0.state == DormEnum.DormHeroState.OutDorm then
		slot0.positionController:SetSelectedState("normal")
		slot0.curPisitionController:SetSelectedState("dorm")
	end

	slot6 = BackHomeCfg[DormData:GetCurrectSceneID()].type

	slot0.characterStateController:SetSelectedState("normal")

	if slot0.archiveID == DormData:GetHeroArchiveID(slot2) then
		if slot6 == DormConst.BACKHOME_TYPE.PublicDorm then
			if DormitoryData:CheckHeroInRoom(slot5, slot0.archiveID) then
				slot0.characterStateController:SetSelectedState("select_recall")
			else
				slot0.characterStateController:SetSelectedState("select")
			end
		elseif slot6 == DormConst.BACKHOME_TYPE.PrivateDorm then
			slot0.characterStateController:SetSelectedState("select")
		end
	end
end

function slot0.RecallHero(slot0, slot1)
	slot0.recallHero = slot1
end

function slot0.OnPointerDown(slot0, slot1)
	slot0.downFunc = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.onClickCom_.onValueChanged:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
