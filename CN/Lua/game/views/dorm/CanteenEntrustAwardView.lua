slot0 = class("CanteenEntrustAwardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamTaskToCompletePop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.awardListScroll_ = LuaList.New(handler(slot0, slot0.indexAwardItem), slot0.awardviewuilistUilist_, CanteenEntrustAwardItem)
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.awardListScroll_

	slot1:SetPageChangeHandler(handler(slot0, slot0.UpdataButton))
	slot0:AddBtnListener(slot0.leftbtnBtn_, nil, function ()
		uv0.index = uv0.index - 1

		uv0:UpdataButton(uv0.index)
		uv0.awardListScroll_:ScrollToIndex(uv0.index, true, false)
	end)
	slot0:AddBtnListener(slot0.rightbtnBtn_, nil, function ()
		uv0.index = uv0.index + 1

		uv0:UpdataButton(uv0.index)
		uv0.awardListScroll_:ScrollToIndex(uv0.index, true, false)
	end)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		CanteenData:ClearCacheEntrustAward()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.flag = slot0.params_.flag
	slot0.index = 1

	slot0:UpdataView()
	slot0:GetAwardList()
end

function slot0.UpdataButton(slot0, slot1)
	slot0.index = slot1

	if slot1 == 1 then
		SetActive(slot0.leftbtnGo_, false)
	else
		SetActive(slot0.leftbtnGo_, true)
	end

	if slot1 == #slot0.awardList then
		SetActive(slot0.rightbtnGo_, false)
	else
		SetActive(slot0.rightbtnGo_, true)
	end
end

function slot0.UpdataView(slot0)
	slot0.awardList = CanteenData:GetEntrustAwardCache()

	slot0.awardListScroll_:StartScroll(#slot0.awardList)
	slot0:UpdataButton(slot0.index)
end

function slot0.indexAwardItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.awardList[slot1], slot0.flag)
end

function slot0.GetAwardList(slot0)
	if slot0.awardList and slot0.flag then
		for slot4, slot5 in ipairs(slot0.awardList) do
			slot12 = slot5.pos
			slot7 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustExternAwardAdd, nil, slot12)

			for slot12, slot13 in ipairs(BackHomeCanteenTaskCfg[slot5.id].reward_list) do
				slot14 = {
					id = slot13[1],
					num = math.floor(slot13[2] * slot7 / 100)
				}

				if slot5.extra_reward == 1 then
					slot14.extraNum = math.floor(math.floor(slot14.num * (100 + GameSetting.canteen_task_success.value[1]) / 100) - slot14.num) * slot7 / 100
				end

				slot0:GetAward(slot14)
			end
		end

		slot0.flag = false
	end
end

function slot0.GetAward(slot0, slot1)
	if slot1.extraNum then
		slot1.num = slot1.num + slot1.extraNum
	end

	addRewardData({
		slot1.id,
		slot1.num
	})
end

function slot0.Dispose(slot0)
	if slot0.awardListScroll_ then
		slot0.awardListScroll_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
