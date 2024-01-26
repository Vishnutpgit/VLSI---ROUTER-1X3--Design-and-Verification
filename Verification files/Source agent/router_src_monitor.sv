class router_src_monitor extends uvm_monitor;

        `uvm_component_utils(router_src_monitor)

        virtual router_src_if.SMON_MP vif;

        router_src_agt_config m_cfg;

       uvm_analysis_port #(write_xtn) monitor_port;
       write_xtn xtn ;


extern function new(string name = "router_src_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
extern function void report_phase(uvm_phase phase);

endclass



function router_src_monitor::new(string name ="router_src_monitor",uvm_component parent);
      super.new(name,parent);
      monitor_port = new("monitor_port",this);
endfunction

function void router_src_monitor::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(router_src_agt_config)::get(this,"","router_src_agt_config",m_cfg))
 `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")


endfunction



function void router_src_monitor::connect_phase(uvm_phase phase);
vif = m_cfg.vif;
endfunction


function void router_src_monitor::end_of_elaboration_phase(uvm_phase phase);
 uvm_top.print_topology;
endfunction

 
task router_src_monitor::run_phase(uvm_phase phase) ;
forever 
  begin
  collect_data();
  end
endtask


task router_src_monitor::collect_data();
 
xtn = write_xtn::type_id::create("xtn");

 @(vif.smon_cb);
 @(vif.smon_cb);
 @(vif.smon_cb);
 @(vif.smon_cb);
 
 while(!vif.smon_cb.pkt_valid)
 @(vif.smon_cb);

 while(vif.smon_cb.busy)
 @(vif.smon_cb); 

 xtn.header = vif.smon_cb.data_in ; 
 $display($time," src mon header recieved: %0d",xtn.header);
 @(vif.smon_cb);
                                                            
 xtn.payload = new[xtn.header[7:2]];
 
 foreach(xtn.payload[i]) 
 begin
 
 while(vif.smon_cb.busy)
 @(vif.smon_cb);
 
 xtn.payload[i] = vif.smon_cb.data_in ;
 $display($time," src mon payload recieved: %0d",xtn.payload[i]);
 @(vif.smon_cb); 

 end
 
 while(vif.smon_cb.pkt_valid)
 @(vif.smon_cb);

 while(vif.smon_cb.busy)
 @(vif.smon_cb);

 xtn.parity = vif.smon_cb.data_in ;
 $display($time," src mon parity recieved: %0d",xtn.parity);
 @(vif.smon_cb); 

 monitor_port.write(xtn);

m_cfg.mon_rcvd_xtn_cnt++;  


 `uvm_info("ROUTER_SRC_MONITOR",$sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW)

endtask  


function void router_src_monitor::report_phase(uvm_phase phase);

 `uvm_info("ROUTER_SRC_MONITOR", $sformatf("Report_phase :source_mon_rcvd_xtn_cnt = %0d",m_cfg.mon_rcvd_xtn_cnt) ,UVM_MEDIUM)
 
endfunction 



 
















