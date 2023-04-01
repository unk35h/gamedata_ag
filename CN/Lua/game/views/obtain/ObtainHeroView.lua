slot0 = class("ObtainHeroView", ObtainBaseView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.starController_ = ControllerUtil.GetController(slot0.starControllerTrs_, "star")
	slot0.AdaptImg_ = slot0:FindCom("AdaptImage", nil, slot0.portrait_.transform)
	slot0.SimplePlayer_ = slot0:FindCom("VoiceOfObtainHeroSimplePlayer", "CriwareAudio")
	slot0.commonItem_ = CommonItem.New(slot0.itemGo_)
end

function slot0.OnClick(slot0)
	if not (slot0.item.switchHeroReward == nil and slot0.playableDirector_ or slot0.playableDirectorSplinter_) then
		return true
	end

	if slot1.time == 0 or slot0:GetTimeLineEndTime() <= slot1.time then
		return true
	else
		slot1.time = slot0:GetTimeLineEndTime()

		return false
	end
end

function slot0.Show(slot0, slot1)
	slot0.item = slot1

	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, true)
	end

	if slot1.switchHeroReward then
		if slot0.playableDirectorSplinter_ then
			slot0.playableDirectorSplinter_:Evaluate()
			slot0.playableDirectorSplinter_:Play()
		end
	elseif slot0.playableDirector_ then
		slot0.playableDirector_:Evaluate()
		slot0.playableDirector_:Play()
	end

	if slot1.draw_rebate and slot1.draw_rebate ~= 0 then
		SetActive(slot0.rebateGo_, true)

		slot0.rebateLab_.text = "x" .. slot1.draw_rebate
	else
		SetActive(slot0.rebateGo_, false)
	end

	slot0:SetInfo(slot1)
end

function slot0.SetInfo(slot0, slot1)
	if not HeroCfg[slot1.id] then
		return
	end

	slot0.portrait_.sprite = AssetEx.LoadSprite("Textures/Character/Portrait/" .. slot2)

	slot0.AdaptImg_:AdaptImg()

	slot0.name_.text = GetI18NText(slot3.name) .. "·" .. GetI18NText(slot3.suffix)
	slot0.camp_.sprite = getSprite("Atlas/CampItem", RaceEffectCfg[slot3.race].icon)
	slot6 = math.min(ItemCfg[slot2].display_rare, 5)

	slot0.starController_:SetSelectedIndex(slot6)

	if slot6 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif slot6 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	slot0.SimplePlayer_:SetVoiceInfo(string.format("vo_sys_%d", slot2), string.format("v_s_%d_%s", slot2, "get"), string.format("vo_sys_%d.awb", slot2))

	if slot1.switchHeroReward then
		slot0.commonItem_:RefreshData({
			id = slot5.fragment,
			number = HeroTools.GetHeroRecoveryNum(slot2)
		})
		SetActive(slot0.itemGo_, true)
	else
		SetActive(slot0.itemGo_, false)
	end
end

function slot0.GetTimeLineEndTime(slot0)
	if not slot0.item.switchHeroReward then
		return 5.5
	else
		return 7.8
	end
end

function slot0.Skip2End(slot0)
	if slot0.item.switchHeroReward == nil and slot0.playableDirector_ or slot0.playableDirectorSplinter_ then
		slot1.time = 5.5
	end
end

function slot0.Dispose(slot0)
	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.Hide(slot0)
	uv0.super.Hide(slot0)

	slot0.portrait_.sprite = nil
end

return slot0
