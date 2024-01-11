class router_dst_monitor extends uvm_monitor;

        `uvm_component_utils(router_dst_monitor)

        virtual router_dst_if.DMON_MP vif;

        router_dst_agt_config m_cfg;

        uvm_analysis_port #(read_xtn) monitor_port;


 read_xtn xtn;

extern function new(string name = "router_dst_monitor", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task collect_data();
extern task run_phase(uvm_phase phase);
extern function void report_phase(uvm_phase phase);

endclass



function router_dst_monitor::new(string name ="router_dst_monitor",uvm_component parent);
      super.new(name,parent);
      monitor_port = new("monitor_port",this);
endfunction

function void router_dst_monitor::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(router_dst_agt_config)::get(this,"","router_dst_agt_config",m_cfg))
 `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
endfunction


function void router_dst_monitor::connect_phase(uvm_phase phase);
vif = m_cfg.vif;
endfunction



task router_dst_monitor::run_phase(uvm_phase phase);
#250;
`uvm_info("ROUTER DST MONITOR","run_phase:\n START \n",UVM_MEDIUM);

//forever
begin
 
xtn = read_xtn::type_id::create("xtn");

collect_data();


#1;
`uvm_info("ROUTER DST MONITOR","\n END \n",UVM_MEDIUM);
end

endtask


task router_dst_monitor::collect_data();

 begin 

 read_xtn xtn;
 xtn = read_xtn::type_id::create("xtn");
 

 wait(vif.dmon_cb.read_enb)
repeat(2)
 @(vif.dmon_cb);


 xtn.header = vif.dmon_cb.data_out;
 $display($time," dst mon header recieved: %0d",xtn.header);
 xtn.payload = new[xtn.header[7:2]];


 foreach(xtn.payload[i])
 begin
 repeat(1)
 @(vif.dmon_cb);
 xtn.payload[i] = vif.dmon_cb.data_out;
 $display($time," dst mon payload recieved: %0d",xtn.payload[i]);
 end

 @(vif.dmon_cb); 
 xtn.parity = vif.dmon_cb.data_out;
 $display($time," dst mon parity recieved: %0d",xtn.parity);

 m_cfg.mon_rcvd_xtn_cnt++ ; 
 
  monitor_port.write(xtn);
 @(vif.dmon_cb);
  `uvm_info("ROUTER_DST_MONITOR",$sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW)



end

endtask


function void router_dst_monitor::report_phase(uvm_phase phase );

`uvm_info("ROUTER_DST_MONITOR", $sformatf("Report_phase :destination_mon_rcvd_xtn_cnt = %0d",m_cfg.mon_rcvd_xtn_cnt) ,UVM_MEDIUM)

endfunction




