slot0 = class("DormAvatar", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.sceneId = slot2
	slot0.heroId = slot1

	slot0:Init(slot1)
end

function slot0.Init(slot0, slot1)
	slot2 = HeroTools.HeroUsingSkinInfo(slot1).id
	slot3 = SkinCfg[slot2]
	slot4 = manager.resourcePool:Get("CharDorm/" .. slot1 .. "ui_tpose", ASSET_TYPE.TPOSE)

	HeroTools.SetHeroModelWeaponActivity(slot4.transform, false)

	slot0.animator_ = slot0:FindCom(typeof(Animator), "", slot4.transform)
	slot0.top = slot0:FindTrs("auto_hp_point", slot4.transform)
	slot0.heroModel_ = slot4
	slot0.gameObject_ = Object.Instantiate(Asset.Load("Dorm/DormPlayer"))
	slot0.gameObject_.name = "dormPlayer" .. slot2
	slot0.dormPlayer = slot0.gameObject_:GetComponent(typeof(Dorm.DormPlayer))

	slot0.dormPlayer:Init(slot0.heroModel_.transform, slot0.animator_, slot0.top, handler(slot0, slot0.OnBoardClick))

	slot0.active = true

	slot0:Reset()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0.timer = Timer.New(handler(slot0, slot0.CheckState), 60, -1)

	slot0.timer:Start()
	slot0:CheckState()
end

function slot0.CheckState(slot0)
	if not DormData:GetDormHero(slot0.heroId) then
		return
	end

	if DormTools.getHeroEarn(slot0.heroId) + slot1:GetEarnings() > 10 then
		SetActive(slot0.dormPlayer.goldBoard.gameObject, true)
	else
		SetActive(slot0.dormPlayer.goldBoard.gameObject, false)
	end

	if slot1:GetMood() <= 0 then
		SetActive(slot0.dormPlayer.moodBoard.gameObject, true)
	else
		SetActive(slot0.dormPlayer.moodBoard.gameObject, false)
	end
end

function slot0.Reset(slot0)
	slot0.heroModel_.transform.localScale = Vector3(1, 1, 1)
end

function slot0.GetSceneId(slot0)
	return slot0.sceneId
end

function slot0.SetSceneId(slot0, slot1)
	if slot1 == slot0.sceneId then
		return
	end

	slot0.sceneId = slot1

	slot0:Reset()
end

function slot0.SetActive(slot0, slot1)
	if slot1 == slot0.active then
		return
	end

	slot0.active = slot1

	SetActive(slot0.heroModel_, slot0.active)
	SetActive(slot0.gameObject_, slot0.active)
end

function slot0.OnBoardClick(slot0)
	DormAction.QueryHeroEarnings({
		slot0.heroId
	})
end

function slot0.Dispose(slot0)
	slot0.active = false

	if slot0.heroModel_ then
		manager.resourcePool:DestroyOrReturn(slot0.heroModel_, ASSET_TYPE.TPOSE)

		slot0.heroModel_ = nil
	end

	if slot0.dormPlayer then
		slot0.dormPlayer:Dispose()
	end

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	if not isNil(slot0.gameObject_) then
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
	end
end

return slot0
