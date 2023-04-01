slot0 = class("GuildBossDifficultyItemView", ReduxView)

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

	slot0.indexController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "index")
	slot0.currentController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "current")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, CommonItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id
		})
	end)
	slot2:RefreshData({
		id = slot0.rewardDataList_[slot1][1],
		number = slot0.rewardDataList_[slot1][2]
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.chooseBtn_, nil, function ()
		slot0, slot1 = GuildData:GetLastTime()

		if slot0 ~= "prepose" then
			ShowTips("CLUB_BOSS_DIFFICULTY_EXPIRED_TIP")

			return
		end

		GuildAction.GuildBossChangeDifficulty(uv0.cfg_.boss_level)
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.data_ = slot2
	slot0.cfg_ = ClubBossCfg[slot2]
	slot0.rewardDataList_ = slot0.cfg_.preview_reward

	slot0:UpdateView()
end

slot1 = {
	"CLUB_BOSS_DIFFICULTY_1",
	"CLUB_BOSS_DIFFICULTY_2",
	"CLUB_BOSS_DIFFICULTY_3",
	"CLUB_BOSS_DIFFICULTY_4"
}
slot2 = {
	"CLUB_BOSS_TIPS_1",
	"CLUB_BOSS_TIPS_2",
	"CLUB_BOSS_TIPS_3",
	"CLUB_BOSS_TIPS_4"
}

function slot0.UpdateView(slot0)
	slot0.indexController_:SetSelectedIndex(slot0.index_)

	if slot0.index_ > 1 then
		slot0.conditionLabel_.text = GetTips(uv0[slot0.index_ - 1])
	end

	slot0.difficult_.text = GetTips(uv1[slot0.index_])
	slot0.bloodLabel_.text = slot0.cfg_.boss_hp

	slot0.uiList_:StartScroll(#slot0.rewardDataList_)

	if not GuildData:IsPassBossDifficulty(slot0.index_) then
		slot0.currentController_:SetSelectedState("locked")
	elseif GuildData:GetBossDifficulty() == slot0.index_ then
		slot0.currentController_:SetSelectedState("true")
	else
		slot0.currentController_:SetSelectedState("false")
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
