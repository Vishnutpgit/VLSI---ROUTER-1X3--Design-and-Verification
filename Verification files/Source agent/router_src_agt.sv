class router_src_agt extends uvm_agent ;

 `uvm_component_utils(router_src_agt)
  
router_src_agt_config m_src_agt_cfg ;
  
router_src_driver src_drvh ;
router_src_monitor src_monh;
router_src_sequencer src_seqrh;

extern function new(string name = "router_src_agt", uvm_component parent = null );
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

function router_src_agt::new(string name = "router_src_agt", uvm_component parent = null );
 super.new(name,parent);
endfunction

function void router_src_agt::build_phase(uvm_phase phase);
 super.build_phase(phase);
 
 src_monh =  router_src_monitor::type_id::create(" src_monh ",this); 
 
 if(!uvm_config_db #(router_src_agt_config)::get(this,"", "router_src_agt_config", m_src_agt_cfg))
  `uvm_fatal("ROUTER_SRC_AGT", "getting the config item is failed")

 if(m_src_agt_cfg.is_active) begin
  src_drvh =  router_src_driver::type_id::create("src_drvh",this);

   src_seqrh = router_src_sequencer::type_id::create("src_seqrh" ,this);
 end

endfunction




function void router_src_agt::connect_phase(uvm_phase phase);
 if(m_src_agt_cfg.is_active) 
   begin
   src_drvh.seq_item_port.connect(src_seqrh.seq_item_export);
   end
endfunction
 
  



 
