slot0 = class("HeroArchivePage", ReduxView)

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
end

function slot0.AddUIListener(slot0)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.heroID_ = slot1
	slot2 = HeroRecordCfg[slot0.heroID_]
	slot0.nameText_.text = slot2.name
	slot0.heightText_.text = slot2.height
	slot0.weightText_.text = slot2.weight
	slot0.birthdayText_.text = slot2.birthday
	slot0.organizationText_.text = slot2.organization
	slot0.likeText_.text = slot2.like
end

function slot0.RegisterInterruptVoice(slot0, slot1)
	slot0.interruptFunc_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
