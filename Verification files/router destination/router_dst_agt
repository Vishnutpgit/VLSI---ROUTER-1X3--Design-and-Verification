class router_dst_agt extends uvm_agent ;

 `uvm_component_utils(router_dst_agt)

router_dst_agt_config m_dst_agt_cfg ;

router_dst_driver dst_drvh ;
router_dst_monitor dst_monh;
router_dst_sequencer dst_seqrh;

extern function new(string name = "router_dst_agt", uvm_component parent = null );
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

function router_dst_agt::new(string name = "router_dst_agt", uvm_component parent = null );
 super.new(name,parent);
endfunction

function void router_dst_agt::build_phase(uvm_phase phase);
 super.build_phase(phase);

 dst_monh =  router_dst_monitor::type_id::create(" dst_monh ",this);

 if(!uvm_config_db #(router_dst_agt_config)::get(this,"", "router_dst_agt_config", m_dst_agt_cfg))
  `uvm_fatal("ROUTER_DST_AGT", "getting the config item is failed")

 if(m_dst_agt_cfg.is_active) begin
  dst_drvh =  router_dst_driver::type_id::create("dst_drvh",this);

   dst_seqrh = router_dst_sequencer::type_id::create("dst_seqrh" ,this);
 end

endfunction




function void router_dst_agt::connect_phase(uvm_phase phase);
 if(m_dst_agt_cfg.is_active)
   begin
   dst_drvh.seq_item_port.connect(dst_seqrh.seq_item_export);
   end
endfunction

