slot0 = singletonClass("ReduxFactory")
slot1 = 10

function slot0.Ctor(slot0)
	slot0.reduxViewDic_ = {}
	slot0.cachedReduxViewList_ = {}
	slot0.reduxViewList_ = {}
	slot0.isCheckMemoryLeak_ = LuaForUtil.IsCheckLuaMemory()
end

function slot0.CacheReduxView(slot0, slot1)
	slot3 = table.indexof(slot0.cachedReduxViewList_, slot1)

	if true and slot1:Cacheable() and not slot3 then
		slot0.reduxViewDic_[slot1.routeName_] = slot1

		table.insert(slot0.cachedReduxViewList_, slot1)

		if slot1.gameObject_ then
			SetActive(slot1.gameObject_, false)
		end
	else
		slot0:RemoveView(slot1)
	end

	slot0:CheckReduxViewQueueFull()
end

function slot0.RemoveView(slot0, slot1)
	if table.indexof(slot0.cachedReduxViewList_, slot1) then
		slot0:RemoveViewAt(slot2)
	else
		slot1:OnUnload()
	end
end

function slot0.RemoveViewAt(slot0, slot1)
	slot2 = slot0.cachedReduxViewList_[slot1]

	slot2:OnUnload()
	table.remove(slot0.cachedReduxViewList_, slot1)
	slot0:PrintViewList("RemoveViewAt, ")

	if slot0.reduxViewDic_[slot2.routeName_] then
		slot0.reduxViewDic_[slot3] = nil
	end

	if table.indexof(slot0.reduxViewList_, slot2) then
		table.remove(slot0.reduxViewList_, slot4)
	end
end

function slot0.GetReduxView(slot0, slot1, slot2)
	slot4 = true

	if slot0.reduxViewDic_[slot1] ~= nil then
		slot4 = false

		if table.indexof(slot0.reduxViewList_, slot3) then
			table.remove(slot0.reduxViewList_, slot5)
			table.insert(slot0.reduxViewList_, slot3)
		end

		slot0:PrintViewList()

		if slot3.gameObject_ then
			SetActive(slot3.gameObject_, true)
			slot3.gameObject_.transform:SetAsLastSibling()
		end

		slot0.reduxViewDic_[slot1] = nil

		if table.indexof(slot0.cachedReduxViewList_, slot3) then
			table.remove(slot0.cachedReduxViewList_, slot6)
		end
	else
		table.insert(slot0.reduxViewList_, slot2.component.New())
		slot0:PrintViewList()
	end

	return slot3, slot4
end

function slot0.CheckReduxViewQueueFull(slot0)
	while uv0 < #slot0.cachedReduxViewList_ do
		slot0:RemoveViewAt(1)
	end
end

function slot0.ClearCacheViews(slot0)
	for slot4, slot5 in pairs(slot0.reduxViewDic_) do
		slot5:OnUnload()
	end

	slot0.reduxViewDic_ = {}
	slot0.reduxViewList_ = {}
	slot0.cachedReduxViewList_ = {}
end

function slot0.OnMainHomeViewTop(slot0)
	for slot4, slot5 in pairs(slot0.reduxViewDic_) do
		slot5:OnMainHomeViewTop()
	end
end

function slot0.OnManagedObjCtor(slot0, slot1)
	if not slot0.isCheckMemoryLeak_ then
		return
	end

	if not slot0.existReduxViewDic_ then
		slot0.existReduxViewDic_ = {}
		slot0.existReduxViewList_ = {}
	end

	table.insert(slot0.existReduxViewList_, slot1)

	slot0.existReduxViewDic_[tostring(slot1)] = slot1
end

function slot0.OnManagedObjDisposed(slot0, slot1)
	if not slot0.isCheckMemoryLeak_ then
		return
	end

	if not slot0.existReduxViewDic_ then
		slot0.existReduxViewDic_ = {}
		slot0.existReduxViewList_ = {}
	end

	if slot0.existReduxViewDic_[tostring(slot1)] then
		slot0.existReduxViewDic_[slot2] = nil
	end

	if table.indexof(slot0.existReduxViewList_, slot1) then
		table.remove(slot0.existReduxViewList_, slot3)
	end
end

function slot0.PrintExistingObjectInfo(slot0)
	if not slot0.isCheckMemoryLeak_ then
		return
	end

	slot1 = "#ff0000"

	if slot0.existReduxViewList_ ~= nil and #slot0.existReduxViewList_ > 0 then
		slot6 = " : "
		slot2 = "<color=" .. slot1 .. ">UI系统结束时，未被Dispose的ReduxView数量：" .. #slot0.existReduxViewList_ .. slot6

		for slot6 = 1, #slot0.existReduxViewList_ do
			slot2 = slot2 .. slot0.existReduxViewList_[slot6].class.__cname .. (slot6 == #slot0.existReduxViewList_ and "" or ",")
		end

		slot2 = slot2 .. "请优先按规范销毁对象</color>"
	else
		print("<color=#00ff00>对象已清理完全</color>")
	end
end

function slot0.PrintViewList(slot0, slot1)
end

return slot0
