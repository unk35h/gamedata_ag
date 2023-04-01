slot0 = class("NewHeroPageBase", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
end

function slot0.AddUIListener(slot0)
end

function slot0.SetHeroInfo(slot0, slot1)
end

function slot0.PlayEnterAni(slot0)
	slot0.playableDirector_ = slot0.playableDirector_ or slot0:FindCom(typeof(PlayableDirector), "panel")

	if slot0.playableDirector_ then
		slot0.playableDirector_.time = 0

		slot0.playableDirector_:Play()
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.handler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
