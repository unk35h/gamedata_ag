slot0 = class("ChatShieldItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot0:FindGo("ScrollView/Viewport/Content/wordItem", slot1.transform), slot0:FindGo("ScrollView/Viewport/Content", slot1.transform).transform)
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:SetViewProp("itemIndex", slot2)
	slot0:CreateSelector()
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.itemModel_ = slot0.selector_.compute(gameStore.getState(), slot0:GetViewProp("itemIndex"))

	slot0:RefreshItem(slot0.itemModel_.word)
end

function slot0.OnEnter(slot0)
	slot0.unsubscribeFun = gameStore.subscribe(function (slot0)
		uv0:OnSubscribe()
	end)
end

function slot0.OnExit(slot0)
	slot0.unsubscribeFun()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.closeBtn_ = slot0:FindCom(typeof(Button), "closeBtn")
	slot0.context_ = slot0:FindCom(typeof(Text), "Text")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		slot1 = ActionCreators.DeleteShieldWord(uv0.itemModel_.word)

		slot1:next(function (slot0)
			if slot0.result == 0 then
				ActionCreators.DeleteShieldWordSuccess(uv0:GetViewProp("itemIndex"))
			else
				ShowTips(slot0.result)
			end
		end, function (slot0)
			print(slot0)
		end)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.closeBtn_.onClick:RemoveAllListeners()
end

function slot0.CreateSelector(slot0)
	slot0.selector_ = createStructuredSelector({
		word = function (slot0, slot1)
			return slot0.chat.shieldWordList[slot1]
		end
	})
end

function slot0.OnSubscribe(slot0)
	if slot0.selector_.compute(gameStore.getState(), slot0:GetViewProp("itemIndex")).word ~= slot0.itemModel_.word then
		slot0.itemModel_.word = slot1.word

		slot0:RefreshItem(slot0.itemModel_.word)
	end
end

function slot0.RefreshItem(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot0.context_.text = shortenString(slot1, 15)
end

return slot0
