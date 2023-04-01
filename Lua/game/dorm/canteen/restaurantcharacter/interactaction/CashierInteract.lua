slot0 = import(".InteractUtil")
slot1 = slot0.NewTask
slot2 = slot0.IsCustomer

return function (slot0)
	slot2 = slot0.entityID
	slot3 = slot0.entityData
	slot4 = slot0.finish

	if uv0(slot0.targetType) then
		uv1(function ()
			Dorm.DormEntityManager.PlayAnimeDuringInteract(uv0, "cashier")
		end):WaitForSec(5):Then(function ()
			uv0.cashierObject = nil

			print("收银成功")
			uv1:Notify()
		end):Start()
	end
end
