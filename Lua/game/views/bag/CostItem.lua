slot0 = class("CostItem", ReduxView)
slot1 = import("game.const.ItemConst")
slot2 = import("game.tools.MailTools")

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0.icon_ = slot0:FindCom(typeof(Image), "main/icon")
	slot0.name_ = slot0:FindCom(typeof(Text), "main/name")
	slot0.num_ = slot0:FindCom(typeof(Text), "main/num")

	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0.name_.text = ItemCfg[slot1.id].name
		slot0.icon_.sprite = ItemTools.getItemSprite(slot1.id)

		if slot1.total < slot1.need then
			slot0.num_.text = string.format("<color=#EE384F>%d</color>/%d", slot1.total, slot1.need)
		else
			slot0.num_.text = string.format("%d/%d", slot1.total, slot1.need)
		end
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.clickFunc = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.info_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

return slot0
