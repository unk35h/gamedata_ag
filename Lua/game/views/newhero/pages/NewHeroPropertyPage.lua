slot0 = class("NewHeroPropertyPage", NewHeroPageBase)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isUnlockController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isUnlock")
	slot0.levelStateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "levelState")
	slot0.playableDirector_ = slot0.playableDirectorGo_:GetComponent("PlayableDirector")
	slot0.heroInfoView_ = NewHeroInfoView.New(slot0, slot0.infoViewGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.archiveBtn_, nil, function ()
		uv0:Go("/heroArchive", {
			heroID = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.surpassBtn_, nil, function ()
		JumpTools.OpenPageByJump("/heroSurpass", {
			heroId = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.maxLevelSurpassBtn_, nil, function ()
		JumpTools.OpenPageByJump("/heroSurpass", {
			heroId = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.storybtnBtn_, nil, function ()
		uv0:Go("/heroStory", {
			heroID = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.teachBtn_, nil, function ()
		if _G.ChannelLoginInfo and _G.ChannelLoginInfo.channelToken then
			slot0 = {
				userId = PlayerData:GetPlayerInfo().userID,
				signUserId = PlayerData:GetPlayerInfo().signUserId,
				gameAppId = _G.ChannelLoginInfo.channelAppId,
				token = _G.ChannelLoginInfo.channelToken
			}

			if HeroCfg[uv0.heroInfo_.id] ~= nil then
				slot0.heroName = string.format("%s·%s", slot1.name, slot1.suffix)
			end

			OperationAction.OpenOperationUrl("FORUM_URL_HERO", slot0)
		end
	end)
	slot0:AddBtnListener(slot0.hideBtn_, nil, function ()
		ShowTips("TIP_HIDE")
	end)
	slot0:AddBtnListener(slot0.skinBtn_, nil, function ()
		uv0:Go("/heroSkin", {
			heroID = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.upgradeBtn_, nil, function ()
		JumpTools.OpenPageByJump("newAddExp", {
			heroId = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.breakBtn_, nil, function ()
		JumpTools.OpenPageByJump("newBreak", {
			heroInfo = uv0.heroInfo_
		})
	end)
	slot0:AddBtnListener(slot0.previewbtnBtn_, nil, function ()
		JumpTools.OpenPageByJump("newBreakPreview", {
			heroInfo = uv0.heroInfo_
		})
	end)
	slot0:AddBtnListener(slot0.buttonHeroDisplay_, nil, function ()
		JumpTools.OpenPageByJump("/heroDisplay", {
			heroID = uv0.heroInfo_.id
		})
	end)
end

function slot0.SetHeroInfo(slot0, slot1)
	slot2 = slot0.heroInfo_

	if slot0.extra_ then
		if slot0.isForeign_ then
			slot0.heroInfo_ = ForeignInfoData:GetHeroInfo(slot1.id)
		elseif slot0.isTemp_ then
			slot0.heroInfo_ = TempHeroData:GetHeroDataByHeroID(slot0.extra_.tempHeroList, slot1.id)
		end
	else
		slot0.heroInfo_ = HeroData:GetHeroData(slot1.id)
	end

	slot0.unlockDirty_ = true

	if slot2 == nil then
		slot0.unlockDirty_ = false
	elseif slot2.unlock == 1 and slot1.unlock == 1 then
		slot0.unlockDirty_ = false
	end

	slot0:UpdateView()

	if slot0.unlockDirty_ then
		slot0.playableDirector_.time = 0

		slot0.playableDirector_:Play()
	end
end

function slot0.UpdateView(slot0)
	slot0.heroInfoView_:SetHeroInfo(slot0.heroInfo_)

	if slot0.heroInfo_.unlock == 0 or slot0.extra_ then
		slot0.isUnlockController_:SetSelectedState("false")
		SetActive(slot0.teachBtn_.gameObject, false)
	else
		if HeroConst.HERO_LV_MAX <= slot0.heroInfo_.level then
			slot0.levelStateController_:SetSelectedState("max_level")
		elseif HeroTools.GetHeroCurrentMaxLevel(slot0.heroInfo_) <= slot0.heroInfo_.level then
			slot0.levelStateController_:SetSelectedState("break")
		elseif HeroConst.HERO_LV_MAX <= HeroTools.GetHeroCurrentMaxLevel(slot0.heroInfo_) then
			slot0.levelStateController_:SetSelectedState("add_exp_noPreview")
		else
			slot0.levelStateController_:SetSelectedState("add_exp")
		end

		if #HeroRecordCfg[HeroTools.GetHeroOntologyID(slot0.heroInfo_.id)].plot_id > 1 then
			slot0.isUnlockController_:SetSelectedState("true")
		else
			slot0.isUnlockController_:SetSelectedState("no_plot")
		end
	end

	SetActive(slot0.teachBtn_.gameObject, table.keyof(OperationData:GetOperationOpenList(), OperationConst.FORUM) ~= nil)

	slot0.archiveID_ = HeroTools.GetHeroOntologyID(slot0.heroInfo_.id)

	if #HeroRecordCfg[slot0.archiveID_].plot_id > 0 then
		SetActive(slot0.storybtnGo_, true)
	else
		SetActive(slot0.storybtnGo_, false)
	end

	slot3 = HeroTools.GetHeroOntologyID(slot0.heroInfo_.id)

	manager.redPoint:bindUIandKey(slot0.archivebtnTrs_, RedPointConst.HERO_ARCHIVE_ID .. slot3, {
		x = 36,
		y = 36
	})
	manager.redPoint:bindUIandKey(slot0.storybtnBtn_.transform, RedPointConst.HERO_STORY_ID .. slot3)
	manager.redPoint:bindUIandKey(slot0.surpassBtn_.transform, RedPointConst.HERO_STAR_ID .. slot0.heroInfo_.id)
	manager.redPoint:bindUIandKey(slot0.maxLevelSurpassBtn_.transform, RedPointConst.HERO_STAR_ID .. slot0.heroInfo_.id)
	manager.redPoint:bindUIandKey(slot0.breakBtn_.transform, RedPointConst.HERO_BREAK_ID .. slot0.heroInfo_.id)
	manager.redPoint:bindUIandKey(slot0.skinBtn_.transform, RedPointConst.HERO_SKIN_ID .. slot0.heroInfo_.id)
end

function slot0.OnEnter(slot0, slot1)
	slot0.extra_ = slot1
	slot0.isForeign_ = slot1 and slot1.isForeign
	slot0.isTemp_ = slot1 and slot1.isTemp

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:OnEnter(slot0.extra_)
	end

	slot0:RegistEventListener(HERO_DATA_MODIFY, handler(slot0, slot0.OnHeroModify))
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:OnExit()
	end

	slot1 = HeroTools.GetHeroOntologyID(slot0.heroInfo_.id)

	manager.redPoint:unbindUIandKey(slot0.archivebtnTrs_, RedPointConst.HERO_ARCHIVE_ID .. slot1)
	manager.redPoint:unbindUIandKey(slot0.storybtnBtn_.transform, RedPointConst.HERO_STORY_ID .. slot1)
	manager.redPoint:unbindUIandKey(slot0.surpassBtn_.transform)
	manager.redPoint:unbindUIandKey(slot0.maxLevelSurpassBtn_.transform)
	manager.redPoint:unbindUIandKey(slot0.breakBtn_.transform)
	manager.redPoint:unbindUIandKey(slot0.skinBtn_.transform)
end

function slot0.OnHeroModify(slot0, slot1)
	if slot1 == slot0.heroInfo_.id then
		slot0:UpdateView()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:Dispose()

		slot0.heroInfoView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
