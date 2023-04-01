slot0 = class("DrawNormalPool", DrawBasePool)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.firstController = ControllerUtil.GetController(slot0.transform_, "first")
end

function slot0.Refresh(slot0)
	if DrawData:GetIsFirstSSR() then
		slot0.drawTime_.text = string.format("%d/%d", DrawData:GetPoolDrawTimes(slot0.poolId), GameSetting.draw_ssr_lucky_num_first_time.value[1])

		slot0.firstController:SetSelectedIndex(1)
	else
		slot0.firstController:SetSelectedIndex(0)
	end
end

return slot0
