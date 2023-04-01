slot0 = require("protobuf")

module("p41_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.Descriptor()
slot4 = slot0.FieldDescriptor()
slot5 = slot0.FieldDescriptor()
slot6 = slot0.Descriptor()
slot2.name = "info_list"
slot2.full_name = ".p41.sc_41001.info_list"
slot2.number = 1
slot2.index = 0
slot2.label = 3
slot2.has_default_value = false
slot2.default_value = {}
slot2.message_type = slot3
slot2.type = 11
slot2.cpp_type = 10
slot1.name = "sc_41001"
slot1.full_name = ".p41.sc_41001"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2
}
slot1.is_extendable = false
slot1.extensions = {}
slot4.name = "area"
slot4.full_name = ".p41.tower_info.area"
slot4.number = 1
slot4.index = 0
slot4.label = 2
slot4.has_default_value = false
slot4.default_value = 0
slot4.type = 13
slot4.cpp_type = 3
slot5.name = "stage"
slot5.full_name = ".p41.tower_info.stage"
slot5.number = 2
slot5.index = 1
slot5.label = 2
slot5.has_default_value = false
slot5.default_value = 0
slot5.type = 13
slot5.cpp_type = 3
slot3.name = "tower_info"
slot3.full_name = ".p41.tower_info"
slot3.nested_types = {}
slot3.enum_types = {}
slot3.fields = {
	slot4,
	slot5
}
slot3.is_extendable = false
slot3.extensions = {}
slot6.name = "cs_41002"
slot6.full_name = ".p41.cs_41002"
slot6.nested_types = {}
slot6.enum_types = {}
slot6.fields = {}
slot6.is_extendable = false
slot6.extensions = {}
cs_41002 = slot0.Message(slot6)
sc_41001 = slot0.Message(slot1)
tower_info = slot0.Message(slot3)
