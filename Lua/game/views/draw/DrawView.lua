slot0 = class("DrawView", ReduxView)
slot1 = 10000

function slot0.OnCtor(slot0)
	slot0.moviePaths = {
		"SofdecAsset/function/blue.usm",
		"SofdecAsset/function/purple.usm",
		"SofdecAsset/function/glod.usm"
	}
end

function slot0.UIName(slot0)
	return "UI/Draw/TreasureUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.poolToggles_ = {}
	slot0.poolObjects_ = {}
	slot0.poolActivitys_ = {}
	slot0.drawHandler_ = handler(slot0, slot0.DrawCheck)

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.criMovie_ = slot0.movie_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayer_ = slot0.criMovie_.player

	slot0.criMovie_:Stop()

	slot0.moviePlaying = false

	SetActive(slot0.movieGo_, false)

	slot0.drawInteract = slot0.drawInteractGo_:GetComponent("DrawController")

	SetActive(slot0.drawInteractGo_, false)

	slot0.toggleList = LuaList.New(handler(slot0, slot0.IndexToggleItem), slot0.m_toggleList, DrawToggleItem)
	slot0.showRightController = ControllerUtil.GetController(slot0.transform_, "showRight")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnInfo_, nil, function ()
		JumpTools.OpenPageByJump("drawInfo", {
			poolId = uv0.selectPoolId_
		})
	end)
	slot0:AddBtnListener(slot0.btnRecord_, nil, function ()
		JumpTools.OpenPageByJump("drawRecord", {
			poolId = uv0.selectPoolId_
		})
	end)
	slot0:AddBtnListener(slot0.btnOnce_, nil, function ()
		uv0:DrawCheck(DrawConst.DRAW_TYPE.ONE)
	end)
	slot0:AddBtnListener(slot0.btnTenth_, nil, function ()
		uv0:DrawCheck(DrawConst.DRAW_TYPE.TEN)
	end)
	slot0:AddBtnListener(slot0.btnSkip_, nil, function ()
		manager.audio:PlayEffect("ui_system_search", "search_skip", "")
		uv0:SkipMovie()
	end)
	slot0:AddBtnListener(slot0.skipInteractBtn_, nil, function ()
		manager.audio:PlayEffect("ui_system_search", "search_skip", "")
		uv0:SkipInteract()
	end)
end

function slot0.OnTop(slot0)
	slot0:StopMovie()
end

function slot0.OnEnter(slot0)
	slot0:SetupActivityPool()

	if slot0.params_.poolType then
		for slot4, slot5 in ipairs(slot0.poolToggles_) do
			if DrawPoolCfg[slot5].pool_type == slot0.params_.poolType then
				slot0.params_.poolId = slot5
				slot0.params_.poolType = nil
			end
		end
	end

	slot1 = slot0.poolToggles_[1]

	if slot0.params_.poolId and slot0.poolActivitys_[slot0.params_.poolId] and ActivityData:GetActivityIsOpen(slot2) then
		slot1 = slot0.params_.poolId
	end

	slot0:SetSelectPool(slot1)
	DrawTools:LoadDrawLevel()
	manager.ui:SetMainCamera("draw")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopMovie()
	slot0.criMovie_:Stop()

	if slot0.curPoolObject then
		slot0.curPoolObject:SetActive(false, slot0.selectPoolId_)
	end

	slot0.selectPoolId_ = -1
	slot0.one_cost_type = nil
	slot0.ten_cost_type = nil

	if slot0.interactTimer then
		slot0.interactTimer:Stop()

		slot0.interactTimer = nil
	end

	slot0:RemoveCountDownTimer()
	DrawTools:UnLoadDrawLevel()
end

