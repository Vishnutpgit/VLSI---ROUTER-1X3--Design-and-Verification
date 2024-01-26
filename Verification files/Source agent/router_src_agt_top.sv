class router_src_agt_top extends uvm_env ;
  
  `uvm_component_utils(router_src_agt_top)

  router_src_agt sagt[];

  router_env_config m_cfg;

extern function new(string name = "router_src_agt_top" , uvm_component parent = null );
extern function void build_phase(uvm_phase phase);

endclass 


function router_src_agt_top::new(string name = "router_src_agt_top" , uvm_component parent = null );
 super.new(name , parent);
endfunction


function void router_src_agt_top::build_phase(uvm_phase phase);
 super.build_phase(phase);
 if(!uvm_config_db #(router_env_config)::get(this,"", "router_env_config",m_cfg))
  `uvm_fatal("ROUTER_SRC_AGT_TOP","getting the config item is failed")

if(m_cfg.has_src_agt)
 begin
   sagt = new[m_cfg.no_of_src_agts];
   
  foreach(sagt[i]) begin
   uvm_config_db #(router_src_agt_config)::set(this,$sformatf("*sagt[%0d]*",i),"router_src_agt_config",m_cfg.m_src_agt_cfg[i]);
  
   sagt[i] =  router_src_agt::type_id::create($sformatf(" sagt[%0d] " , i ), this);
  end
 end

endfunction
 
