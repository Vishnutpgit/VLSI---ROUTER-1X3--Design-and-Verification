class router_dst_driver extends uvm_driver #(read_xtn) ;

   `uvm_component_utils(router_dst_driver)

  virtual router_dst_if.DDRV_MP  vif ;

  router_dst_agt_config m_cfg ;


extern function new(string name ="router_dst_driver",uvm_component parent = null );
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task send_to_dut(read_xtn xtn);
extern task run_phase(uvm_phase phase) ;
extern function void report_phase(uvm_phase phase) ; 
endclass

function router_dst_driver::new(string name ="router_dst_driver",uvm_component parent = null );
      super.new(name,parent);
endfunction




function void router_dst_driver::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(router_dst_agt_config)::get(this,"","router_dst_agt_config",m_cfg))
 `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
endfunction


function void router_dst_driver::connect_phase(uvm_phase phase);
vif = m_cfg.vif;
endfunction

task router_dst_driver::run_phase(uvm_phase phase) ;

#250;
`uvm_info("ROUTER DST DRIVER","run_phase: START\n",UVM_MEDIUM);


forever
begin
 seq_item_port.get_next_item(req);
 send_to_dut(req);
 seq_item_port.item_done();
end

`uvm_info("ROUTER DST DRIVER","run_phase: END\n",UVM_MEDIUM);

endtask


 
task router_dst_driver::send_to_dut(read_xtn xtn);


`uvm_info("ROUTER_DST_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_MEDIUM)

 @(vif.ddrv_cb);

wait(vif.ddrv_cb.valid_out)

 @(vif.ddrv_cb);


//repeat(xtn.no_of_cycles)
// @(vif.ddrv_cb);

vif.ddrv_cb.read_enb <= 1;
// @(vif.ddrv_cb);

wait(~vif.ddrv_cb.valid_out)

 @(vif.ddrv_cb);

 
vif.ddrv_cb.read_enb <= 0;

m_cfg.drv_data_sent_cnt++;


endtask



function void router_dst_driver::report_phase(uvm_phase phase) ;

`uvm_info("ROUTER_DST_DRIVER",$sformatf(" Report_phase : destination_drv_data_sent_cnt = %0d ",m_cfg.drv_data_sent_cnt ) ,UVM_MEDIUM)

endfunction