function slot0.SetupActivityPool(slot0)
	slot0.poolToggles_ = {}
	slot1 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}

	for slot5, slot6 in ipairs(slot1) do
		if ActivityData:GetActivityIsOpen(slot6) and ActivityDrawPoolCfg[slot6] then
			for slot11, slot12 in ipairs(slot7.config_list) do
				table.insert(slot0.poolToggles_, slot12)

				slot0.poolActivitys_[slot12] = slot6
			end
		end
	end

	if #slot0.poolToggles_ == 0 then
		Debugger.LogError("draw error pools is empty")
	end

	table.sort(slot0.poolToggles_, function (slot0, slot1)
		return DrawPoolCfg[slot0].order < DrawPoolCfg[slot1].order
	end)
	slot0.toggleList:StartScroll(#slot0.poolToggles_)
end

function slot0.RefreshActivityPool(slot0)
	slot0:SetupActivityPool()

	if not table.indexof(slot0.poolToggles_, slot0.selectPoolId_) then
		slot0.selectPoolId_ = slot0.poolToggles_[1]

		slot0:RefreshUI()
	end
end

function slot0.IndexToggleItem(slot0, slot1, slot2)
	slot2:SetData(slot0.poolToggles_[slot1])
	slot2:SetSelect(slot0.selectPoolId_)
	slot2:RegistCallBack(handler(slot0, slot0.SetSelectPool))
end

function slot0.SetSelectPool(slot0, slot1)
	if not table.indexof(slot0.poolToggles_, slot1) then
		return
	end

	if slot1 == slot0.selectPoolId_ then
		return
	end

	slot0.selectPoolId_ = slot1
	slot0.params_.poolId = slot1

	for slot6, slot7 in pairs(slot0.toggleList:GetItemList()) do
		slot7:SetSelect(slot0.selectPoolId_)
	end

	slot0:RefreshUI()
end

function slot0.ShowBar(slot0)
	slot1 = DrawTools.GetCostTicket(slot0.selectPoolId_)

	if DrawTools.GetActivityCostTicket(slot0.selectPoolId_) == 0 or ItemTools.IsItemExpiredByItemId(slot2) then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			NAVI_BAR,
			slot1,
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			NAVI_BAR,
			slot2,
			slot1,
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SetBarCanAdd(slot2, false)
		manager.windowBar:SetBarCanClick(slot2, true)
	end

	manager.windowBar:RegistBackCallBack(function ()
		DrawData:ResetServantRedPoint()
		uv0:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		DrawData:ResetServantRedPoint()
		gameContext:Go("/home", nil, , true)
	end)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetBarCanAdd(slot1, false)
	manager.windowBar:SetBarCanClick(slot1, true)
end

function slot0.RefreshUI(slot0)
	if slot0.curPoolObject then
		slot0.curPoolObject:SetActive(false)
	end

	slot1 = slot0.selectPoolId_
	slot3 = slot1
	slot4 = true

	if DrawPoolCfg[slot1].pool_selected_type == 9 then
		if DrawData:GetPollUpID(slot1) == 0 then
			slot0.timer = TimeTools.StartAfterSeconds(0.1, function ()
				uv0:Go("/drawSelect", {
					poolID = uv0.selectPoolId_
				})
			end, {})
			slot3 = slot2.optional_lists[1]
		else
			slot3 = slot5
		end
	elseif slot2.pool_selected_type == 2 then
		if DrawData:GetPollUpID(slot1) == 0 then
			slot7 = DrawData:GetPoolUpTimes(slot1)

			if slot2.pool_change == 0 or slot7 < slot6 then
				slot0.timer = TimeTools.StartAfterSeconds(0.1, function (slot0)
					if DrawData:IsOnePrefabPool(slot0) then
						uv0:Go("/drawAllHeroSelect", {
							isFirst = true,
							poolId = uv0.selectPoolId_,
							heroIdList = uv1.optional_detail
						})
					else
						uv0:Go("/drawHeroSelect", {
							poolId = uv0.selectPoolId_
						})
					end
				end, {
					slot1
				})
			end

			slot3 = slot2.optional_lists[1]
			slot4 = false
		else
			slot3 = slot5
		end
	end

	if not slot0.poolObjects_[slot3] then
		if slot2.pool_type == 1 then
			slot0.poolObjects_[slot3] = DrawNormalPool.New(slot0.poolcontentTrs_, slot1, slot3)
		elseif slot2.pool_selected_type == 2 then
			if DrawData:IsOnePrefabPool(slot1) then
				slot0.poolObjects_[slot3] = DrawSelectPool.New(slot0.poolcontentTrs_, slot1, slot3)
			else
				slot0.poolObjects_[slot3] = DrawUpPool.New(slot0.poolcontentTrs_, slot1, slot3)
			end
		elseif slot2.pool_selected_type == 9 then
			slot0.poolObjects_[slot3] = DrawServantPool.New(slot0.poolcontentTrs_, slot1, slot3)
		else
			slot0.poolObjects_[slot3] = DrawBasePool.New(slot0.poolcontentTrs_, slot1, slot3)
		end
	end

	slot0.curPoolObject = slot0.poolObjects_[slot3]

	if slot4 then
		slot0.curPoolObject:Refresh(slot3)
		slot0.curPoolObject:SetActive(true)
	end

	if slot0.curPoolObject:ShowRightPanel() then
		slot5 = DrawTools.GetCostTicket(slot0.selectPoolId_)

		if DrawTools.GetActivityCostTicket(slot0.selectPoolId_) == 0 or ItemTools.IsItemExpiredByItemId(slot6) or ItemTools.getItemNum(slot6) == 0 then
			slot0.iconOnce_.sprite = ItemTools.getItemSprite(slot5)
			slot0.iconTenth_.sprite = ItemTools.getItemSprite(slot5)
			slot0.one_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
			slot0.ten_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
		else
			slot0.iconOnce_.sprite = ItemTools.getItemSprite(slot6)
			slot0.one_cost_type = DrawConst.DRAW_COST_TYPE.ACTIVITY

			if ItemTools.getItemNum(slot6) < 10 then
				slot0.iconTenth_.sprite = ItemTools.getItemSprite(slot5)
				slot0.ten_cost_type = DrawConst.DRAW_COST_TYPE.COMMON
			else
				slot0.iconTenth_.sprite = ItemTools.getItemSprite(slot6)
				slot0.ten_cost_type = DrawConst.DRAW_COST_TYPE.ACTIVITY
			end
		end

		slot0.showRightController:SetSelectedIndex(1)
	else
		slot0.showRightController:SetSelectedIndex(0)
	end

	if slot0.poolActivitys_[slot1] and ActivityData:GetActivityData(slot5) then
		slot0:SetCountDown(true, ActivityData:GetActivityData(slot5).stopTime)
	else
		slot0:SetCountDown(false)
	end

	slot0:ShowBar()
end

function slot0.DestroyPoolGo(slot0)
	for slot4, slot5 in pairs(slot0.poolObjects_) do
		slot5:Dispose()
	end

	slot0.poolObjects_ = {}
end

function slot0.SetCountDown(slot0, slot1, slot2)
	slot0.activityEndTime_ = slot2

	if slot1 then
		if not slot0.activityTimer_ then
			slot0.activityTimer_ = Timer.New(handler(slot0, slot0.UpdateCountDownText), 1, -1)
		end

		slot0:UpdateCountDownText()
		slot0.curPoolObject:ShowCountDownText(true)
		slot0.activityTimer_:Start()
	else
		slot0.curPoolObject:ShowCountDownText(false)

		if slot0.activityTimer_ then
			slot0.activityTimer_:Stop()
		end
	end
end

function slot0.UpdateCountDownText(slot0)
	slot0.curPoolObject:SetCountDownText(slot0.activityEndTime_)
end

function slot0.RemoveCountDownTimer(slot0)
	if slot0.activityTimer_ then
		slot0.activityTimer_:Stop()

		slot0.activityTimer_ = nil
	end
end

function slot0.DrawCheck(slot0, slot1)
	if GameSetting.max_weapon_servant.value[1] <= WeaponServantData:GetServantNum() then
		ShowMessageBox({
			content = GetTips("SERVANT_NUM_MAX"),
			BtnText = {
				[2] = GetTips("SCAN_TIPS_1"),
				GetTips("SCAN_TIPS_2")
			},
			OkCallback = function ()
				JumpTools.OpenPageByJump("/weaponServantList")
			end,
			CancelCallback = function ()
				uv0:StartDraw(uv1)
			end
		})
	else
		slot0:StartDraw(slot1)
	end
end

function slot0.StartDraw(slot0, slot1)
	slot3 = DrawPoolCfg[slot0.selectPoolId_]
	slot4, slot5, slot6 = nil

	if DrawConst.DRAW_TYPE.ONE == slot1 then
		slot4 = slot0.one_cost_type
		slot5 = 1
		slot6 = 1
	elseif DrawConst.DRAW_TYPE.TEN == slot1 then
		slot4 = slot0.ten_cost_type
		slot5 = 10

		if slot3.discount > 0 then
			slot5 = slot5 * slot3.discount / 100
		end

		slot6 = 10
	end

	slot7 = 0

	if DrawConst.DRAW_COST_TYPE.COMMON == slot4 then
		if ItemTools.getItemNum(DrawTools.GetCostTicket(slot2)) < slot5 then
			slot0.shopDrawInfo = {
				poolId = slot2,
				draw_type = slot1,
				cost_id = slot7,
				cost_num = slot5
			}

			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_gacha_diamond = "{" .. CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) .. "," .. CurrencyData:GetRechargeDiamond()
			})
			slot0:ShowBuyView(slot5 - slot8, slot3)

			return
		end
	elseif DrawConst.DRAW_COST_TYPE.ACTIVITY == slot4 then
		if ItemTools.IsItemExpiredByItemId(DrawTools.GetActivityCostTicket(slot2)) then
			ShowTips("TIP_EXPIRED")
			slot0:RefreshActivityPool()
			slot0:RefreshUI()

			return
		end

		if ItemTools.getItemNum(slot7) < slot5 then
			error("draw activity tick num error")

			return
		end
	end

	if GameSetting.draw_num_max.value[1] < slot6 + DrawData:GetTodayDrawTimes() then
		ShowTips("DRAW_NUM_MAX")

		return
	end

	DrawData:SetNewHeroFlag(false)

	if _G.SkipTip["DrawSkipTip" .. slot0.selectPoolId_] then
		manager.achievementTips:SetShowFlag(false)
		DrawAction.GoToDraw(slot0.selectPoolId_, slot1, slot7, slot5)
	else
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					slot7,
					slot5
				},
				string.format(GetTips("DRAW_TIMES"), slot5)
			},
			OkCallback = function ()
				manager.achievementTips:SetShowFlag(false)
				DrawAction.GoToDraw(uv0.selectPoolId_, uv1, uv2, uv3)
			end,
			ToggleCallback = function (slot0)
				_G.SkipTip["DrawSkipTip" .. uv0.selectPoolId_] = slot0
			end
		})
	end
