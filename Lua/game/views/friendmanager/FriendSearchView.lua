slot0 = class("FriendSearchView", ReduxView)
slot1 = import("game.tools.LvTools")

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:SetViewProp("searchID", 0)
	slot0:SetViewProp("friendSwitchType", slot2)
	slot0:CreateSelector()
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0.model_ = slot0.selector_.compute(gameStore.getState(), slot0:GetViewProp("friendSwitchType"), slot0:GetViewProp("searchID"))
	slot0.unsubscribeFun = gameStore.subscribe(function (slot0)
		uv0:OnSubscribe()
	end)

	slot0:RefreshSearchUI()
	slot0:Show()
end

function slot0.OnExit(slot0)
	slot0.unsubscribeFun()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.input_ = slot0:FindCom("InputField", "search_desc/InputField")
	slot0.searchBtn_ = slot0:FindCom(typeof(Button), "search_desc/searchBtn")
	slot0.resultBg_ = slot0:FindGo("search_result/bg")
	slot0.noneGo_ = slot0:FindGo("search_result/bg/none")
	slot0.userInfoGo_ = slot0:FindGo("search_result/bg/Panel")
	slot0.nameText_ = slot0:FindCom(typeof(Text), "search_result/bg/Panel/userinfo/name")
	slot0.uidText_ = slot0:FindCom(typeof(Text), "search_result/bg/Panel/userinfo/uid")
	slot0.lvText_ = slot0:FindCom(typeof(Text), "search_result/bg/Panel/userinfo/lvinfo/lv")
	slot0.expText_ = slot0:FindCom(typeof(Text), "search_result/bg/Panel/userinfo/lvinfo/exp")
	slot0.expProgress_ = slot0:FindCom(typeof(Image), "search_result/bg/Panel/userinfo/lvinfo/bg/progress")
	slot0.signText_ = slot0:FindCom(typeof(Text), "search_result/bg/Panel/userinfo/signbg/sign")
	slot0.heroCntText_ = slot0:FindCom(typeof(Text), "search_result/bg/Panel/have/num")
	slot0.workText_ = slot0:FindCom(typeof(Text), "search_result/bg/Panel/work/num")
	slot0.registerTime_ = slot0:FindCom(typeof(Text), "search_result/bg/Panel/time")
	slot0.applyGo_ = slot0:FindGo("btn_apply")
	slot0.applyBtn_ = slot0:FindCom(typeof(Button), "btn_apply")
	slot0.alreadyGo_ = slot0:FindGo("btn_already")
	slot0.alreadyBtn_ = slot0:FindCom(typeof(Button), "btn_already")
	slot0.appliedGo_ = slot0:FindGo("btn_applied")
	slot0.appliedBtn_ = slot0:FindCom(typeof(Button), "btn_applied")
	slot0.appliedText_ = slot0:FindCom(typeof(Text), "btn_applied/text")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.searchBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "searchBtn")

		if delS(uv0.input_.text) then
			slot1 = ActionCreators.TryToSearchFriend(slot0)

			slot1:next(function (slot0)
				ShowTips(slot0.result)

				if isSuccess(slot0.result) then
					slot1 = {}

					for slot5, slot6 in ipairs(slot0.result_list) do
						slot1[slot6.user_id] = {
							user_id = slot6.user_id,
							nick = slot6.nick,
							icon = slot6.icon,
							level = slot6.level,
							poster_girl_id = slot6.poster_girl_id,
							sign = slot6.sign,
							register_timestamp = slot6.register_timestamp,
							hero_num = slot6.hero_num,
							plot_progress = slot6.plot_progress,
							online_state = slot6.online_state,
							hero_show_list = {}
						}

						for slot10, slot11 in ipairs(slot6.hero_show_list) do
							slot1[slot6.user_id].hero_show_list[slot10] = {
								id = slot11.hero_id,
								star = slot11.hero_star,
								level = slot11.hero_level
							}
						end
					end

					uv0:SetViewProp("searchID", slot0.result_list[1] ~= nil and slot2.user_id or 0)
					ActionCreators.FriendSearch(slot1)
				else
					uv0:SetViewProp("searchID", 0)
					uv0:OnSubscribe()
					SetActive(uv0.resultBg_, true)
				end
			end)
		else
			ShowTips("NOT_ENTER_NICK_UID")
			SetActive(uv0.resultBg_, false)
		end
	end)
	slot0:AddBtnListener(slot0.applyBtn_, nil, function ()
		slot0 = uv0.model_.searchResultData.user_id
		slot1 = ActionCreators.TryToMakeFriend(uv0.model_.searchResultData.user_id)

		slot1:next(function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("FRIEND_APPLY_SEND")
				ActionCreators.SendFriendApply({
					uv0
				})
			elseif slot0.result == TipsCfg.get_id_list_by_define.ERROR_FRIEND_EXIST_REQUEST then
				ShowTips(slot0.result)
				ActionCreators.SendFriendApply({
					uv0
				})
			elseif slot0.result == TipsCfg.get_id_list_by_define.ERROR_FRIEND_EXIST_BLACK_TARGET then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("对方已被加入黑名单，是否将该玩家移出黑名单并添加为好友？"),
					OkCallback = function ()
						slot0 = ActionCreators.TryToDeleteBlackList(uv0.model_.searchResultData.user_id)

						slot0:next(function (slot0)
							slot1 = ActionCreators.TryToMakeFriend(uv0.model_.searchResultData.user_id)

							slot1:next(function (slot0)
								ShowTips("FRIEND_APPLY_SEND")
								ActionCreators.SendFriendApply({
									uv0
								})
								SetActive(uv1.resultBg_, false)
								SetActive(uv1.applyGo_, false)
								SetActive(uv1.alreadyGo_, false)
								SetActive(uv1.appliedGo_, false)
							end)
						end)
					end
				})
			else
				ShowTips(slot0.result)
			end

			SetActive(uv1.resultBg_, false)
			SetActive(uv1.applyGo_, false)
			SetActive(uv1.alreadyGo_, false)
			SetActive(uv1.appliedGo_, false)
		end)
	end)
	slot0:AddBtnListener(slot0.alreadyBtn_, nil, function ()
	end)
	slot0:AddBtnListener(slot0.appliedBtn_, nil, function ()
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.searchBtn_.onClick:RemoveAllListeners()
	slot0.applyBtn_.onClick:RemoveAllListeners()
	slot0.alreadyBtn_.onClick:RemoveAllListeners()
	slot0.appliedBtn_.onClick:RemoveAllListeners()
end

function slot0.CreateSelector(slot0)
	slot0.selector_ = createStructuredSelector({
		isOpen = function (slot0, slot1)
			return slot1 == 1
		end,
		searchResultData = function (slot0, slot1, slot2)
			return slot0.friendlist.friend[slot2] or {}
		end
	})
end

function slot0.OnSubscribe(slot0)
	if slot0.model_.isOpen ~= slot0.selector_.compute(gameStore.getState(), slot0:GetViewProp("friendSwitchType"), slot0:GetViewProp("searchID")).isOpen then
		slot0.model_.isOpen = slot1.isOpen

		slot0:Show()
	end

	if slot0.model_.searchResultData ~= slot1.searchResultData then
		slot0.model_.searchResultData = slot1.searchResultData

		slot0:RefreshSearchUI()
	end
end

function slot0.SetFriendSwitchType(slot0, slot1)
	slot0:SetViewProp("friendSwitchType", slot1)
	slot0:OnSubscribe()
end

function slot0.RefreshSearchUI(slot0)
	slot1 = slot0.model_.searchResultData

	if slot0.input_.text == "" then
		SetActive(slot0.resultBg_, false)
	else
		SetActive(slot0.resultBg_, true)
	end

	if slot1.user_id and slot1.user_id ~= 0 then
		SetActive(slot0.noneGo_, false)
		SetActive(slot0.userInfoGo_, true)

		slot0.nameText_.text = slot1.nick
		slot0.uidText_.text = slot1.user_id
		slot0.lvText_.text = slot1.level

		if uv0.GetIsMaxLv(slot1.level, "user") then
			slot0.expText_.text = "-/-"
			slot0.expProgress_.fillAmount = 1
		else
			slot2 = GameLevelSetting[slot1.level].user_level_exp
			slot3, slot4 = uv0.CheckExp(1, slot1.exp, "user_level_exp")
			slot0.expText_.text = string.format("%d/%d", slot4, slot2)
			slot0.expProgress_.fillAmount = math.floor(slot4 / slot2 * 1000) / 1000
		end

		slot0.signText_.text = slot1.sign
		slot0.registerTime_.text = manager.time:STimeDescS(slot1.register_timestamp, "!%Y/%m/%d")
		slot0.heroCntText_.text = slot1.hero_num
		slot2, slot3 = getChapterAndSectionID(slot1.plot_progress)
		slot0.workText_.text = ChapterCfg[slot2].sub_type - 1 .. "-" .. slot3

		if slot1.fType == FriendConst.FRIEND_TYPE.APPLY or slot1.fType == FriendConst.FRIEND_TYPE.APPLYED then
			SetActive(slot0.applyGo_, false)
			SetActive(slot0.alreadyGo_, false)
			SetActive(slot0.appliedGo_, true)

			if slot1.fType == FriendConst.FRIEND_TYPE.APPLY then
				slot0.appliedText_.text = "已发出申请"
			else
				slot0.appliedText_.text = "对方已向你发送申请"
			end
		elseif slot1.fType == FriendConst.FRIEND_TYPE.FRIEND then
			SetActive(slot0.applyGo_, false)
			SetActive(slot0.alreadyGo_, true)
			SetActive(slot0.appliedGo_, false)
		else
			SetActive(slot0.applyGo_, true)
			SetActive(slot0.alreadyGo_, false)
			SetActive(slot0.appliedGo_, false)
		end
	else
		SetActive(slot0.noneGo_, true)
		SetActive(slot0.userInfoGo_, false)
		SetActive(slot0.applyGo_, false)
		SetActive(slot0.alreadyGo_, false)
		SetActive(slot0.appliedGo_, false)
	end
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, slot0.model_.isOpen)
end

return slot0
