slot0 = class("IlluWorldIViewItem", ReduxView)

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

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.info_ = slot2
	slot0.isFirst_ = slot0.info_.isFirst
	slot0.id_ = slot0.info_.id
	slot0.nameText_.text = CollectWordCfg[slot0.id_].name

	slot0:ShowSelect2(slot2.select)

	slot0.isRead_ = IllustratedData:GetInfoIsView(CollectConst.WORLDVIEW, slot0.id_)

	if slot0.isFirst_ then
		manager.redPoint:SetRedPointIndependent(slot0.transform_, false)

		if slot0.isRead_ == 0 then
			IllustratedAction.ViewIllustration(slot0.id_, CollectConst.WORLDVIEW)
		end

		slot0.info_.isFirst = false
	else
		manager.redPoint:SetRedPointIndependent(slot0.transform_, slot0.isRead_ == 0)
	end
end

function slot0.ShowSelect(slot0, slot1)
	slot0.info_.select = slot1

	if slot1 then
		slot0.controller_:SetSelectedState("sel")

		if slot0.isRead_ == 0 then
			IllustratedAction.ViewIllustration(slot0.id_, CollectConst.WORLDVIEW)
		end

		manager.redPoint:SetRedPointIndependent(slot0.transform_, false)
	else
		slot0.controller_:SetSelectedState("notSel")
	end
end

function slot0.ShowSelect2(slot0, slot1)
	slot0.info_.select = slot1

	if slot1 then
		slot0.controller_:SetSelectedState("sel")
	else
		slot0.controller_:SetSelectedState("notSel")
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		if uv0.func_ then
			uv0.func_(uv0.index_)
		end
	end)
end

function slot0.RegisterBtnListener(slot0, slot1)
	slot0.func_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
