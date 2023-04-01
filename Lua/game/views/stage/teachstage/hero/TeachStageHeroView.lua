slot0 = class("TeachStageHeroView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.switchType_ = slot2

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI(slot0.gameObject_)

	slot0.curIndex_ = 0
	slot0.inited_ = false
	slot0.isScroll_ = false
	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, TeachStageHeroItem)

	slot0.list_:SetHeadTailChangeHandler(handler(slot0, slot0.OnListInit))

	slot0.selectStageItemHandler_ = handler(slot0, slot0.OnSelectStageItem)
end

function slot0.OnEnter(slot0)
	slot0:InitHeroList()
	slot0:RefreshUI()

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0:IsOpenSectionView() then
			uv0.inited_ = true

			for slot4, slot5 in pairs(uv0.list_:GetItemList()) do
				slot5:RefreshSelect(0)
			end

			uv0.m_scrollCom.horizontal = true
		end

		JumpTools.Back()
	end)
end

function slot0.RefreshUI(slot0)
	if slot0.heroID_ then
		if slot0.inited_ then
			if slot0.herolist_ == nil then
				slot0:InitHeroList()
			end

			slot1 = table.indexof(slot0.herolist_, slot0.heroID_)

			slot0.list_:StartScroll(slot0:GetHeroNum(), slot1)
			slot0:RefreshSelectStageItem(slot1)

			if slot0.list_:GetItemList()[slot1] then
				slot0:RemoveTween()

				slot6 = LeanTween.value(slot0.m_scrollContent, slot0.m_scrollContent.transform.localPosition.x, -slot3.transform_.localPosition.x + slot0.m_scrollViewTrans.rect.width / 3 - slot3.transform_.rect.width / 2, 0)
				slot0.tween_ = slot6:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.m_scrollContent.transform.localPosition = Vector3(slot0, 0, 0)
				end))
				slot0.m_scrollCom.horizontal = false
			else
				slot0.m_scrollCom.horizontal = true
			end

			slot0.heroID_ = nil
		else
			if slot0.herolist_ == nil then
				slot0:InitHeroList()
			end

			slot0.curIndex_ = table.indexof(slot0.herolist_, slot0.heroID_)

			if not slot0.isScroll_ then
				slot0.list_:StartScroll(slot0:GetHeroNum())

				slot0.isScroll_ = true
			end
		end
	elseif slot0.curIndex_ > 0 then
		if slot0.list_:GetItemList()[slot0.curIndex_] then
			slot0:RemoveTween()

			slot5 = LeanTween.value(slot0.m_scrollContent, slot0.m_scrollContent.transform.localPosition.x, -slot2.transform_.localPosition.x + slot0.m_scrollViewTrans.rect.width / 3 - slot2.transform_.rect.width / 2, 0)
			slot0.tween_ = slot5:setOnUpdate(LuaHelper.FloatAction(function (slot0)
				uv0.m_scrollContent.transform.localPosition = Vector3(slot0, 0, 0)
			end))
		end

		if slot0:IsOpenSectionInfo() then
			for slot7, slot8 in pairs(slot0.list_:GetItemList()) do
				slot8:RefreshSelect(slot0.curIndex_)
			end

			slot0.m_scrollCom.horizontal = false
		else
			for slot7, slot8 in pairs(slot0.list_:GetItemList()) do
				slot8:RefreshSelect(0)
			end

			slot0.m_scrollCom.horizontal = true
		end
	else
		slot0.list_:StartScroll(slot0:GetHeroNum())
	end
end

function slot0.OnListInit(slot0, slot1, slot2)
	if not slot0.inited_ and slot0.heroID_ then
		if slot0.herolist_ == nil then
			slot0:InitHeroList()
		end

		slot3 = table.indexof(slot0.herolist_, slot0.heroID_)
		slot0.curIndex_ = table.indexof(slot0.herolist_, slot0.heroID_)
		slot0.m_scrollCom.horizontal = false
		slot0.m_scrollContent.transform.localPosition = Vector3(-(350 * slot0.curIndex_ - slot0.m_scrollViewTrans.rect.width / 3), 0, 0)
	end
end

