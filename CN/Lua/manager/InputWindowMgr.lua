slot0 = class("InputWindowMgr", import("game.extend.BaseView"))

function slot0.Ctor(slot0)
	slot0:OnCtor()
end

function slot0.OnCtor(slot0)
	print("Input Window Mgr")
end

function slot0.InitUI(slot0)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Common/MessageBox2"), manager.ui.uiMessage.transform)
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, false)

	slot0.title_ = slot0:FindCom(typeof(Text), "bg/topLine/text")
	slot0.titleEn_ = slot0:FindCom(typeof(Text), "bg/topLine/textEn")
	slot0.contentGo_ = slot0:FindGo("bg/contentText")
	slot0.content_ = slot0:FindCom(typeof(Text), "bg/contentText")
	slot0.inputGo_ = slot0:FindGo("bg/InputField")
	slot0.input_ = slot0:FindCom("InputField", "bg/InputField")
	slot0.placeHolder_ = slot0:FindCom(typeof(Text), "bg/InputField/Placeholder")
	slot0.btnCancel_ = slot0:FindGo("bg/btnPanel/btn_cancel")
	slot0.btnConfirm_ = slot0:FindGo("bg/btnPanel/btn_ok")
	slot0.closeBtn_ = slot0:FindCom("bg/closeBtn")
	slot0.bgCom_ = slot0:FindCom(typeof(Image), "mask")

	slot0:AddBtnListener("mask", nil, function ()
		if uv0.cancelCallBack_ then
			uv0.cancelCallBack_()
		end

		uv0:Show(false)
	end)
	slot0:AddBtnListener("bg/btnPanel/btn_cancel", nil, function ()
		if uv0.cancelCallBack_ then
			uv0.cancelCallBack_()
		end

		uv0:Show(false)
	end)
	slot0:AddBtnListener("bg/btnPanel/btn_ok", nil, function ()
		if uv0.confirmCallBack_ then
			uv0.confirmCallBack_(uv0.input_.text)
		end
	end)
	slot0:AddBtnListener("bg/closeBtn", nil, function ()
		if uv0.cancelCallBack_ then
			uv0.cancelCallBack_()
		end

		uv0:Show(false)
	end)
end

function slot0.ShowInput(slot0, slot1)
	if slot0.isShow_ then
		return
	end

	if slot0.gameObject_ == nil then
		slot0:InitUI()
	end

	slot0:Show(true)

	slot0.bgCom_.enabled = false
	slot0.input_.text = ""
	slot0.cancelCallBack_ = slot1.cancelCallBack
	slot0.confirmCallBack_ = slot1.confirmCallBack
	slot0.title_.text = slot1.title == nil and "info" or slot1.title
	slot0.titleEn_.text = slot1.titleEn == nil and "info" or slot1.titleEn
	slot0.placeHolder_.text = slot1.placeHolder == nil and "请输入。。。" or slot1.placeHolder
	slot0.input_.characterLimit = slot1.limit == nil and 8 or slot1.limit

	SetActive(slot0.inputGo_, true)
	SetActive(slot0.contentGo_, false)
	SetActive(slot0.btnCancel_, slot1.cancelCallBack ~= nil)
end

function slot0.ShowMsg(slot0, slot1)
	if slot0.isShow_ then
		return
	end

	if slot0.gameObject_ == nil then
		slot0:InitUI()
	end

	slot0:Show(true)

	slot0.bgCom_.enabled = false
	slot0.cancelCallBack_ = slot1.cancelCallBack or slot1.confirmCallBack_
	slot0.confirmCallBack_ = slot1.confirmCallBack
	slot0.title_.text = slot1.title == nil and "info" or slot1.title
	slot0.titleEn_.text = slot1.titleEn == nil and "info" or slot1.titleEn
	slot0.content_.text = slot1.content

	SetActive(slot0.inputGo_, false)
	SetActive(slot0.contentGo_, true)
	SetActive(slot0.btnCancel_, slot1.cancelCallBack ~= nil)
end

function slot0.Show(slot0, slot1)
	if slot0.isShow_ == slot1 then
		return
	end

	slot0.isShow_ = slot1

	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.gameObject_ then
		Object.Destroy(slot0.gameObject_)
	end

	uv0.super.Dispose(slot0)
end

return slot0
