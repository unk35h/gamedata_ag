slot0 = class("FurnitureItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.startController = ControllerUtil.GetController(slot0.transform_, "itembglevel")
	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.interactController = ControllerUtil.GetController(slot0.transform_, "interact")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.limitController = ControllerUtil.GetController(slot0.transform_, "upperlimit")
	slot0.furNumController = ControllerUtil.GetController(slot0.transform_, "furNum")
	slot0.screenController = ControllerUtil.GetController(slot0.transform_, "screening")

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.onClickCom_ = slot0:FindCom("OnClickDownListener")
	slot1 = slot0.onClickCom_.onValueChanged

	slot1:AddListener(function ()
		if uv0.downFunc then
			uv0.downFunc(uv0.id, uv0.index, uv0.furType)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot3 == DormEnum.FurItemType.Edit then
		slot0.id = slot1.furID
		slot0.furType = slot1.type
	elseif slot3 == DormEnum.FurItemType.Gift then
		slot0.id = slot1
	end

	slot0.type = slot3
	slot0.index = slot5

	if ItemCfg[slot0.id] then
		slot0.furName.text = slot6.name
		slot0.level = ItemCfg[slot0.id].rare
		slot0.iconImg_.sprite = ItemTools.getItemSprite(slot0.id)
	else
		print("家具" .. slot0.id .. "在item表内未找到")
	end

	if BackHomeFurniture[slot0.id].interact_max and BackHomeFurniture[slot0.id].interact_max > 0 then
		slot0.interactController:SetSelectedState("true")
	else
		slot0.interactController:SetSelectedState("false")
	end

	slot0.selectController:SetSelectedState("normal")

	if slot3 == DormEnum.FurItemType.Edit then
		slot7 = slot1.type

		slot0.stateController:SetSelectedState("edit")

		slot8 = DormData:GetCurrectSceneID()

		if slot6 then
			if DormTools:JudgeFurType(slot0.id) then
				slot0.furNumController:SetSelectedState("false")

				if slot7 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
					slot0.screenController:SetSelectedState("CanPlace")
				elseif slot7 == DormConst.DORM_FUR_EDITVIEW_TYPE.HadPlace then
					slot0.screenController:SetSelectedState("HadPlace")
				elseif slot7 == DormConst.DORM_FUR_EDITVIEW_TYPE.OtherHadPlace then
					slot0.screenController:SetSelectedState("OtherHadPlace")
				elseif slot7 == DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented then
					slot0.screenController:SetSelectedState("NotPresented")
				end
			else
				slot0.furNumController:SetSelectedState("true")

				if slot7 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
					slot0.totalNum.text = DormitoryData:GetCanUseFurNumInRoom(slot8, slot0.id)

					slot0.limitController:SetSelectedState("normal")
					slot0.screenController:SetSelectedState("CanPlace")

					if slot2 then
						if slot0.id == slot2 then
							slot0.selectController:SetSelectedState("select")
						else
							slot0.selectController:SetSelectedState("normal")
						end
					end
				elseif slot7 == DormConst.DORM_FUR_EDITVIEW_TYPE.OtherHadPlace then
					slot0.totalNum.text = DormData:GetRoomCanPlaceFurMaxNum(slot8, slot0.id) - DormitoryData:GetCanUseFurNumInRoom(slot8, slot0.id) - DormitoryData:GetHasPlaceFurInfoByRoom(slot8, slot0.id) - DormitoryData:GetCacheFurNum(slot0.id)

					slot0.screenController:SetSelectedState("OtherHadPlace")
				elseif slot7 == DormConst.DORM_FUR_EDITVIEW_TYPE.HadPlace then
					slot0.totalNum.text = DormitoryData:GetHasPlaceFurInfoByRoom(slot8, slot0.id) + DormitoryData:GetCacheFurNum(slot0.id)

					slot0.screenController:SetSelectedState("HadPlace")
				elseif slot7 == DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented then
					slot9 = DormData:GetFurNumInfo(slot0.id)

					if BackHomeCfg[slot8].type == DormConst.BACKHOME_TYPE.PublicDorm then
						slot0.totalNum.text = slot9.num - slot9.give_num
					elseif BackHomeCfg[slot8].type == DormConst.BACKHOME_TYPE.PrivateDorm then
						slot0.totalNum.text = DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(slot8)[1]):GetCanGiftNum(slot0.id)
					end

					slot0.screenController:SetSelectedState("NotPresented")
				end
			end
		end
	elseif slot3 == DormEnum.FurItemType.Gift then
		slot0.stateController:SetSelectedState("gift")

		slot0.comfortNum.text = BackHomeFurniture[slot0.id].dorm_exp or 0
		slot9 = DormData:GetHeroInfo(slot4)

		if not DormData:GetDormSceneData(DormitoryData:GetDormIDViaArchive(slot4)).give_furnitures[slot0.id] then
			slot8.give_furnitures[slot0.id] = 0
		end

		slot10 = DormData:GetFurNumInfo(slot0.id)

		if slot6 then
			slot0.totalNum.text = slot10.num - slot10.give_num
		end

		if slot9:GetCanGiftNum(slot0.id) <= 0 then
			slot0.limitController:SetSelectedState("gray")

			return
		else
			slot0.limitController:SetSelectedState("normal")
		end

		if slot2 then
			slot0.selID = slot2

			if slot0.id == slot0.selID then
				slot0.selectController:SetSelectedState("select_send")

				slot0.placeNum.text = slot8.give_furnitures[slot0.id]
			else
				slot0.selectController:SetSelectedState("normal")
			end
		end
	end

	slot0.startController:SetSelectedState(slot0.level)
end

function slot0.OnPointerDown(slot0, slot1)
	slot0.downFunc = slot1
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.onClickCom_.onValueChanged:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
