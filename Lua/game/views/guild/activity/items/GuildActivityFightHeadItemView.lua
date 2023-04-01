slot0 = class("GuildActivityFightHeadItemView", ReduxView)

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

	slot0.emptyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty")
	slot0.heroHead_ = NewHeroHead.New(slot0.heroHeadGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		if not uv0.editing_ then
			return
		end

		if HeroData:GetHeroNum() <= #uv0.heroList_ then
			ShowTips("ACTIVITY_CLUB_HERO_NOT_ENOUGH")

			return
		end

		JumpTools.OpenPageByJump("/guildActivitySetFightHero", {
			putOffList = uv0.putOffList_,
			heroList = uv0.heroList_,
			index = uv0.index_,
			callback = handler(uv0, uv0.OnSelectHero)
		})
	end)
	slot0:AddBtnListener(slot0.lockBtn_, nil, function ()
		if not uv0.editing_ then
			return
		end

		slot1 = 1

		for slot5, slot6 in ipairs(ActivityClubLevelSettingCfg.get_id_list_by_activity[uv0.activityID_]) do
			if uv0.index_ <= ActivityClubLevelSettingCfg[slot6].max_hero then
				slot1 = ActivityClubLevelSettingCfg[slot6].user_level

				break
			end
		end

		ShowTips(string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring(slot1)))
	end)

	slot1 = slot0.heroHead_

	slot1:RegisterClickListener(function ()
		if not uv0.editing_ then
			return
		end

		JumpTools.OpenPageByJump("/guildActivitySetFightHero", {
			putOffList = uv0.putOffList_,
			heroList = uv0.heroList_,
			index = uv0.index_,
			heroId = uv0.heroData_.id,
			callback = handler(uv0, uv0.OnSelectHero)
		})
	end)
end

function slot0.SetEditing(slot0, slot1)
	slot0.editing_ = slot1
end

function slot0.SetHeroChangeHandler(slot0, slot1)
	slot0.heroChangeHandler_ = slot1
end

function slot0.OnSelectHero(slot0, slot1, slot2, slot3)
	if slot0.heroChangeHandler_ then
		slot0.heroChangeHandler_(slot1, slot2, slot3)
	end
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.index_ = slot1
	slot0.heroList_ = slot2
	slot0.heroData_ = slot2[slot1] or nil
	slot0.putOffList_ = slot3
	slot0.activityID_ = slot4

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if GuildActivityData:GetMaxFightHeroCount() < slot0.index_ then
		slot0.emptyController_:SetSelectedState("lock")
	elseif slot0.heroData_ ~= nil then
		slot0.emptyController_:SetSelectedState("hero")
		slot0.heroHead_:SetHeroData(slot0.heroData_.id)

		if table.indexof(slot0.putOffList_, slot0.heroData_.id) then
			slot0.energyLabel_.text = "0"
		else
			slot0.energyLabel_.text = GuildActivityData:GetHeroFatigue(slot0.heroData_.id)
		end
	else
		slot0.emptyController_:SetSelectedState("add")
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

	if slot0.heroHead_ then
		slot0.heroHead_:Dispose()

		slot0.heroHead_ = nil
	end

	slot0.heroChangeHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
