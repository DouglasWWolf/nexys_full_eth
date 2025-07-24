# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "AW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_LOCAL_IP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEFAULT_LOCAL_MAC" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DW" -parent ${Page_0}


}

proc update_PARAM_VALUE.AW { PARAM_VALUE.AW } {
	# Procedure called to update AW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AW { PARAM_VALUE.AW } {
	# Procedure called to validate AW
	return true
}

proc update_PARAM_VALUE.DEFAULT_LOCAL_IP { PARAM_VALUE.DEFAULT_LOCAL_IP } {
	# Procedure called to update DEFAULT_LOCAL_IP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_LOCAL_IP { PARAM_VALUE.DEFAULT_LOCAL_IP } {
	# Procedure called to validate DEFAULT_LOCAL_IP
	return true
}

proc update_PARAM_VALUE.DEFAULT_LOCAL_MAC { PARAM_VALUE.DEFAULT_LOCAL_MAC } {
	# Procedure called to update DEFAULT_LOCAL_MAC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEFAULT_LOCAL_MAC { PARAM_VALUE.DEFAULT_LOCAL_MAC } {
	# Procedure called to validate DEFAULT_LOCAL_MAC
	return true
}

proc update_PARAM_VALUE.DW { PARAM_VALUE.DW } {
	# Procedure called to update DW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DW { PARAM_VALUE.DW } {
	# Procedure called to validate DW
	return true
}


proc update_MODELPARAM_VALUE.AW { MODELPARAM_VALUE.AW PARAM_VALUE.AW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AW}] ${MODELPARAM_VALUE.AW}
}

proc update_MODELPARAM_VALUE.DW { MODELPARAM_VALUE.DW PARAM_VALUE.DW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DW}] ${MODELPARAM_VALUE.DW}
}

proc update_MODELPARAM_VALUE.DEFAULT_LOCAL_IP { MODELPARAM_VALUE.DEFAULT_LOCAL_IP PARAM_VALUE.DEFAULT_LOCAL_IP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_LOCAL_IP}] ${MODELPARAM_VALUE.DEFAULT_LOCAL_IP}
}

proc update_MODELPARAM_VALUE.DEFAULT_LOCAL_MAC { MODELPARAM_VALUE.DEFAULT_LOCAL_MAC PARAM_VALUE.DEFAULT_LOCAL_MAC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEFAULT_LOCAL_MAC}] ${MODELPARAM_VALUE.DEFAULT_LOCAL_MAC}
}

