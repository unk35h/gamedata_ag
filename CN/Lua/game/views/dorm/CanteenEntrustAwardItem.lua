slot0 = class("CanteenEntrustAwardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.awardItemListScroll_ = LuaList.New(handler(slot0, slot0.indexAwardItem), slot0.awarduilistUilist_, DormDispatchAwardItem)
	slot0.extraController = ControllerUtil.GetController(slot0.transform_, "extra")
end

function slot0.RefreshUI(slot0, slot1)
	slot0.titletextText_.text = BackHomeCanteenTaskCfg[slot1.id].name .. GetTips("CANTEEN_TASK_FINISH")
	slot0.itemList = {}
	slot8 = nil
	slot9 = slot1.pos
	slot4 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustExternAwardAdd, slot8, slot9)

	for slot8, slot9 in ipairs(BackHomeCanteenTaskCfg[slot1.id].reward_list) do
		slot10 = {
			id = slot9[1],
			num = math.floor(slot9[2] * slot4 / 100)
		}

		if slot1.extra_reward == 1 then
			slot10.extraNum = math.floor(math.floor(slot10.num * (100 + GameSetting.canteen_task_success.value[1]) / 100) - slot10.num) * slot4 / 100

			slot0.extraController:SetSelectedState("true")
		else
			slot0.extraController:SetSelectedState("false")
		end

		table.insert(slot0.itemList, slot10)
	end

	slot0.awardItemListScroll_:StartScroll(#slot0.itemList)
end

function slot0.indexAwardItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.itemList[slot1])
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.changeListFun = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.awardItemListScroll_ then
		slot0.awardItemListScroll_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
