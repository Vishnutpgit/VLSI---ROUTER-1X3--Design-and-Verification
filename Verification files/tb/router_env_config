class router_env_config extends uvm_object ;
 
  `uvm_object_utils(router_env_config)
 
router_src_agt_config m_src_agt_cfg[];
router_dst_agt_config m_dst_agt_cfg[];

bit has_functional_coverage = 0;
bit has_src_agt = 0;
bit has_dst_agt = 0;
int no_of_src_agts = 0;
int no_of_dst_agts  = 0;
bit has_sb = 0;
bit has_v_seqr = 0 ;

extern function new(string name = "router_env_config");

endclass


function router_env_config::new(string name = "router_env_config");
 super.new(name);
endfunction

 
