slot0 = require("protobuf")

module("p57_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.FieldDescriptor()
slot4 = slot0.FieldDescriptor()
slot5 = slot0.Descriptor()
slot6 = slot0.FieldDescriptor()
slot7 = slot0.Descriptor()
slot8 = slot0.FieldDescriptor()
slot9 = slot0.FieldDescriptor()
slot10 = slot0.FieldDescriptor()
slot11 = slot0.Descriptor()
slot12 = slot0.FieldDescriptor()
slot2.name = "report_type"
slot2.full_name = ".p57.cs_57002.report_type"
slot2.number = 1
slot2.index = 0
slot2.label = 2
slot2.has_default_value = false
slot2.default_value = 0
slot2.type = 13
slot2.cpp_type = 3
slot3.name = "report_note"
slot3.full_name = ".p57.cs_57002.report_note"
slot3.number = 2
slot3.index = 1
slot3.label = 2
slot3.has_default_value = false
slot3.default_value = ""
slot3.type = 9
slot3.cpp_type = 9
slot4.name = "msg_uid"
slot4.full_name = ".p57.cs_57002.msg_uid"
slot4.number = 3
slot4.index = 2
slot4.label = 2
slot4.has_default_value = false
slot4.default_value = 0
slot4.type = 4
slot4.cpp_type = 4
slot1.name = "cs_57002"
slot1.full_name = ".p57.cs_57002"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2,
	slot3,
	slot4
}
slot1.is_extendable = false
slot1.extensions = {}
slot6.name = "result"
slot6.full_name = ".p57.sc_57003.result"
slot6.number = 1
slot6.index = 0
slot6.label = 2
slot6.has_default_value = false
slot6.default_value = 0
slot6.type = 13
slot6.cpp_type = 3
slot5.name = "sc_57003"
slot5.full_name = ".p57.sc_57003"
slot5.nested_types = {}
slot5.enum_types = {}
slot5.fields = {
	slot6
}
slot5.is_extendable = false
slot5.extensions = {}
slot8.name = "reported_user_id"
slot8.full_name = ".p57.cs_57004.reported_user_id"
slot8.number = 1
slot8.index = 0
slot8.label = 2
slot8.has_default_value = false
slot8.default_value = 0
slot8.type = 4
slot8.cpp_type = 4
slot9.name = "report_type"
slot9.full_name = ".p57.cs_57004.report_type"
slot9.number = 2
slot9.index = 1
slot9.label = 2
slot9.has_default_value = false
slot9.default_value = 0
slot9.type = 13
slot9.cpp_type = 3
slot10.name = "report_note"
slot10.full_name = ".p57.cs_57004.report_note"
slot10.number = 3
slot10.index = 2
slot10.label = 2
slot10.has_default_value = false
slot10.default_value = ""
slot10.type = 9
slot10.cpp_type = 9
slot7.name = "cs_57004"
slot7.full_name = ".p57.cs_57004"
slot7.nested_types = {}
slot7.enum_types = {}
slot7.fields = {
	slot8,
	slot9,
	slot10
}
slot7.is_extendable = false
slot7.extensions = {}
slot12.name = "result"
slot12.full_name = ".p57.sc_57005.result"
slot12.number = 1
slot12.index = 0
slot12.label = 2
slot12.has_default_value = false
slot12.default_value = 0
slot12.type = 13
slot12.cpp_type = 3
slot11.name = "sc_57005"
slot11.full_name = ".p57.sc_57005"
slot11.nested_types = {}
slot11.enum_types = {}
slot11.fields = {
	slot12
}
slot11.is_extendable = false
slot11.extensions = {}
cs_57002 = slot0.Message(slot1)
cs_57004 = slot0.Message(slot7)
sc_57003 = slot0.Message(slot5)
sc_57005 = slot0.Message(slot11)
