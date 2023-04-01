slot0 = require("protobuf")

module("p56_pb")

slot1 = slot0.Descriptor()
slot2 = slot0.FieldDescriptor()
slot3 = slot0.FieldDescriptor()
slot4 = slot0.FieldDescriptor()
slot5 = slot0.Descriptor()
slot6 = slot0.FieldDescriptor()
slot7 = slot0.Descriptor()
slot8 = slot0.FieldDescriptor()
slot2.name = "nothing"
slot2.full_name = ".p56.sc_56001.nothing"
slot2.number = 1
slot2.index = 0
slot2.label = 2
slot2.has_default_value = false
slot2.default_value = 0
slot2.type = 13
slot2.cpp_type = 3
slot3.name = "red_dot"
slot3.full_name = ".p56.sc_56001.red_dot"
slot3.number = 2
slot3.index = 1
slot3.label = 3
slot3.has_default_value = false
slot3.default_value = {}
slot3.type = 13
slot3.cpp_type = 3
slot4.name = "client_finished_red_dot"
slot4.full_name = ".p56.sc_56001.client_finished_red_dot"
slot4.number = 3
slot4.index = 2
slot4.label = 3
slot4.has_default_value = false
slot4.default_value = {}
slot4.type = 13
slot4.cpp_type = 3
slot1.name = "sc_56001"
slot1.full_name = ".p56.sc_56001"
slot1.nested_types = {}
slot1.enum_types = {}
slot1.fields = {
	slot2,
	slot3,
	slot4
}
slot1.is_extendable = false
slot1.extensions = {}
slot6.name = "red_dot"
slot6.full_name = ".p56.cs_56002.red_dot"
slot6.number = 1
slot6.index = 0
slot6.label = 2
slot6.has_default_value = false
slot6.default_value = 0
slot6.type = 13
slot6.cpp_type = 3
slot5.name = "cs_56002"
slot5.full_name = ".p56.cs_56002"
slot5.nested_types = {}
slot5.enum_types = {}
slot5.fields = {
	slot6
}
slot5.is_extendable = false
slot5.extensions = {}
slot8.name = "result"
slot8.full_name = ".p56.sc_56003.result"
slot8.number = 1
slot8.index = 0
slot8.label = 2
slot8.has_default_value = false
slot8.default_value = 0
slot8.type = 13
slot8.cpp_type = 3
slot7.name = "sc_56003"
slot7.full_name = ".p56.sc_56003"
slot7.nested_types = {}
slot7.enum_types = {}
slot7.fields = {
	slot8
}
slot7.is_extendable = false
slot7.extensions = {}
cs_56002 = slot0.Message(slot5)
sc_56001 = slot0.Message(slot1)
sc_56003 = slot0.Message(slot7)