end

function slot0.ShowBuyView(slot0, slot1, slot2)
	slot3 = ExchangeCfg[slot2.exchange_id]
	slot5 = {
		id = slot2.cost_once[1],
		num = slot1
	}
	slot6 = {}
	slot7 = {}

	if math.min(CurrencyData:GetCurrencyNum(slot3.cost_id), slot3.cost * slot1) > 0 then
		slot6 = {
			id = slot3.cost_id,
			num = slot8
		}
	end

	if slot4 - slot8 > 0 then
		slot7 = {
			id = CurrencyConst.GetPlatformDiamondId(),
			num = slot9
		}
	end

	if not slot6.id and slot7.id then
		slot6 = slot7
		slot7 = {}
	end

	JumpTools.OpenPageByJump("itemBuy", {
		title = GetTips("TREASURE_TICKET_TO_BUY"),
		item1 = slot5,
		item2 = slot6,
		item3 = slot7,
		OkCallback = function ()
			slot0 = CurrencyData:GetRechargeDiamond()

			if uv0 > 0 and slot0 < uv0 then
				if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
					ShowMessageBox({
						isTop = true,
						content = GetTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH"),
						OkCallback = function ()
							SDKTools.SendPaymentMessageToSDK("payment_touch", {
								payment_pay_flower_check = 0
							})
							JumpTools.GoToSystem("/rechargeMain", {
								page = 5
							}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
						end,
						CancelCallback = function ()
							SDKTools.SendPaymentMessageToSDK("payment_touch", {
								payment_pay_flower_check = 1
							})
						end
					})
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
				end

				return
			end

			ShopAction.BuyItem(uv1.exchange_id, uv2)
		end
	})
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		slot0:Back()

		if slot0.shopDrawInfo == nil then
			return
		end

		manager.achievementTips:SetShowFlag(false)

		if slot0.poolActivitys_[slot0.shopDrawInfo.poolId] and ActivityData:GetActivityIsOpen(slot6) then
			DrawAction.GoToDraw(slot0.shopDrawInfo.poolId, slot0.shopDrawInfo.draw_type, slot0.shopDrawInfo.cost_id, slot0.shopDrawInfo.cost_num)
		end
	else
		ShowTips(slot1)
	end
end

function slot0.OnGoToDraw(slot0, slot1, slot2)
	if slot1.result == 0 then
		slot3 = {}
		slot4 = 0

		for slot9, slot10 in ipairs(slot1.item) do
			DrawData:TodayDrawTimesChange(1)
			table.insert(slot3, {
				id = slot10.id,
				number = slot10.num
			})

			if slot4 < (ItemCfg[slot10.id] and slot12.display_rare or 0) then
				slot4 = slot13
			end
		end

		slot0:RefreshUI()
		manager.windowBar:HideBar()

		slot0.itemList_ = slot3

		slot0:CheckInteract(slot4)
		slot0:CheckIsHaveUnWatchHero()
	else
		ShowTips(slot1.result)
		slot0:RefreshActivityPool()
		slot0:RefreshUI()
		manager.achievementTips:SetShowFlag(true)
	end
end

function slot0.CheckIsHaveUnWatchHero(slot0)
	if #slot0.itemList_ > 0 then
		for slot5, slot6 in ipairs(slot0.itemList_) do
			if ItemCfg[slot6.id].type == ItemConst.ITEM_TYPE.HERO and ObtainHeroMovieCfg[slot6.id] and not (getData(DrawConst.WATCH_TAG, tostring(slot6.id)) or false) then
				SetActive(slot0.skipInteractBtn_.gameObject, false)
				SetActive(slot0.btnSkip_.gameObject, false)

				return
			end
		end
	end

	SetActive(slot0.skipInteractBtn_.gameObject, true)
	SetActive(slot0.btnSkip_.gameObject, true)
end

function slot0.JumpToReward(slot0)
	manager.achievementTips:SetShowFlag(true)

	if #slot0.itemList_ > 0 then
		slot2 = {}
		slot3 = {}
		slot4 = {}

		for slot8, slot9 in ipairs(slot0.itemList_) do
			table.insert(slot2, {
				slot9.id,
				slot9.number
			})

			clone(slot9).index = slot8

			if ItemCfg[slot9.id].type == ItemConst.ITEM_TYPE.HERO then
				if slot4[slot9.id] or HeroTools.GetHeroIsUnlock(slot9.id) then
					slot10.convert = {
						id = ItemCfg[slot9.id].fragment,
						number = HeroTools.GetHeroRecoveryNum(slot9.id)
					}
					slot10.newTag = false
				else
					slot4[slot9.id] = true
					slot10.newTag = true

					DrawData:SetNewHeroFlag(true)
				end
			elseif ItemCfg[slot9.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
				slot10.newTag = not IllustratedData:GetExistServant(slot9.id)

				if ItemCfg[slot9.id].rare >= 5 then
					DrawData:SetServantRedPoint(slot0.selectPoolId_, 1)
				end
			end

			table.insert(slot3, slot10)
		end

		slot5 = 0

		for slot9, slot10 in ipairs(slot0.itemList_) do
			if ItemCfg[slot10.id].type == ItemConst.ITEM_TYPE.HERO or ItemCfg[slot11].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
				slot12 = ItemCfg[slot11].rare

				for slot16, slot17 in ipairs(GameSetting.currency_for_draw.value) do
					if slot12 == slot17[1] then
						slot5 = slot5 + slot17[2]
					end
				end
			end
		end

		getRewardData(slot2)

		if slot1 ~= 1 then
			gameContext:Go("drawTenTimesReward", {
				reward = slot3,
				callBack_afterTen = function ()
					getReward({
						{
							ItemConst.CURRENCY_FOR_DRAW,
							uv0
						}
					})
					uv1:ShowBar()
				end
			})
		else
			getRewardData({
				{
					ItemConst.CURRENCY_FOR_DRAW,
					slot5
				}
			})
			slot0:ShowBar()
		end
	end
end

function slot0.SkipMovie(slot0)
	slot0.criplayer_.statusChangeCallback = nil

	if slot0.moviePlaying then
		slot0.criMovie_:Stop()
	end

	slot0:DoNextNode(true)
end

function slot0.DoNextNode(slot0, slot1)
	SetActive(slot0.panel_, true)

	slot2 = #slot0.itemList_

	if slot1 and slot2 > 1 then
		slot0:JumpToReward()

		return
	end

	if slot2 > 0 then
		slot3 = {}

		for slot7, slot8 in ipairs(slot0.itemList_) do
			slot9 = {
				id = slot10
			}
			slot10 = slot8.id
			slot12 = ItemCfg[slot10].type

			if slot2 == 1 and slot12 == ItemConst.ITEM_TYPE.HERO and HeroTools.GetHeroIsUnlock(slot10) then
				slot9.switchHeroReward = {
					id = slot11.fragment,
					num = HeroTools.GetHeroRecoveryNum(slot10)
				}

				DrawData:SetNewHeroFlag(true)
			end

			if slot12 == ItemConst.ITEM_TYPE.HERO or slot12 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
				slot13 = slot11.rare

				for slot17, slot18 in ipairs(GameSetting.currency_for_draw.value) do
					if slot13 == slot18[1] then
						slot9.draw_rebate = slot18[2]
					end
				end
			end

			table.insert(slot3, slot9)
		end

		slot0:Go("obtainView", {
			doNextHandler = handler(slot0, slot0.JumpToReward),
			skipHandler = handler(slot0, slot0.JumpToReward),
			itemList = slot3
		})
	else
		slot0:JumpToReward()
	end
end

function slot0.PlayMovie(slot0, slot1)
	slot0.criplayer_:SetVolume(manager.audio:GetMusicVolume())
	slot0.criMovie_:Play()

	slot0.criplayer_.statusChangeCallback = handler(slot0, slot0.CirMovieStatusChange)
	slot0.moviePlaying = true

	if slot1 >= 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif slot1 >= 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	manager.audio:PlayEffect("ui_system_search", "search_animation", "")
	SetActive(slot0.movieGo_, true)
end

function slot0.CirMovieStatusChange(slot0, slot1)
	if tostring(slot1) == "PlayEnd" or slot2 == "Stop" then
		slot0:DoNextNode(false)
	end
end

function slot0.StopMovie(slot0)
	slot0.criplayer_.statusChangeCallback = nil
	slot0.moviePlaying = false

	SetActive(slot0.movieGo_, false)
end

function slot0.SkipInteract(slot0)
	SetActive(slot0.drawInteractGo_, false)

	if slot0.drawInteract.timeline then
		slot0.drawInteract.timeline:Stop()
	end

	slot0:DoNextNode(true)
end

function slot0.CheckInteract(slot0, slot1)
	slot0.maxRare = slot1

	if not DrawTools:LevelIsDone() then
		SetForceShowQuanquan(true)

		if slot0.interactTimer then
			slot0.interactTimer:Stop()

			slot0.interactTimer = nil
		end

		slot0.interactTimer = FrameTimer.New(handler(slot0, slot0.WaitInteract), 1, -1)

		slot0.interactTimer:Start()
	else
		slot0:StarInteract()
	end
end

function slot0.WaitInteract(slot0)
	if DrawTools:LevelIsDone() then
		SetForceShowQuanquan(false)

		if slot0.interactTimer then
			slot0.interactTimer:Stop()

			slot0.interactTimer = nil
		end

		slot0:StarInteract()
	end
end

function slot0.StarInteract(slot0)
	if (slot0.maxRare or 0) >= 5 then
		slot0.criplayer_:SetFile(nil, slot0.moviePaths[3])
	elseif slot1 >= 4 then
		slot0.criplayer_:SetFile(nil, slot0.moviePaths[2])
	else
		slot0.criplayer_:SetFile(nil, slot0.moviePaths[1])
	end

	slot2 = nil

	if (slot1 < 5 or GameObject.Find("X102/TC/directors/director_gold")) and (slot1 < 4 or GameObject.Find("X102/TC/directors/director_purple")) and GameObject.Find("X102/TC/directors/director_blue") then
		slot0.drawInteract:Init(slot2:GetComponent("PlayableDirector"), handler(slot0, slot0.StopInteract))
		slot0.drawInteract:Reset()
		SetActive(slot0.panel_, false)
		SetActive(slot0.drawInteractGo_, true)
	else
		slot0:StopInteract()
	end
end

function slot0.StopInteract(slot0)
	SetActive(slot0.drawInteractGo_, false)
	slot0:PlayMovie(slot0.maxRare or 0)
end

function slot0.Dispose(slot0)
	slot0.timer = nil

	slot0:DestroyPoolGo()
	slot0.toggleList:Dispose()

	slot0.drawHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
