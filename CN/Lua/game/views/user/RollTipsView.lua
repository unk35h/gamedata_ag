slot0 = class("RollTipsView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.bgimage_.sprite = AssetEx.LoadSprite("Textures/Common/bg_funeng_details", true)
	slot0.btnimage_.sprite = AssetEx.LoadSprite("Textures/Common/Popup_common_b", true)
	slot0.iconiamge_.sprite = AssetEx.LoadSprite("Textures/Common/icon_ShutDown", true)

	slot0:AddUIListeners()
end

function slot0.Play(slot0, slot1)
	slot0.showString_ = slot1
	slot0.showtext_.text = slot0.showString_
	slot0.texttrans_.sizeDelta = Vector2.New(ExStringCount(slot0.showtext_.text) * slot0.showtext_.fontSize / 2, slot0.texttrans_.rect.height)
	slot0.texttrans_.localPosition = Vector3.New(0, 0, 0)

	if slot0.timer_ == nil then
		slot0.timer_ = FrameTimer.New(function ()
			if LuaExchangeHelper.GetSceneIsHanding() then
				return
			elseif -uv0.texttrans_.localPosition.x < uv0.contenttrans_.rect.width + uv0.texttrans_.rect.width then
				uv0.texttrans_.localPosition = Vector3.New(uv0.texttrans_.localPosition.x + -100 * Time.deltaTime, 0, 0)
			else
				uv0:StopTimer()
				SetActive(uv0.gameObject_, false)
			end
		end, 1, -1)

		slot0.timer_:Start()
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.closebtn_, nil, function ()
		uv0:StopTimer()
		SetActive(uv0.gameObject_, false)
	end)
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	slot0.super.Dispose(slot0)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
