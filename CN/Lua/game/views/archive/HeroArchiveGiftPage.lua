slot0 = class("HeroArchiveGiftPage", ReduxView)
slot1 = nil

function slot2()
	if not uv0 then
		uv0 = 0

		for slot3 = 1, HeroConst.HERO_LOVE_LV_MAX do
			uv0 = uv0 + GameLevelSetting[slot3].hero_love_exp
		end
	end

	return uv0
end

function slot3(slot0, slot1)
	slot3 = GameSetting.gift_value.value

	if slot1 == HeroRecordCfg[slot0].gift_like_id1[1] then
		return slot3[1], "like"
	end

	return slot3[2], "no"
end

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.itemList_ = {}
	slot0.selectItem_ = 0
	slot0.lv_ = 0
	slot0.maxValue = 1
	slot0.minValue = 1
	slot0.isFreezing_ = false

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, ArchiveGiftItem)
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
end

function slot0.RegisterCircle(slot0, slot1)
	slot0.RefreshCircle_ = slot1
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.slide_barSlr_.onValueChanged

	slot1:AddListener(function (slot0)
		if slot0 < 1 then
			uv0.slide_barSlr_.value = 1
			slot0 = 1
		end

		uv0:UpdateSliderValue()
		uv0:RefreshBar(slot0 * uv1(uv0.archiveID_, uv0.itemList_[uv0.selectItem_].id))

		if slot0 == uv0.slide_barSlr_.maxValue then
			uv0.btn_addBtn_.interactable = false
		else
			uv0.btn_addBtn_.interactable = true
		end

		if slot0 == 1 then
			uv0.btn_cutBtn_.interactable = false
		else
			uv0.btn_cutBtn_.interactable = true
		end
	end)
	slot0:AddBtnListener(slot0.btn_addBtn_, nil, function ()
		if uv0.slide_barSlr_.value < uv0.itemList_[uv0.selectItem_].number then
			uv0.slide_barSlr_.value = slot0 + 1
		end
	end)
	slot0:AddBtnListener(slot0.btn_cutBtn_, nil, function ()
		if uv0.slide_barSlr_.value > 1 then
			uv0.slide_barSlr_.value = slot0 - 1
		end
	end)
	slot0:AddBtnListener(slot0.giftbtnBtn_, nil, function ()
		if uv0.slide_barSlr_.value == 0 then
			return
		end

		slot2 = slot0 * uv1(uv0.archiveID_, uv0.itemList_[uv0.selectItem_].id)

		if uv2() <= ArchiveData:GetArchive(uv0.archiveID_).exp then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("HERO_LOVE_LEVEL_MAX_NOTE"),
				OkCallback = function ()
					HeroAction.SendGift(uv0.archiveID_, {
						{
							id = uv1.id,
							num = uv2
						}
					}, uv3)
				end
			})

			return
		end

		HeroAction.SendGift(uv0.archiveID_, {
			{
				id = slot1.id,
				num = slot0
			}
		}, slot2)
	end)
end

function slot0.UpdateSliderValue(slot0)
	slot0.textnunberText_.text = slot0.slide_barSlr_.value
end

