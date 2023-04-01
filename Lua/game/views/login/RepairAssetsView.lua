slot0 = class("RepairAssetsView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/ResourcesCheckStartUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		if RepairAssetsToLua.HasError() then
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("VERIFY_ASSETS_HAS_ERROR"),
				OkCallback = function ()
					LuaHelper.Quit()
				end
			})
		elseif gameContext:IsOpenRoute("repairAssetsView") then
			JumpTools.Back()
		end
	end)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.SetTitle(slot0, slot1)
	slot0.titleText_.text = slot1
end

function slot0.SetContent(slot0, slot1)
	slot0.contentText_.text = slot1
end

function slot0.SetProgress(slot0, slot1, slot2)
	slot0.progressImg_.fillAmount = slot1
	slot0.progressText_.text = slot2
end

function slot0.OnEnter(slot0)
	RepairAssetsToLua.VerifyAssets()
	slot0:SetTitle(GetTips("VERIFY_ASSETS_PROCESSING_TITLE"))
	slot0:SetContent(GetTips("VERIFY_ASSETS_PROCESSING_CONTENT"))
	slot0:SetProgress(0, "")

	if slot0.updateTimer ~= nil then
		slot0.updateTimer:Stop()

		slot0.updateTimer = nil
	end

	if slot0.updateTimer == nil then
		slot0.updateTimer = Timer.New(function ()
			slot0 = RepairAssetsToLua.GetCurrentVerifyIndex()
			slot2 = 0

			if RepairAssetsToLua.GetTotalVerifyCount() ~= 0 then
				slot2 = slot0 / slot1
			end

			uv0:SetProgress(slot2, string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), slot0, slot1))

			if not RepairAssetsToLua.IsVerifying() then
				if uv0.updateTimer ~= nil then
					uv0.updateTimer:Stop()

					uv0.updateTimer = nil
				end

				if RepairAssetsToLua.HasError() then
					ShowMessageBox({
						isTop = true,
						title = GetTips("PROMPT"),
						content = GetTips("VERIFY_ASSETS_HAS_ERROR"),
						OkCallback = function ()
							LuaHelper.Quit()
						end
					})
				else
					ShowMessageBox({
						isTop = true,
						title = GetTips("PROMPT"),
						content = GetTips("VERIFY_ASSETS_COMPLETE"),
						OkCallback = function ()
							if gameContext:IsOpenRoute("repairAssetsView") then
								JumpTools.Back()
							end
						end
					})
				end
			end
		end, 0.1, -1)
	end

	slot0.updateTimer:Start()
end

function slot0.OnExit(slot0)
	if slot0.updateTimer ~= nil then
		slot0.updateTimer:Stop()

		slot0.updateTimer = nil
	end

	RepairAssetsToLua.StopVerify()
end

function slot0.Dispose(slot0)
	slot0.params_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
