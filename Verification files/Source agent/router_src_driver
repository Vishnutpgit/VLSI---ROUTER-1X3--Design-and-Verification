class router_src_driver extends uvm_driver #(write_xtn) ;
  
   `uvm_component_utils(router_src_driver)

  virtual router_src_if.SDRV_MP  vif ;
 
  router_src_agt_config m_cfg ;
  

extern function new(string name ="router_src_driver",uvm_component parent = null ); 
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task send_to_dut(write_xtn xtn);
extern function void report_phase(uvm_phase phase);

endclass 

function router_src_driver::new(string name ="router_src_driver",uvm_component parent = null );     
      super.new(name,parent);
endfunction


function void router_src_driver::build_phase(uvm_phase phase); 
super.build_phase(phase);
if(!uvm_config_db #(router_src_agt_config)::get(this,"","router_src_agt_config",m_cfg)) 
 `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
endfunction


function void router_src_driver::connect_phase(uvm_phase phase); 
vif = m_cfg.vif;
endfunction


task router_src_driver::send_to_dut(write_xtn xtn);

`uvm_info("ROUTER_SRC_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_MEDIUM)


 @(vif.sdrv_cb);

 while(vif.sdrv_cb.busy)
 @(vif.sdrv_cb);

 vif.sdrv_cb.data_in <= xtn.header;
 vif.sdrv_cb.pkt_valid <=  1 ;
 @(vif.sdrv_cb);
 
 foreach(xtn.payload[i]) begin 

 while(vif.sdrv_cb.busy)
 @(vif.sdrv_cb);

 vif.sdrv_cb.data_in <= xtn.payload[i] ;
 @(vif.sdrv_cb); 
                                       
 end
   
 
 while(vif.sdrv_cb.busy)
 @(vif.sdrv_cb);

 vif.sdrv_cb.data_in <= xtn.parity ;
 vif.sdrv_cb.pkt_valid <= 0 ;
 m_cfg.drv_data_sent_cnt++;

 repeat(2)
 @(vif.sdrv_cb); 


endtask



task router_src_driver::run_phase(uvm_phase phase);

@(vif.sdrv_cb);
  vif.sdrv_cb.resetn <= 0 ;
 @(vif.sdrv_cb);
  vif.sdrv_cb.resetn <= 1 ;

forever 
begin
  seq_item_port.get_next_item(req);
  send_to_dut(req);
  seq_item_port.item_done();
end

  
endtask



function void router_src_driver::report_phase(uvm_phase phase) ;

 `uvm_info("ROUTER_SRC_DRIVER",$sformatf(" Report_phase : source_drv_data_sent_cnt = %0d ",m_cfg.drv_data_sent_cnt ) ,UVM_MEDIUM)

endfunction 






