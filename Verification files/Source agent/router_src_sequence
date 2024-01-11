class router_src_sequence extends uvm_sequence #(write_xtn) ;

 `uvm_object_utils(router_src_sequence) 
 bit [1:0]addr ;

extern function new(string name = "router_src_sequence" );

endclass

function router_src_sequence::new(string name = "router_src_sequence" );
 super.new(name);
endfunction


class rtr_src_small_xtns extends router_src_sequence;

 `uvm_object_utils(rtr_src_small_xtns)

extern function new(string name ="rtr_src_xtd_xtns");
extern task body();

endclass

function rtr_src_small_xtns::new(string name ="rtr_src_xtd_xtns");
  super.new(name);
endfunction


task rtr_src_small_xtns::body();
begin
 if(!uvm_config_db #(bit [1:0])::get(null ,get_full_name(), "bit", addr))
  `uvm_fatal("ROUTER_SRC_SEQUENCE","Failed in getting the config item")
repeat(1)  begin
req = write_xtn::type_id::create("req") ;
 start_item(req);
 assert(req.randomize() with { header[7:2] ==  5; header[1:0] == addr ;} );
`uvm_info("ROUTER_SRC_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
 finish_item(req);
 end
end
endtask



class rtr_src_med_xtns extends router_src_sequence;

 `uvm_object_utils(rtr_src_med_xtns)

extern function new(string name ="rtr_src_xtd_xtns");
extern task body();

endclass

function rtr_src_med_xtns::new(string name ="rtr_src_xtd_xtns");
  super.new(name);
endfunction


task rtr_src_med_xtns::body();
begin
 if(!uvm_config_db #(bit [1:0])::get(null ,get_full_name(), "bit", addr))
  `uvm_fatal("ROUTER_SRC_SEQUENCE","Failed in getting the config item")
repeat(1) begin
req = write_xtn::type_id::create("req") ;
 start_item(req);
 assert(req.randomize() with { header[7:2] == 17 ; header[1:0] == addr ;} );
`uvm_info("ROUTER_SRC_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
 finish_item(req);
 end
end
endtask



class rtr_src_big_xtns extends router_src_sequence;

 `uvm_object_utils(rtr_src_big_xtns)

extern function new(string name ="rtr_src_xtd_xtns");
extern task body();

endclass

function rtr_src_big_xtns::new(string name ="rtr_src_xtd_xtns");
  super.new(name);
endfunction


task rtr_src_big_xtns::body();
begin
 if(!uvm_config_db #(bit [1:0])::get(null ,get_full_name(), "bit", addr))
  `uvm_fatal("ROUTER_SRC_SEQUENCE","Failed in getting the config item")
repeat(1) begin
req = write_xtn::type_id::create("req") ;
 start_item(req);
 assert(req.randomize() with { header[7:2] == 33; header[1:0] == addr ;} );
`uvm_info("ROUTER_SRC_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
 finish_item(req);
 end
end
endtask

