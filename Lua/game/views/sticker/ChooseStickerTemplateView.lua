slot0 = class("ChooseStickerTemplateView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/StickerNEW/StickerChooseTemplateUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.scrollList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, StickerTemplateItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.list_[slot1]

	slot2:RefreshUI(slot3, slot0.bgID_)

	if slot3 == slot0.chooseID_ then
		slot2:SetState("use")
	else
		slot2:SetState("change")
	end

	slot2:SetSelected(slot3 == slot0.curID_)
	slot2:RegistClickFunc(function ()
		uv0:SetTemplateID(uv1)
	end)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.changeBtn_, nil, function ()
		uv0.params_.temp.info[uv0.params_.index].viewID = uv0.curID_

		uv0:Back(1, {
			resetSize = true,
			type = 2,
			tempInfo = uv0.params_.temp
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.chooseID_ = slot0.params_.chooseID
	slot0.bgID_ = slot0.params_.temp.stickerBg
	slot0.list_ = StickViewTemplateCfg.all

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.bg_.sprite = getSpriteWithoutAtlas("Textures/Sticker/stickerBtn/Sticker_big_" .. slot0.bgID_)

	slot0:Sortlist()
	slot0:SetTemplateID(slot0.chooseID_)
	slot0.scrollList_:StartScroll(#slot0.list_, table.indexof(slot0.list_, slot0.chooseID_))
end

function slot0.Sortlist(slot0)
	table.sort(slot0.list_, function (slot0, slot1)
		if slot0 == uv0.chooseID_ or slot1 == uv0.chooseID_ then
			return slot0 == uv0.chooseID_
		end

		return slot0 < slot1
	end)
end

function slot0.SetTemplateID(slot0, slot1)
	slot0.curID_ = slot1

	slot0:RefreshInfo()
	slot0.scrollList_:Refresh()
end

function slot0.RefreshInfo(slot0)
	slot0.show_.sprite = getSpriteWithoutAtlas("Textures/Sticker/stickerBtn/Sticker_template_" .. slot0.curID_)

	if slot0.curID_ == slot0.chooseID_ then
		slot0.stateCon_:SetSelectedState("use")
	else
		slot0.stateCon_:SetSelectedState("change")
	end
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		uv0:Back(1, {
			type = 2,
			tempInfo = uv0.params_.temp
		})
	end)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
