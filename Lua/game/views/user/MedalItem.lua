slot0 = class("MedalItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.usedController_ = ControllerUtil.GetController(slot0.transform_, "used")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.Btn_, nil, function ()
		ShowPopItem(POP_SOURCE_DES_ITEM, {
			uv0.info_.id
		})
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshItem(slot0, slot1)
	slot0.info_ = slot1
	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.info_.id)
	slot0.unlock_ = slot0.info_.unlock
	slot0.text_.text = ItemCfg[slot0.info_.id].name

	slot0:RefreshState()
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.onClickFunc_ = slot1
end

function slot0.RefreshState(slot0)
	slot0.lockController_:SetSelectedState(slot0.unlock_ == 0 and "lock" or "default")
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.onClickFunc_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
