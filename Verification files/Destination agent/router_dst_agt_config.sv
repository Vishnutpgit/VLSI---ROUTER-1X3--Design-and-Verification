class router_dst_agt_config extends uvm_object ;

  `uvm_object_utils(router_dst_agt_config)

  virtual router_dst_if vif ;

uvm_active_passive_enum is_active = UVM_ACTIVE;

 int mon_rcvd_xtn_cnt = 0;

 int drv_data_sent_cnt = 0;

extern function new(string name = "router_dst_agt_config");

endclass

function router_dst_agt_config::new(string name = "router_dst_agt_config");
super.new(name);
endfunction