function slot0.UpdateData(slot0)
	slot0.itemList_ = {}
	slot2 = 1

	for slot6, slot7 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.ARCHIVE_GIFT]) do
		slot8 = MaterialData:GetMaterial(slot7)
		slot9, slot10 = uv0(slot0.archiveID_, slot8.id)

		if slot8.num ~= 0 and slot10 == "like" then
			slot0.itemList_[slot2] = {
				id = slot8.id,
				number = slot8.num
			}
			slot2 = slot2 + 1
		end
	end

	for slot6, slot7 in ipairs(slot1) do
		slot8 = MaterialData:GetMaterial(slot7)
		slot9, slot10 = uv0(slot0.archiveID_, slot8.id)

		if slot8.num ~= 0 and slot10 ~= "like" then
			slot0.itemList_[slot2] = {
				id = slot8.id,
				number = slot8.num
			}
			slot2 = slot2 + 1
		end
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3, slot4 = uv0(slot0.archiveID_, slot0.itemList_[slot1].id)

	slot2:SetLike(slot4)

	slot5 = slot2.commonItem_

	slot5:RefreshData(slot0.itemList_[slot1])
	slot5:SetSelectType("equip")
	slot5:ShowSelect(slot1 == slot0.selectItem_ and 1 or 0)
	slot5:RegistCallBack(function (slot0)
		if uv0 == uv1.selectItem_ then
			uv2:ShowSelect(0)

			uv1.selectItem_ = 0

			uv1:RefreshInfo(false)
		else
			if uv1.selectItem_ ~= 0 and uv1.scrollHelper_:GetItemList()[uv1.selectItem_] then
				slot1.commonItem_:ShowSelect(0)
			end

			uv2:ShowSelect(1)

			uv1.selectItem_ = uv0

			uv1:RefreshInfo(true)
		end
	end)
end

