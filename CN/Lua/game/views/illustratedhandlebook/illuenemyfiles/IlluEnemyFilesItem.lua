slot0 = class("IlluEnemyFilesItem", ReduxView)

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

function slot0.RefreshUI(slot0, slot1)
	slot0.ID_ = slot1.id
	slot0.nameText_.text = slot1.name
	slot0.have_ = IllustratedData:GetEnemyInfo()[slot0.ID_]

	if slot0.have_ then
		slot0.controller_:SetSelectedState("1")

		slot0.isView_ = IllustratedData:GetIsView(slot0.ID_, CollectConst.ENEMY)

		manager.redPoint:SetRedPointIndependent(slot0.transform_, slot0.isView_ == 0)
	else
		slot0.controller_:SetSelectedState("0")
		manager.redPoint:SetRedPointIndependent(slot0.transform_, false)
	end

	slot0.iconImg_.sprite = getSpriteWithoutAtlas(string.format("Textures/Illustrate/boss/%s", slot1.id))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		if uv0.have_ then
			if uv0.isView_ == 0 then
				IllustratedAction.ViewIllustration(uv0.ID_, CollectConst.ENEMY)
			end

			uv0:Go("/illuEnemyFileDetail", {
				id = uv0.ID_
			})
		else
			ShowTips("COLLECT_MANSTER_INFO_UNLOCK_FAILED")
		end
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
