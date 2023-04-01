slot0 = class("EnchantmentToggle", ReduxView)
slot1 = {
	"lock",
	"unLock",
	"finish"
}
slot2 = {
	"select",
	"general"
}

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1

	SetActive(slot0.gameObject_, true)

	slot0.transform_ = slot0.gameObject_.transform
	slot0.difficulty_ = slot2

	slot0:CreateSelector()
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0.toggle_ = slot0:FindCom(typeof(Toggle), "")
	slot0.label_ = slot0:FindCom(typeof(Text), "Label")
	slot0.label_.text = GetTips("HARDLEVEL") .. slot0.difficulty_
end

function slot0.OnEnter(slot0)
	slot0.unsubscribeFun = gameStore.subscribe(function (slot0)
		uv0:OnSubscribe()
	end)
end

function slot0.OnExit(slot0)
	slot0.unsubscribeFun()
end

function slot0.ChangeToggle(slot0, slot1)
end

function slot0.OnSubscribe(slot0)
end

function slot0.CreateSelector(slot0)
end

function slot0.AddListener(slot0, slot1)
	slot0:AddToggleListener(slot0.toggle_, slot1)
end

function slot0.ChangeSelect(slot0, slot1)
	if slot1 then
		slot0.toggle_.isOn = true
	else
		slot0.toggle_.isOn = false
	end
end

function slot0.ShowNotice(slot0, slot1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil

	slot0.unsubscribeFun()
	uv0.super.Dispose(slot0)
end

return slot0
