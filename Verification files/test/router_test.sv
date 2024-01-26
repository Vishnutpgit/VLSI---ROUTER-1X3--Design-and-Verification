class router_test extends uvm_test ;

 `uvm_component_utils(router_test) 

router_env envh ;
router_env_config  m_cfg ;
router_src_agt_config m_src_agt_cfg[] ;
router_dst_agt_config m_dst_agt_cfg[] ;
bit [1:0]addr = $urandom_range(0,2);

bit has_src_agt = 1;
bit has_dst_agt = 1;
int no_of_src_agts = 1;
int no_of_dst_agts = 3;
bit has_sb = 1;
bit has_v_seqr = 1 ;

extern function new( string name = "router_test", uvm_component parent = null );
extern function void  build_phase(uvm_phase phase); 
extern function void config_router();

endclass 

function router_test::new(string name = "router_test", uvm_component parent = null ) ;
super.new(name,parent);
endfunction

function void router_test::config_router();
 if (has_src_agt) begin
  m_src_agt_cfg = new[no_of_src_agts];

 foreach(m_src_agt_cfg[i]) begin
  m_src_agt_cfg[i] = router_src_agt_config::type_id::create($sformatf("m_src_agt_cfg[%0d]",i)) ; 

  if(!uvm_config_db #(virtual router_src_if)::get(this ,"" , $sformatf("vif%0d",i),m_src_agt_cfg[i].vif))
    `uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 
  m_src_agt_cfg[i].is_active = UVM_ACTIVE;
       
  m_cfg.m_src_agt_cfg[i] =   m_src_agt_cfg[i];
  end
 end
 



 if(has_dst_agt) begin
  m_dst_agt_cfg = new[no_of_dst_agts];

 foreach(m_dst_agt_cfg[i]) begin
  m_dst_agt_cfg[i] = router_dst_agt_config::type_id::create($sformatf("m_dst_agt_cfg[%0d]",i)) ;

  if(!uvm_config_db #(virtual router_dst_if)::get(this ,"" , $sformatf("vif%0d",(i+1)),m_dst_agt_cfg[i].vif))
    `uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?")
  m_dst_agt_cfg[i].is_active = UVM_ACTIVE;

  m_cfg.m_dst_agt_cfg[i] =   m_dst_agt_cfg[i];
  end
 end




m_cfg.has_src_agt = has_src_agt;
m_cfg.has_dst_agt = has_dst_agt;
m_cfg.no_of_src_agts = no_of_src_agts;
m_cfg.no_of_dst_agts = no_of_dst_agts;
m_cfg.has_sb = has_sb;
m_cfg.has_v_seqr = has_v_seqr;  

endfunction

function void router_test::build_phase(uvm_phase phase) ;
 
  m_cfg = router_env_config::type_id::create("m_cfg");
  if(has_src_agt)
  m_cfg.m_src_agt_cfg = new[no_of_src_agts];
  if(has_dst_agt)
  m_cfg.m_dst_agt_cfg = new[no_of_dst_agts];
  config_router;
  uvm_config_db #(router_env_config)::set(this, "*", "router_env_config",m_cfg);
  super.build_phase(phase);
  envh = router_env::type_id::create("envh",this);
  uvm_config_db #(bit [1:0] )::set(this,"*","bit" ,addr);
 $display("%0d",addr);
endfunction



class rtr_xtd_test1 extends router_test ;

 `uvm_component_utils(rtr_xtd_test1)

rtr_src_small_xtns src_seqh ;
rtr_rd_at_0 dst_seqh;

extern function new( string name = "rtr_xtd_test1", uvm_component  parent = null ); 
extern function void  build_phase(uvm_phase phase); 
extern task run_phase(uvm_phase phase);

endclass


function rtr_xtd_test1::new( string name = "rtr_xtd_test1", uvm_component  parent = null );
 super.new(name,parent);
endfunction

function void rtr_xtd_test1::build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction


task rtr_xtd_test1::run_phase(uvm_phase phase);

phase.raise_objection(this);

src_seqh = rtr_src_small_xtns::type_id::create("src_seqh");
dst_seqh = rtr_rd_at_0::type_id::create("dst_seqh");

fork

begin
src_seqh.start(envh.sagt_top.sagt[0].src_seqrh);
#100;
end


begin

if(addr == 0) begin

dst_seqh.start(envh.dagt_top.dagt[0].dst_seqrh);
#100;
end
if(addr == 1) begin

dst_seqh.start(envh.dagt_top.dagt[1].dst_seqrh);
#100;
end
if(addr == 2) begin

dst_seqh.start(envh.dagt_top.dagt[2].dst_seqrh);
#100;
end
end

//#500;
join
#100;
phase.drop_objection(this);

endtask 
 



class rtr_xtd_test2 extends router_test ;

 `uvm_component_utils(rtr_xtd_test2)

rtr_src_med_xtns src_seqh ;
rtr_rd_at_0 dst_seqh;

extern function new( string name = "rtr_xtd_test2", uvm_component  parent = null );
extern function void  build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass


function rtr_xtd_test2::new( string name = "rtr_xtd_test2", uvm_component  parent = null );
 super.new(name,parent);
endfunction

function void rtr_xtd_test2::build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction


task rtr_xtd_test2::run_phase(uvm_phase phase);
phase.raise_objection(this);
src_seqh = rtr_src_med_xtns::type_id::create("src_seqh");
dst_seqh = rtr_rd_at_0::type_id::create("dst_seqh");

fork
begin
src_seqh.start(envh.sagt_top.sagt[0].src_seqrh);
#100;
end

begin
if(addr == 0) begin
#260;
dst_seqh.start(envh.dagt_top.dagt[0].dst_seqrh);
#100;
end
else if(addr == 1) begin
#260;
dst_seqh.start(envh.dagt_top.dagt[1].dst_seqrh);
#100;
end
else if(addr == 2) begin
#260;
dst_seqh.start(envh.dagt_top.dagt[2].dst_seqrh);
#100;
end
end
//#500;
join
#100;
phase.drop_objection(this);
endtask







class rtr_xtd_test3 extends router_test ;

 `uvm_component_utils(rtr_xtd_test3)

rtr_src_big_xtns src_seqh ;
rtr_rd_at_0 dst_seqh;

extern function new( string name = "rtr_xtd_test2", uvm_component  parent = null );
extern function void  build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass


function rtr_xtd_test3::new( string name = "rtr_xtd_test2", uvm_component  parent = null );
 super.new(name,parent);
endfunction

function void rtr_xtd_test3::build_phase(uvm_phase phase);
 super.build_phase(phase);
endfunction

task rtr_xtd_test3::run_phase(uvm_phase phase);
phase.raise_objection(this);
src_seqh = rtr_src_big_xtns::type_id::create("src_seqh");
dst_seqh = rtr_rd_at_0::type_id::create("dst_seqh");

fork
begin
src_seqh.start(envh.sagt_top.sagt[0].src_seqrh);
#100;
end

begin
if(addr == 0) begin
#260;
dst_seqh.start(envh.dagt_top.dagt[0].dst_seqrh);
#100;
end
else if(addr == 1) begin
#260;
dst_seqh.start(envh.dagt_top.dagt[1].dst_seqrh);
#100;
end
else if(addr == 2) begin
#260;
dst_seqh.start(envh.dagt_top.dagt[2].dst_seqrh);
#100;
end
end
//#500;
join
#100;
phase.drop_objection(this);
endtask


