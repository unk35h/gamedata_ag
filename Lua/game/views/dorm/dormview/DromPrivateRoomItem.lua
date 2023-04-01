slot0 = class("DromPrivateRoomItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.publicHeroScroll = LuaList.New(handler(slot0, slot0.indexHeroItem), slot0.uilistGo_, DormHeroIconItem)
	slot0.publicStateController = ControllerUtil.GetController(slot0.transform_, "roomType")
	slot0.emptyController = ControllerUtil.GetController(slot0.uilistGo_.transform, "empty")
	slot4 = "Animation"
	slot0.floorAniamtion = slot0.dimianGo_:GetComponent(slot4)
	slot0.edit = false
	slot0.time = 2 / GameDisplayCfg.dorm_area_swap_speed.value[1]
	slot0.conut = 0
	slot0.itemPosition = {}
	slot0.item = {}

	for slot4 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
		slot5 = {
			move = false,
			roomStateController = ControllerUtil.GetController(slot0["item" .. slot4 .. "Go_"].transform, "state"),
			roomDetailController = ControllerUtil.GetController(slot0["item" .. slot4 .. "Go_"].transform, "detail"),
			heroIconController = ControllerUtil.GetController(slot0["item" .. slot4 .. "Go_"].transform, "hero"),
			btn = slot0["item" .. slot4 .. "Btn_"],
			roomIcon = slot0["role" .. slot4 .. "Img_"],
			itemGo = slot0["item" .. slot4 .. "Go_"],
			detail = DormDetailsItem.New(slot0["item" .. slot4 .. "Go_"])
		}
		slot5.itemTrs = slot5.itemGo:GetComponent("RectTransform")
		slot5.animation = slot5.itemGo:GetComponent("Animation")
		slot0.item[slot4] = slot5
		slot0.itemPosition[slot4] = {
			has = true,
			pos = Vector3.New(slot0.item[slot4].itemTrs.localPosition.x, slot0.item[slot4].itemTrs.localPosition.y, slot0.item[slot4].itemTrs.localPosition.z)
		}

		slot5.itemTrs:SetSiblingIndex(slot4)
	end

	slot0:RegisterEvents()

	slot0.itemPosition[1].slibing = 5
	slot0.itemPosition[2].slibing = 7
	slot0.itemPosition[3].slibing = 4
	slot0.itemPosition[4].slibing = 2
	slot0.itemPosition[5].slibing = 1
	slot0.itemPosition[6].slibing = 3
	slot0.itemPosition[7].slibing = 6
	slot0.itemPosition[8].slibing = 8

	for slot4 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
		slot0.item[slot4].itemTrs:SetSiblingIndex(slot0.itemPosition[slot4].slibing)
	end
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_PRIVATE_DORM_CHANGE, function (slot0)
		if DormitoryData:GetDormSceneData(slot0).pos_id - DormConst.DORM_POS_ID_OFFSET - (uv0.floor - 1) * DormConst.DORM_FLOOR_ROOM_NUM < 1 or DormConst.DORM_FLOOR_ROOM_NUM < slot2 then
			return
		end

		uv0:GetItemByIndex(slot2).roomID = slot0

		if BackHomeCfg[slot0].type == DormConst.BACKHOME_TYPE.PublicDorm and uv0.floor == 1 then
			uv0:RefreshPublicRoomHeroList()
		elseif BackHomeCfg[slot0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			uv0:RefreshRoomState(slot2, true)
		end
	end)

	function uv0.RegisterEvent(slot0)
		slot0:RegistEventListener(DORM_ROME_CHANGE_POSITION, function ()
			uv0.canClickFlag = true
		end)
	end
end

function slot0.AddUIListener(slot0)
	slot4 = slot0.publicBtn_

	slot0:AddBtnListenerScale(slot4, nil, function ()
		uv0:ClickRoom(DormConst.PUBLIC_DORM_ID)
	end)

	for slot4 = 1, 8 do
		while true do
			if slot4 == 1 and slot0.floor == GameDisplayCfg.dorm_lobby_layer.value[1] then
				break
			end

			slot0:AddPressByTimeListener(slot0.item[slot4].btn.gameObject, GameDisplayCfg.dorm_area_swap_time.value[1], function ()
				if not uv0.edit then
					uv0:ClickRoom(uv0.item[uv1].roomID, uv0.item[uv1].oriIndex)
				end
			end, function (slot0, slot1, slot2)
				if not uv0.edit and DormitoryData:GetPrivateDormRoomState(uv0:GetItemByIndex(uv0.item[uv1].oriIndex).roomID) == DormEnum.DormRoomUseState.HadPlace then
					uv0:StartDrag(uv0.item[uv1].oriIndex)
				end
			end, function (slot0, slot1, slot2)
				if uv0.edit then
					uv0:EndDrag(uv0.item[uv1].oriIndex)
				end
			end, slot0.item[slot4].oriIndex)
			slot0:AddDragListener(slot0.item[slot4].btn.gameObject, function ()
			end, function ()
				if uv0.edit then
					slot3, uv0.item[uv1].itemTrs.localPosition = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(uv0.fatherTrs, Vector2.New(Input.mousePosition.x, Input.mousePosition.y), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, {})
				end
			end, function ()
			end)
			slot0:AddPonitListener(slot0.item[slot4].btn.gameObject, function ()
				if uv0.edit and uv0.dragIndex ~= uv0.item[uv1].oriIndex and not uv0.item[uv1].move then
					for slot3, slot4 in pairs(uv0.itemPosition) do
						if not slot4.has then
							uv0.item[uv1].move = true
							uv0.itemPosition[uv0.item[uv1].index].has = false
							slot4.has = true
							uv0.tweenValue_ = LeanTween.value(0, 1, uv0.time):setOnUpdate(LuaHelper.FloatAction(function (slot0)
								uv0.item[uv1].itemTrs.localPosition = Vector3(Mathf.Lerp(uv0.item[uv1].itemTrs.localPosition.x, uv0.itemPosition[uv2].pos.x, slot0), Mathf.Lerp(uv0.item[uv1].itemTrs.localPosition.y, uv0.itemPosition[uv2].pos.y, slot0), Mathf.Lerp(uv0.item[uv1].itemTrs.localPosition.z, uv0.itemPosition[uv2].pos.z, slot0))
							end)):setOnComplete(LuaHelper.VoidAction(function ()
								uv0.item[uv1].index = uv2
								uv0.item[uv1].move = false

								uv0.item[uv1].itemTrs:SetSiblingIndex(uv0.itemPosition[uv2].slibing)
							end)):setEase(LeanTweenType.easeOutQuad)

							return
						end
					end

					print("未找到空缺位置")
				end
			end, function ()
			end)

			break
		end
	end
end

function slot0.StartDrag(slot0, slot1)
	slot0.canClickFlag = false
	slot0.edit = true
	slot0.dragIndex = slot1
	slot2 = slot0:GetItemByIndex(slot1)

	slot2.roomStateController:SetSelectedState("select")
	slot2.itemTrs:SetAsFirstSibling()

	slot0.itemPosition[slot2.oriIndex].has = false
end

function slot0.EndDrag(slot0, slot1)
	slot6 = "normal"

	slot0:GetItemByIndex(slot1).roomStateController:SetSelectedState(slot6)

	for slot6, slot7 in pairs(slot0.itemPosition) do
		if not slot7.has then
			slot7.has = true
			slot0.tweenValue_ = LeanTween.value(0, 1, slot0.time):setOnUpdate(LuaHelper.FloatAction(function (slot0)
				uv0.itemTrs.localPosition = Vector3(Mathf.Lerp(uv0.itemTrs.localPosition.x, uv1.itemPosition[uv2].pos.x, slot0), Mathf.Lerp(uv0.itemTrs.localPosition.y, uv1.itemPosition[uv2].pos.y, slot0), Mathf.Lerp(uv0.itemTrs.localPosition.z, uv1.itemPosition[uv2].pos.z, slot0))
			end)):setOnComplete(LuaHelper.VoidAction(function ()
				uv0.index = uv1

				uv0.itemTrs:SetSiblingIndex(uv2.itemPosition[uv1].slibing)

				uv2.edit = false
				uv2.dragIndex = nil

				uv2:RevisePrivateDormPos()
			end)):setEase(LeanTweenType.easeOutQuad)

			return
		end
	end

	print("未找到空缺位置")
end

function slot0.GetItemByIndex(slot0, slot1)
	if slot0.item then
		for slot5, slot6 in pairs(slot0.item) do
			if slot6.oriIndex == slot1 then
				return slot6
			end
		end

		print("未找到对应item")
	end
end

function slot0.RevisePrivateDormPos(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.item) do
		if slot6.oriIndex ~= slot6.index then
			slot6.oriIndex = slot6.index
			slot7 = slot6.oriIndex + DormConst.DORM_POS_ID_OFFSET + (slot0.floor - 1) * DormConst.DORM_FLOOR_ROOM_NUM

			if slot6.roomID then
				table.insert(slot1, {
					roomID = slot6.roomID,
					posID = slot7
				})
			end
		end
	end

	if #slot1 > 0 then
		DormAction:RevisePrivateDormPos(slot1)
	end
end

function slot0.InitRoomPos(slot0, slot1)
	if slot0.conut == 0 then
		slot0.floor = slot1

		for slot5 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
			slot0.item[slot5].oriIndex = slot5
			slot0.item[slot5].index = slot5
		end

		slot0:AddUIListener()

		slot0.conut = 1
	end
end

function slot0.RefreshUI(slot0, slot1)
	slot0.floor = slot1

	if slot1 == GameDisplayCfg.dorm_lobby_layer.value[1] then
		slot0.publicStateController:SetSelectedState("public")
		slot0:RefreshPublicRoomHeroList()
	else
		slot0.publicStateController:SetSelectedState("private")
	end

	slot5 = slot1

	slot0:InitRoomPos(slot5)

	for slot5 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
		slot0.item[slot5].roomID = DormitoryData:GetRoomIDByPosID(slot5 + DormConst.DORM_POS_ID_OFFSET + (slot0.floor - 1) * DormConst.DORM_FLOOR_ROOM_NUM)

		slot0:RefreshRoomState(slot5)
	end

	slot0.transform_:SetSiblingIndex(slot1 - 1)
	slot0.animationFunc(slot0.floor, slot0.floorAniamtion)
end

function slot0.RegisterAnimation(slot0, slot1)
	if slot1 then
		slot0.animationFunc = slot1
	end
end

function slot0.ClickRoom(slot0, slot1, slot2)
	slot0.selIndex = slot2

	if slot1 then
		if DormData:GetCurrectSceneID() == slot1 then
			JumpTools.OpenPageByJump("/dorm")

			return
		end

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
			DormAction:CheckToEnterDormScene(slot1)
		elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			if DormitoryData:GetPrivateDormRoomState(slot1) == DormEnum.DormRoomUseState.Unlock then
				JumpTools.OpenPageByJump("dormUnLockRoomConfirmView", {
					roomID = slot1
				})
			elseif slot4 == DormEnum.DormRoomUseState.HadPlace then
				DormAction:CheckToEnterDormScene(slot1)
			end
		end
	else
		slot0.unLockRoomID = DormitoryData:GetUnlockRoomNum() + DormConst.PUBLIC_DORM_ID + 1
		slot3 = slot2 + DormConst.DORM_POS_ID_OFFSET + (slot0.floor - 1) * DormConst.DORM_FLOOR_ROOM_NUM

		if BackHomeCfg[slot0.unLockRoomID].unlock_cost[1] and slot0.unLockRoomID then
			slot0:Go("popNeedCostItemView", {
				costId = slot4[1],
				costCount = slot4[2],
				itemId = slot4[1],
				popCostCallBack = handler(slot0, slot0.PopCostCallBack),
				text1 = GetTips("DORM_UNLOCK_COST_TIPS1"),
				text2 = GetTips("DORM_UNLOCK_COST_TIPS2")
			})
		else
			DormAction:UnLockDormArchitecture(slot0.unLockRoomID, slot3)

			slot0.unLockRoomID = nil
		end
	end
end

function slot0.PopCostCallBack(slot0)
	slot1 = BackHomeCfg[slot0.unLockRoomID].unlock_cost[1]
	slot0.unLockRoomID = nil

	if ItemTools.getItemNum(slot1[1]) < slot1[2] then
		ShowTips(GetTips("DORM_UNLOCK_ITEM_NOT_ENOUGH"))

		return
	end

	slot4 = slot0.selIndex + DormConst.DORM_POS_ID_OFFSET + (slot0.floor - 1) * DormConst.DORM_FLOOR_ROOM_NUM

	if DormitoryData:GetUnlockRoomNum() + DormConst.PUBLIC_DORM_ID + 1 then
		DormAction:UnLockDormArchitecture(slot3, slot4)
	end
end

function slot0.RefreshRoomState(slot0, slot1, slot2)
	if slot1 < 1 or DormConst.DORM_FLOOR_ROOM_NUM < slot1 then
		return
	end

	slot3 = slot0:GetItemByIndex(slot1)
	slot5 = DormitoryData:GetPrivateDormRoomState(slot3.roomID)

	if slot3 then
		slot3.heroIconController:SetSelectedState("false")
		slot3.roomDetailController:SetSelectedState("false")

		if slot5 == DormEnum.DormRoomUseState.Lock then
			slot3.roomStateController:SetSelectedState("lock")
		elseif slot5 == DormEnum.DormRoomUseState.Unlock then
			slot3.roomStateController:SetSelectedState("unlock")

			if slot2 and slot3.animation then
				slot3.animation:Play()
			end
		elseif slot5 == DormEnum.DormRoomUseState.HadPlace then
			slot3.roomStateController:SetSelectedState("normal")

			if DormitoryData:GetDormSceneData(slot4).archiveIDList and #slot6 > 0 then
				slot7 = slot6[1]

				slot3.roomDetailController:SetSelectedState("true")
				slot3.detail:RefreshUI(slot7, DormitoryData:GetDormExp(slot4), DormitoryData:GetDormLevel(slot4))

				if DormData:GetHeroInfoList()[slot7] and slot4 == slot8:GetCurRoomID() then
					slot3.heroIconController:SetSelectedState("true")

					if slot8:GetHeroId() then
						slot3.roomIcon.sprite = HeroTools.GetBackHomeFullModelSprite(slot12)
					else
						print("角色id为空")
					end
				end
			end
		end
	end
end

function slot0.indexHeroItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.heroList[slot1])
end

function slot0.RefreshPublicRoomHeroList(slot0)
	slot0.heroList = {}

	for slot6, slot7 in ipairs(DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID).archiveIDList) do
		table.insert(slot0.heroList, DormData:GetHeroInfo(slot7):GetHeroId())
	end

	slot0.publicHeroScroll:StartScroll(#slot0.heroList)

	if #slot0.heroList == 0 then
		slot0.emptyController:SetSelectedState("false")
	end
end

function slot0.Dispose(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	if slot0.publicHeroScroll then
		slot0.publicHeroScroll:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
