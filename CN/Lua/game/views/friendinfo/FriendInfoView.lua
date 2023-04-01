slot0 = class("FriendInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Friend/FriendInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0:CreateSelector()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.userData

	slot0:SetViewProp("isExtraBtn", slot0.params_.isExtraBtn)
	slot0:SetViewProp("isBgPanel", slot0.params_.isBgPanel)

	slot0.playerModel_ = slot0.selector_.compute(gameStore.getState(), slot1.club_id)
	slot0.lv_.text = slot1.level

	slot0:RefreshLvInfo(slot1.level, slot1.exp)

	slot0.uid_.text = slot1.user_id

	slot0:RefreshName(slot1.nick)
	slot0:RefreshSign(slot1.introduce)
	slot0:RefreshHeroCount(slot1.heros_num or slot1.hero_num)
	slot0:RefreshMission(slot1.plot_progress)
	slot0:RefreshRegistTime(slot1.register_time or slot1.register_timestamp)

	slot0.unscribeFun = gameStore.subscribe(function (slot0)
		uv0:OnSubscribe()
	end)
end

function slot0.OnExit(slot0)
	if slot0.unscribeFun then
		slot0.unscribeFun()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.bg_ = slot0:FindCom(typeof(Image), "UserInfoUI/bg")
	slot0.bgGo_ = slot0:FindGo("UserInfoUI/bg")
	slot0.name_ = slot0:FindCom(typeof(Text), "UserInfoUI/panelbg/userinfo/name")
	slot0.uid_ = slot0:FindCom(typeof(Text), "UserInfoUI/panelbg/userinfo/uid")
	slot0.sign_ = slot0:FindCom(typeof(Text), "UserInfoUI/panelbg/userinfo/sign")
	slot0.signinput_ = slot0:FindCom("InputField", "UserInfoUI/panelbg/userinfo/sign_input")
	slot0.lv_ = slot0:FindCom(typeof(Text), "UserInfoUI/panelbg/lvinfo/lv")
	slot0.exp_ = slot0:FindCom(typeof(Text), "UserInfoUI/panelbg/lvinfo/exp")
	slot0.progress_ = slot0:FindCom(typeof(Image), "UserInfoUI/panelbg/lvinfo/progress")
	slot0.logOut_ = slot0:FindGo("UserInfoUI/panelbg/userinfo/btn_logout")
	slot0.have_ = slot0:FindCom(typeof(Text), "UserInfoUI/panelbg/have/num")
	slot0.work_ = slot0:FindCom(typeof(Text), "UserInfoUI/panelbg/work/num")
	slot0.time_ = slot0:FindCom(typeof(Text), "UserInfoUI/panelbg/userinfo/time")

	SetActive(slot0.signinput_.gameObject, false)
	SetActive(slot0.logOut_, false)

	slot0.closePanel_ = slot0:FindCom(typeof(Button), "UserInfoUI/bg")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closePanel_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.closePanel_.onClick:RemoveAllListeners()
end

function slot0.CreateSelector(slot0)
	slot0.selector_ = createStructuredSelector({
		id = function (slot0)
			return PlayerData:GetPlayerInfo().userID
		end
	})
end

function slot0.OnSubscribe(slot0)
end

function slot0.OnViewPropChanged(slot0)
end

function slot0.RefreshLvInfo(slot0, slot1, slot2)
	slot0.lv_.text = slot1
	slot3, slot4 = LvTools.CheckExp(1, tonumber(slot2), "user_level_exp")

	if LvTools.GetIsMaxLv(slot1, "user") then
		slot0.exp_.text = "-/-"
		slot0.progress_.fillAmount = 1
	else
		slot5 = GameLevelSetting[slot1].user_level_exp
		slot0.exp_.text = string.format("%d/%d", slot4, slot5)
		slot0.progress_.fillAmount = math.floor(slot4 / slot5 * 1000) / 1000
	end
end

function slot0.RefreshName(slot0, slot1)
	slot0.name_.text = slot1
end

function slot0.RefreshSign(slot0, slot1)
	slot0.sign_.text = slot1
end

function slot0.RefreshHeroCount(slot0, slot1)
	slot0.have_.text = slot1
end

function slot0.RefreshMission(slot0, slot1)
	if slot1 == 0 then
		slot0.work_.text = "1-1"
	else
		slot2, slot3 = getChapterAndSectionID(slot1)
		slot0.work_.text = ChapterCfg[slot2].sub_type - 1 .. "-" .. slot3
	end
end

function slot0.RefreshRegistTime(slot0, slot1)
	slot0.time_.text = manager.time:DescTime(slot1, "%Y/%m/%d")
end

function slot0.RefreshExtraPanel(slot0)
	SetActive(slot0.extraPanel_, slot0:GetViewProp("isExtraBtn") and not FIRST_TEST)
end

function slot0.RefreshBg(slot0)
	SetActive(slot0.bgGo_, slot0:GetViewProp("isBgPanel") == true)
end

return slot0
