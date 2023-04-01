slot0 = class("GuildRecommendItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.recommendClickHandler_ = handler(slot0, slot0.ClickRecommendItem)

	manager.notify:RegistListener(GUILD_RECOMMEND_CLICK, slot0.recommendClickHandler_)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(GUILD_RECOMMEND_CLICK, slot0.recommendClickHandler_)

	slot0.recommendClickHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		manager.notify:Invoke(GUILD_RECOMMEND_CLICK, uv0.index_)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.textName_.text = slot2.name
	slot0.textLv_.text = slot2.level
	slot0.textMember_.text = string.format("%s/%s", slot2.member, slot2.maxMemberCnt)
	slot0.textContribute_.text = slot2.contribute
	slot0.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[slot2.icon].icon_bg)

	SetActive(slot0.goFreeTag_, slot2.isFree)
	slot0:RefreshSelect(slot3)

	if slot2.isFree then
		slot0.controller_:SetSelectedState("0")
	else
		slot0.controller_:SetSelectedState("1")
	end
end

function slot0.ClickRecommendItem(slot0, slot1)
	slot0:RefreshSelect(slot0.index_ == slot1)
end

function slot0.RefreshSelect(slot0, slot1)
	if slot1 then
		slot0.selectController_:SetSelectedState("true")
	else
		slot0.selectController_:SetSelectedState("false")
	end
end

return slot0