function slot0.RefreshInfo(slot0, slot1)
	if slot1 then
		slot0.lastSeclect_ = slot0.selectItem_
		slot2 = ItemCfg[slot0.itemList_[slot0.selectItem_].id]
		slot3 = uv0(slot0.archiveID_, slot0.itemList_[slot0.selectItem_].id)
		slot0.addnumberText_.text = slot3
		slot0.nameText_.text = slot2.name
		slot0.giftinfoText_.text = slot2.desc
		slot0.textnunberText_.text = 1
		slot0.slide_barSlr_.value = 1
		slot0.maxValue = math.max(math.min(slot0.itemList_[slot0.selectItem_].number, math.ceil((uv1() - ArchiveData:GetArchive(slot0.archiveID_).exp) / slot3)), 1)
		slot0.slide_barSlr_.maxValue = slot0.maxValue

		if slot0.maxValue == 1 then
			slot0.btn_addBtn_.interactable = false
			slot0.btn_cutBtn_.interactable = false
		else
			slot0.btn_cutBtn_.interactable = false
			slot0.btn_addBtn_.interactable = true
		end

		slot0:RefreshBar(slot3)

		if slot0.controller_:GetSelectedState() ~= "have" then
			slot0.controller_:SetSelectedState("have")
			slot0.scrollHelper_:ScrollToIndex(slot0.selectItem_, false, true)
		end
	else
		slot0:RefreshBar()
		slot0.controller_:SetSelectedState("noselect")
		slot0.scrollHelper_:StartScrollByPosition(#slot0.itemList_, slot0.scrollHelper_:GetScrolledPosition())
	end

	slot0.giftInfoScrollRect_.verticalNormalizedPosition = 1
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.archiveID_ = slot1
	slot0.heroID_ = slot2
	slot0.selectItem_ = 0

	slot0:UpdateData()

	if #slot0.itemList_ <= 0 then
		slot0.controller_:SetSelectedState("no")
		slot0:RefreshBar(0)
	else
		slot0.selectItem_ = 1

		slot0.scrollHelper_:StartScroll(#slot0.itemList_)
		slot0:RefreshInfo(true)
	end
end

function slot0.OnSendGift(slot0, slot1, slot2)
	if uv0() <= ArchiveData:GetArchive(slot0.archiveID_).exp then
		ShowTips("HERO_LOVE_LEVEL_MAX")
	else
		ShowTips("HERO_LOVE_EXP_UP")
	end

	if not slot0.isFreezing_ then
		slot0.isFreezing_ = true

		slot0:PlayVoice()
	end

	slot0:UpdateData()

	if #slot0.itemList_ <= 0 then
		slot0.selectItem_ = 0

		slot0.controller_:SetSelectedState("no")
		slot0:RefreshBar()
	else
		if slot0.selectItem_ > #slot0.itemList_ then
			slot0.selectItem_ = #slot0.itemList_
		else
			slot0.selectItem_ = slot0.selectItem_
		end

		slot0:RefreshInfo(true)
		slot0.scrollHelper_:StartScroll(#slot0.itemList_)
		slot0.scrollHelper_:ScrollToIndex(slot0.selectItem_, false, false)
	end
end

function slot0.PlayVoice(slot0)
	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = slot0.heroID_,
		sound_id = HeroVoiceCfg.get_id_list_by_file.emotion[1]
	})
	slot0.interruptFunc_()

	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	slot0.delayPlayTimer_ = Timer.New(function ()
		if manager.audio:IsStoppedOfVoice() then
			uv0.delayPlayTimer_:Stop()

			uv0.delayPlayTimer_ = nil

			HeroTools.PlayVoice(uv0.heroID_, HeroVoiceCfg[uv1].file, HeroVoiceCfg[uv1].type)

			uv0.timer_ = TimeTools.StartAfterSeconds(math.max(HeroTools.GetTalkLength(uv0.heroID_, HeroVoiceCfg[uv1].file, HeroVoiceCfg[uv1].type), 0.017) / 1000 + 10, function ()
				uv0:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	slot0.delayPlayTimer_:Start()

	slot0.textinfoText_.text = HeroVoiceDescCfg[slot0.heroID_][slot1]
end

function slot0.StopVoice(slot0)
	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	manager.audio:StopVoiceImmediate()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
		slot0.isFreezing_ = false
	end
end

function slot0.RegisterInterruptVoice(slot0, slot1)
	slot0.interruptFunc_ = slot1
end

function slot0.RefreshBar(slot0, slot1)
	SetActive(slot0.maxGo_, false)

	slot0.lv_, slot0.curExp_ = LvTools.LoveExpToLevel(ArchiveData:GetArchive(slot0.archiveID_).exp)

	if not slot1 then
		slot2, slot3 = LvTools.LoveExpToLevel(ArchiveData:GetArchive(slot0.archiveID_).exp)

		if slot2 == HeroConst.HERO_LOVE_LV_MAX then
			slot0.barImg_.fillAmount = 1
			slot0.lvtextText_.text = ""
		else
			slot0.barImg_.fillAmount = slot3 / GameLevelSetting[slot2].hero_love_exp
			slot0.lvtextText_.text = string.format("%d<size=28><color=#61676D>/%d</color></size>", slot3, GameLevelSetting[slot2].hero_love_exp)
		end

		slot0.RefreshCircle_(slot2)

		slot0.bar2Img_.fillAmount = 0
	else
		slot2, slot3 = LvTools.LoveExpToLevel(ArchiveData:GetArchive(slot0.archiveID_).exp + slot1)

		if slot0.lv_ < slot2 then
			slot0.barImg_.fillAmount = 0
		elseif slot2 == HeroConst.HERO_LOVE_LV_MAX then
			slot0.barImg_.fillAmount = 1
		else
			slot0.barImg_.fillAmount = slot0.curExp_ / GameLevelSetting[slot2].hero_love_exp
		end

		slot0.RefreshCircle_(slot2)

		if slot2 == HeroConst.HERO_LOVE_LV_MAX then
			SetActive(slot0.maxGo_, true)

			slot0.bar2Img_.fillAmount = 1
			slot0.lvtextText_.text = string.format("%d<size=28><color=#61676D>/%d</color></size>", GameLevelSetting[slot2 - 1].hero_love_exp, GameLevelSetting[slot2 - 1].hero_love_exp)
		else
			slot0.bar2Img_.fillAmount = slot3 / GameLevelSetting[slot2].hero_love_exp
			slot0.lvtextText_.text = string.format("%d<size=28><color=#61676D>/%d</color></size>", slot3, GameLevelSetting[slot2].hero_love_exp)
		end
	end
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	slot0.slide_barSlr_.onValueChanged:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
