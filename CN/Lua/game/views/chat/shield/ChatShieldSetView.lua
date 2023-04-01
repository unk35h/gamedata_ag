slot0 = class("ChatShieldSetView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Chat/ChatShieldSetUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0:CreateSelector()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0.wordItems_ = {}
	slot0.shieldSetModel_ = slot0.selector_.compute(gameStore.getState())

	slot0:RefreshItem(slot0.shieldSetModel_.wordCnt)

	slot0.unsubscribeFun = gameStore.subscribe(function (slot0)
		uv0:OnSubscribe()
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllItems()
	slot0.unsubscribeFun()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	slot0:RemoveAllItems()
	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.closeBtn_ = slot0:FindCom(typeof(Button), "closeBtn")
	slot0.addBtn_ = slot0:FindCom(typeof(Button), "addBtn")
	slot0.inputField_ = slot0:FindCom("InputField", "InputField")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		if uv0.inputField_.text == "" then
			return ShowTips("INPUT_CHAT_CONTENT")
		end

		slot1 = ActionCreators.AddShieldWord(slot0)

		slot1:next(function (slot0)
			if slot0.result == 0 then
				ActionCreators.AddShieldWordSuccess(uv0)
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
	slot0.addBtn_.onClick:RemoveAllListeners()
end

function slot0.CreateSelector(slot0)
	slot0.selector_ = createStructuredSelector({
		wordCnt = function (slot0)
			return #slot0.chat.shieldWordList
		end
	})
end

function slot0.OnSubscribe(slot0)
	if slot0.selector_.compute(gameStore.getState()).wordCnt ~= slot0.shieldSetModel_.wordCnt then
		slot0:RefreshItem(slot1.wordCnt)

		slot0.shieldSetModel_.wordCnt = slot1.wordCnt
	end
end

function slot0.RefreshItem(slot0, slot1)
	for slot5 = #slot0.wordItems_, slot1 + 1, -1 do
		slot0.wordItems_[slot5]:OnExit()
		slot0.wordItems_[slot5]:Dispose()
		table.remove(slot0.wordItems_, slot5)
	end

	for slot5 = #slot0.wordItems_ + 1, slot1 do
		slot6 = ChatShieldItemView.New(slot0.gameObject_, slot5)

		slot6:OnEnter()
		table.insert(slot0.wordItems_, slot6)
	end
end

function slot0.RemoveAllItems(slot0)
	for slot4 = #slot0.wordItems_, 1, -1 do
		slot0.wordItems_[slot4]:OnExit()
		slot0.wordItems_[slot4]:Dispose()
		table.remove(slot0.wordItems_, slot4)
	end
end

return slot0