function slot0.OnSelectStageItem(slot0, slot1)
	slot0.inited_ = true

	slot0:RefreshSelectStageItem(slot1)

	if slot0.list_:GetItemList()[slot1] then
		slot0:RemoveTween()

		slot6 = LeanTween.value(slot0.m_scrollContent, slot0.m_scrollContent.transform.localPosition.x, -slot3.transform_.localPosition.x + slot0.m_scrollViewTrans.rect.width / 3 - slot3.transform_.rect.width / 2, 0.2)
		slot0.tween_ = slot6:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.m_scrollContent.transform.localPosition = Vector3(slot0, 0, 0)
		end))
		slot0.m_scrollCom.horizontal = false
	else
		slot0.m_scrollCom.horizontal = true
	end
end

function slot0.TryToCloseSectionView(slot0)
	if slot0:IsOpenSectionView() then
		slot0.inited_ = true

		for slot5, slot6 in pairs(slot0.list_:GetItemList()) do
			slot6:RefreshSelect(0)
		end

		slot0.m_scrollCom.horizontal = true

		JumpTools.Back()
	end
end

function slot0.RefreshSelectStageItem(slot0, slot1)
	slot0.curIndex_ = slot1

	for slot6, slot7 in pairs(slot0.list_:GetItemList()) do
		slot7:RefreshSelect(slot1)
	end
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil)
		LeanTween.cancel(slot0.m_scrollContent)

		slot0.tween_ = nil
	end
end

function slot0.IsOpenSectionView(slot0)
	return slot0:IsOpenRoute("teachSectionInfo")
end

function slot0.OnExit(slot0)
	slot0:RemoveTween()

	slot0.inited_ = true

	if not slot0:IsOpenSectionInfo() then
		for slot5, slot6 in pairs(slot0.list_:GetItemList()) do
			slot6:RefreshSelect(0)
		end

		slot0.m_scrollCom.horizontal = true
	end
end

function slot0.OnClickTeachViewBtn(slot0)
	for slot5, slot6 in pairs(slot0.list_:GetItemList()) do
		slot6:RefreshSelect(0)
	end

	slot0.m_scrollCom.horizontal = true
end

function slot0.Dispose(slot0)
	slot0.m_scrollEvent:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	slot0.m_scrollEvent:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	uv0.super.Dispose(slot0)

	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.curIndex_, slot0.inited_)
	slot2:SetHeroID(slot0.herolist_[slot1])
	slot2:SetSelectCallBack(slot0.selectStageItemHandler_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bgbtn_, nil, function ()
		uv0:TryToCloseSectionView()
	end)

	slot1 = slot0.m_scrollEvent

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:TryToCloseSectionView()
	end))

	slot1 = slot0.m_scrollEvent

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:TryToCloseSectionView()
	end))
end

function slot0.RemoveListeners(slot0)
end

function slot0.SwitchPageUI(slot0, slot1, slot2)
	slot3 = slot0.switchType_ == slot1

	SetActive(slot0.gameObject_, slot3)

	if slot3 then
		slot0.heroID_ = slot2

		slot0:ScrollToCurIndex()
		BattleTeachAction.CancelHeroTeachRedPoint()
	end
end

function slot0.ScrollToCurIndex(slot0)
	if slot0.curIndex_ > 0 then
		slot0.list_:SetScrolledPosition(Vector2.New((slot0.curIndex_ * 350 - 200) / slot0.m_scrollContent.transform.rect.width, 0))
	end
end

function slot0.InitHeroList(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot7 = HeroData
	slot9 = slot7

	for slot8, slot9 in pairs(slot7.GetHeroList(slot9)) do
		if not HeroTools.GetIsHide(slot9.id) then
			table.insert(slot4, slot9)
		end
	end

	function slot8(slot0, slot1)
		if slot0.id < slot1.id then
			return true
		end

		return false
	end

	table.sort(slot4, slot8)

	for slot8, slot9 in pairs(slot4) do
		if slot9.unlock == 1 then
			if BattleTeachData:GetHeroTeachInfo(slot9.id, HeroCfg[slot9.id].study_stage[1]) > 0 then
				table.insert(slot2, slot9.id)
			else
				table.insert(slot1, slot9.id)
			end
		else
			table.insert(slot3, slot9.id)
		end
	end

	table.insertto(slot1, slot2)
	table.insertto(slot1, slot3)

	slot0.herolist_ = slot1
end

function slot0.GetHeroNum(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if not HeroTools.GetIsHide(slot6) then
			slot1 = slot1 + 1
		end
	end

	return slot1
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("teachSectionInfo")
end

return slot0
