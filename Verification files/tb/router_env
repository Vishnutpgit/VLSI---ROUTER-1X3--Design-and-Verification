class router_env extends uvm_env ;

 `uvm_component_utils(router_env)

  router_src_agt_top sagt_top;
  router_dst_agt_top dagt_top;

  router_env_config m_cfg;
  router_sb sbh ;
  router_v_sequencer vseqr ;

extern function new(string name = "router_env",uvm_component parent = null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);


endclass

function router_env::new(string name = "router_env",uvm_component parent = null);
 super.new(name,parent);
endfunction


function void router_env::build_phase(uvm_phase phase);
 super.build_phase(phase);
 
 if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
   `uvm_fatal("ROUTER_ENV", "getting the config item is failed")

 if(m_cfg.has_src_agt)
  sagt_top =  router_src_agt_top::type_id::create(" sagt_top ", this);
 
 if(m_cfg.has_dst_agt)
  dagt_top =  router_dst_agt_top::type_id::create(" dagt_top ", this);

 if(m_cfg.has_sb)
  sbh = router_sb::type_id::create("sbh",this); 

 if(m_cfg.has_v_seqr)
  vseqr = router_v_sequencer::type_id::create("vseqr",this) ;  
 

endfunction

    

function void router_env::connect_phase(uvm_phase phase);

 if(m_cfg.has_sb)
  begin
 
  foreach(sagt_top.sagt[i])  
  sagt_top.sagt[i].src_monh.monitor_port.connect(sbh.fifo_wrh[i].analysis_export);

 
  foreach(dagt_top.dagt[i])
  dagt_top.dagt[i].dst_monh.monitor_port.connect(sbh.fifo_rdh[i].analysis_export);
 
  end

endfunction
  
   





