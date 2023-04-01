slot0 = class("CommonItemFreestyle", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:UpdateView()
end

function slot0.RefreshData(slot0, slot1)
	slot0.info_ = slot1

	if slot1 == nil then
		return
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.clickBtn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.info_)
		end
	end)
end

function slot0.UpdateView(slot0)
	if slot0.info_ == nil then
		return
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	uv0.super.Dispose(slot0)

	slot0.disposed_ = true
end

return slot0
