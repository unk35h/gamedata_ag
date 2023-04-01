slot0 = class("StoryListView", ReduxView)

function slot0.UIName(slot0)
	return "UI/StoryPreviewListUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.InitUI(slot0)
	slot0.list_ = slot0:FindTrs("list/Grid")
	slot0.item_ = Asset.Load("UI/StoryPreviewItem")
	slot0.items_ = {}

	for slot5, slot6 in ipairs(keyPairsSort(StoryCfg)) do
		slot0.items_[slot6] = StoryItem.New(slot0, Object.Instantiate(slot0.item_, slot0.list_), StoryCfg[slot6])
	end

	slot0.input_ = slot0:FindCom(typeof(InputField), "InputField")
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.input_.onEndEdit

	slot1:AddListener(function ()
		slot0 = uv0.input_.text

		for slot4, slot5 in pairs(uv0.items_) do
			slot5:Show(string.gmatch(slot4, slot0)() ~= nil)
		end
	end)
end

function slot0.Render(slot0)
end

function slot0.RefreshUI(slot0)
end

function slot0.MoveList(slot0, slot1)
	slot2 = slot0.list_.transform.localPosition
	slot0.list_.transform.localPosition = Vector3(slot2.x, math.floor((slot2.y + slot1) / 440) * 440 + 10, slot2.z)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in pairs(slot0.items_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
