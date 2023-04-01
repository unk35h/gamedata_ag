slot0 = class("AchievementTipsMgr")

function slot0.Ctor(slot0)
	slot0:InitData()
end

function slot0.InitData(slot0)
	slot0.achievementList_ = {}
	slot0.fliterTypeList_ = {}
	slot0.fliterList_ = {}
	slot0.canShow_ = true
end

function slot0.FliteAchievementType(slot0, slot1)
	slot0.fliterTypeList_ = slot1

	if #slot1 <= 0 then
		table.insertto(slot0.achievementList_, slot0.fliterList_)

		slot0.fliterList_ = {}
	end

	slot0:SetShowFlag(true)
end

function slot0.AddAchievementID(slot0, slot1)
	slot2 = AchievementCfg[slot1].type_id

	if #slot0.fliterTypeList_ > 0 and not table.keyof(slot0.fliterTypeList_, slot2) then
		table.insert(slot0.fliterList_, slot1)
	else
		table.insert(slot0.achievementList_, slot1)
	end

	slot0:ShowAchievementTips()
end

function slot0.SetShowFlag(slot0, slot1)
	slot0.canShow_ = slot1

	if slot1 and slot0.timer_ == nil then
		slot0:ShowAchievementTips()
	end
end

function slot0.ShowAchievementTips(slot0)
	if slot0.timer_ then
		return
	end

	if #slot0.achievementList_ > 0 then
		if slot0.canShow_ == false then
			return
		end

		slot0.isRuning_ = true
		slot2 = AchievementCfg[slot0.achievementList_[1]]

		if slot0.gameObject_ == nil then
			slot0:InitUI()
		end

		slot0.textName_.text = slot2.name

		slot0.typeController_:SetSelectedState(slot2.type_id)
		SetActive(slot0.gameObject_, true)
		table.remove(slot0.achievementList_, 1)

		slot0.timer_ = Timer.New(function ()
			SetActive(uv0.gameObject_, false)

			uv0.timer_ = nil

			uv0:ShowAchievementTips()
		end, 2, 1)

		slot0.timer_:Start()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectItem_)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.textRect_)
	end
end

function slot0.InitUI(slot0)
	Asset.Load("Atlas/AchievementIcon", true)

	slot0.gameObject_ = GameObject.Instantiate(Asset.Load("UI/Achievement/AchievementPopUI"), GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage").transform)
	slot0.transform_ = slot0.gameObject_.transform

	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)

	slot0.typeController_ = ControllerUtil.GetController(slot0.rectItem_, "achievementType")
end

function slot0.Hide(slot0, slot1)
	if slot0.gameObject_ == nil then
		return
	end

	SetActive(slot0.goPanel_, not slot1)
end

function slot0.Dispose(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.transform_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
end

return slot0
