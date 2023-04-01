slot0 = require("library/redux/utils/actionTypes")
slot1 = require("library/redux/utils/isPlainTable")

return function (slot0, slot1, slot2)
	if slot2 ~= nil then
		if type(slot2) ~= "function" then
			error("Expected the enhancer to be a function.")
		end

		return slot2(uv0)(slot0, slot1)
	end

	if type(slot0) ~= "function" then
		error("Expected the reducer to be a function")
	end

	slot3 = slot0
	slot4 = slot1
	slot6 = {}
	slot7 = false

	function slot8()
		if uv0 == uv1 then
			uv0 = {}

			for slot3, slot4 in ipairs(uv1) do
				table.insert(uv0, slot4)
			end
		end
	end

	function slot11(slot0)
		if not uv0(slot0) then
			error("            Actions must be plain tables.\n            Use custom middleware for async actions")
		end

		if slot0.type == nil then
			error("            Actions may not have a nil 'type' property.\n            Have you misspelled a constant?")
		end

		if uv1 then
			error("Reducers may not dispatch actions.")
		end

		slot1, slot2 = pcall(function ()
			uv0 = true
			uv1 = uv2(uv1, uv3)
		end)

		if not slot1 then
			error(slot2)
		end

		uv1 = false
		uv4 = uv5

		for slot7, slot8 in ipairs(uv4) do
			for slot12, slot13 in ipairs(uv5) do
				if slot13 == slot8 then
					slot8(slot0)
				end
			end
		end

		return slot0
	end

	slot11({
		type = uv2.INIT
	})

	return {
		dispatch = slot11,
		subscribe = function (slot0)
			if type(slot0) ~= "function" then
				error("Expected the listener to be a function.")
			end

			if uv0 then
				error([[
            You may not call store.subscribe() while the reducer is executing.
            If you would like to be notified after the store has been updated, subscribe from a
            component and invoke store.getState() in the callback to access the latest state.
            See https://redux.js.org/api-reference/store#subscribe(listener) for more details.]])
			end

			slot1 = true

			uv1()
			table.insert(uv2, slot0)

			return function ()
				if not uv0 then
					return
				end

				if uv1 then
					error("                You may not unsubscribe from a store listener while the reducer is executing.\n                See https://redux.js.org/api-reference/store#subscribe(listener) for more details.")
				end

				uv0 = false

				uv2()

				slot0 = 0

				for slot4, slot5 in ipairs(uv3) do
					if slot5 == uv4 then
						slot0 = slot4

						break
					end
				end

				if slot0 ~= 0 then
					table.remove(uv3, slot0)
				end
			end
		end,
		getState = function ()
			if uv0 then
				error("            You may not call store.getState() while the reducer is executing.\n            The reducer has already received the state as an argument.\n            Pass it down from the top reducer instead of reading it from the store.")
			end

			return uv1
		end,
		replaceReducer = function (slot0)
			if type(slot0) ~= "function" then
				error("Expected the nextReducer to be a function.")
			end

			uv0 = slot0

			uv1({
				type = uv2.REPLACE
			})
		end
	}
end
