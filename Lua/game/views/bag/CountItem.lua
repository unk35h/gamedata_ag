slot0 = class("CountItem", ReduxView)
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
	slot0.icon_ = slot0:FindCom(typeof(Image), "info/icon")
	slot0.name_ = slot0:FindCom(typeof(Text), "info/name")
	slot0.num_ = slot0:FindCom(typeof(Text), "info/num")
	slot0.select_ = slot0:FindGo("info/select")
	slot0.noSelect_ = slot0:FindGo("info/noselect")
	slot0.selectNum_ = slot0:FindCom(typeof(Text), "info/select/selectnum")
	slot0.numIcon_ = slot0:FindCom(typeof(Image), "info/numicon")
	slot1 = slot0:GetOrAddComponent(slot0.gameObject_, typeof(EventTriggerListener))

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function ()
		if uv0.startAddFunc_ then
			uv0.startAddFunc_()
		end
	end))
	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function ()
		if uv0.finishAddFunc_ then
			uv0.finishAddFunc_()
		end
	end))
	slot0:SetListener(slot1)

	slot2 = slot0:GetOrAddComponent(slot0:FindGo("info/select/btn_del"), typeof(EventTriggerListener))

	slot2:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function ()
		if uv0.startSubFunc_ then
			uv0.startSubFunc_()
		end
	end))
	slot2:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function ()
		if uv0.finishSubFunc_ then
			uv0.finishSubFunc_()
		end
	end))
	slot0:SetListener(ls1)
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0.icon_.sprite = ItemTools.getItemSprite(slot1.id)
		slot0.name_.text = ItemCfg[slot1.id].name
		slot0.num_.text = slot1.number + slot1.use

		if slot1.use > 0 then
			SetActive(slot0.select_, true)
			SetActive(slot0.noSelect_, false)

			slot0.selectNum_.text = slot1.use
			slot0.name_.color = Color.New(0.6796, 0.7568, 0.7618, 0.8)
			slot0.num_.color = Color.New(0.9004, 0.9948, 1, 0.9)
			slot0.numIcon_.sprite = getSprite("Atlas/NewHero", "icon_stock_1")
		else
			SetActive(slot0.select_, false)
			SetActive(slot0.noSelect_, true)

			slot0.name_.color = Color.New(0.1318, 0.1107, 0.0849, 0.9)
			slot0.num_.color = Color.New(0.1318, 0.1107, 0.0849, 0.9)
			slot0.numIcon_.sprite = getSprite("Atlas/NewHero", "icon_stock")
		end
	end
end

function slot0.RegisterFunc(slot0, slot1, slot2, slot3, slot4)
	slot0.startAddFunc_ = slot1
	slot0.finishAddFunc_ = slot2
	slot0.startSubFunc_ = slot3
	slot0.finishSubFunc_ = slot4
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.info_ = nil
	slot0.startAddFunc_ = nil
	slot0.finishAddFunc_ = nil
	slot0.startSubFunc_ = nil
	slot0.finishSubFunc_ = nil
	slot0.isShowUse_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
