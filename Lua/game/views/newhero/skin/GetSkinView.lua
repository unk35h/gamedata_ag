slot0 = class("GetSkinView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Obtain/Skin/SkinAUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0:GetTimeLineEndTime() <= uv0.playableDirector_.time then
			uv0:Back()
			uv0.callback_()
		else
			uv0.playableDirector_.time = uv0:GetTimeLineEndTime()
		end
	end)
end

function slot0.GetTimeLineEndTime(slot0)
	return 6.27
end

function slot0.OnEnter(slot0)
	slot0.skinID_ = slot0.params_.skinID
	slot0.portrait_.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. SkinCfg[slot0.skinID_].picture_id)
	slot0.name_.text = ItemCfg[slot0.skinID_].name

	slot0.playableDirector_:Evaluate()
	slot0.playableDirector_:Play()

	slot0.callback_ = slot0.params_.callback

	SetActive(slot0.gameObject_, true)
end

function slot0.OnExit(slot0)
	if slot0:GetTimeLineEndTime() > slot0.playableDirector_.time then
		slot0.playableDirector_.time = slot0.playableDirector_.duration
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
