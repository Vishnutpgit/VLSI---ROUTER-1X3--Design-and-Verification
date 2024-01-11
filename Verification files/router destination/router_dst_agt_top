class router_dst_agt_top extends uvm_env ;

  `uvm_component_utils(router_dst_agt_top)

  router_dst_agt dagt[];

  router_env_config m_cfg;

extern function new(string name = "router_dst_agt_top" , uvm_component parent = null );
extern function void build_phase(uvm_phase phase);

endclass


function router_dst_agt_top::new(string name = "router_dst_agt_top" , uvm_component parent = null );
 super.new(name , parent);
endfunction


function void router_dst_agt_top::build_phase(uvm_phase phase);
 super.build_phase(phase);
 if(!uvm_config_db #(router_env_config)::get(this,"", "router_env_config",m_cfg))
  `uvm_fatal("ROUTER_DST_AGT_TOP","getting the config item is failed")

if(m_cfg.has_dst_agt)
 begin
   dagt = new[m_cfg.no_of_dst_agts];

  foreach(dagt[i]) begin
   uvm_config_db #(router_dst_agt_config)::set(this,$sformatf("dagt[%0d]*",i),"router_dst_agt_config",m_cfg.m_dst_agt_cfg[i]);

   dagt[i] =  router_dst_agt::type_id::create($sformatf("dagt[%0d]" , i ), this);
  end
 end
endfunction

