slot0 = require("protobuf")

module("netproto_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.FieldDescriptor()
slot4 = slot0.Descriptor()
slot5 = slot0.FieldDescriptor()
slot6 = slot0.FieldDescriptor()
slot7 = slot0.FieldDescriptor()
slot2.name = "Timestamp"
slot2.full_name = ".Op_B2G_ConnectRequest.Timestamp"
slot2.number = 1
slot2.index = 0
slot2.label = 2
slot2.has_default_value = false
slot2.default_value = 0
slot2.type = 13
slot2.cpp_type = 3
slot3.name = "Verification"
slot3.full_name = ".Op_B2G_ConnectRequest.Verification"
slot3.number = 2
slot3.index = 1
slot3.label = 2
slot3.has_default_value = false
slot3.default_value = ""
slot3.type = 9
slot3.cpp_type = 9
slot1.name = "Op_B2G_ConnectRequest"
slot1.full_name = ".Op_B2G_ConnectRequest"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2,
	slot3
}
slot1.is_extendable = false
slot1.extensions = {}
slot5.name = "ErrorCode"
slot5.full_name = ".Op_G2B_ConnectResponse.ErrorCode"
slot5.number = 1
slot5.index = 0
slot5.label = 2
slot5.has_default_value = false
slot5.default_value = 0
slot5.type = 13
slot5.cpp_type = 3
slot6.name = "BattleServerId"
slot6.full_name = ".Op_G2B_ConnectResponse.BattleServerId"
slot6.number = 2
slot6.index = 1
slot6.label = 2
slot6.has_default_value = false
slot6.default_value = 0
slot6.type = 13
slot6.cpp_type = 3
slot7.name = "IsServiceOpen"
slot7.full_name = ".Op_G2B_ConnectResponse.IsServiceOpen"
slot7.number = 3
slot7.index = 2
slot7.label = 2
slot7.has_default_value = false
slot7.default_value = false
slot7.type = 8
slot7.cpp_type = 7
slot4.name = "Op_G2B_ConnectResponse"
slot4.full_name = ".Op_G2B_ConnectResponse"
slot4.nested_types = {}
slot4.enum_types = {}
slot4.fields = {
	slot5,
	slot6,
	slot7
}
slot4.is_extendable = false
slot4.extensions = {}
Op_B2G_ConnectRequest = slot0.Message(slot1)
Op_G2B_ConnectResponse = slot0.Message(slot4)
