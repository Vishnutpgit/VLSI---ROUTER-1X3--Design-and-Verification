class router_dst_sequence extends uvm_sequence #(read_xtn);

 `uvm_object_utils(router_dst_sequence)

extern function new(string name = "router_dst_sequence");

endclass

function router_dst_sequence::new(string name = "router_dst_sequence");
super.new(name);
endfunction


class rtr_rd_bfr_30 extends router_dst_sequence;

 `uvm_object_utils(rtr_rd_bfr_30)

extern function new(string name = "rtr_rd_bfr_30");
extern task body();
endclass


function rtr_rd_bfr_30::new(string name = "rtr_rd_bfr_30");
super.new(name);
endfunction



task rtr_rd_bfr_30::body();
begin
req = read_xtn::type_id::create("req");
 start_item(req); 
 assert(req.randomize() with { no_of_cycles<30;});
`uvm_info("ROUTER_DST_SEQUENCE",$sformatf("printing from sequence\n %s", req.sprint()),UVM_LOW)
 finish_item(req);
 end
endtask


class rtr_rd_aftr_30 extends router_dst_sequence;

 `uvm_object_utils(rtr_rd_aftr_30)

extern function new(string name = "rtr_rd_aftr_30");
extern task body();
endclass


function rtr_rd_aftr_30::new(string name = "rtr_rd_aftr_30");
super.new(name);
endfunction



task rtr_rd_aftr_30::body();
begin
 req = read_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with { no_of_cycles>30;});
`uvm_info("ROUTER_DST_SEQUENCE",$sformatf("printing from sequence with soft reset\n %s", req.sprint()),UVM_LOW)
 finish_item(req);
end
endtask





class rtr_rd_at_0 extends router_dst_sequence;

 `uvm_object_utils(rtr_rd_at_0)

extern function new(string name = "rtr_rd_at_0");
extern task body();
endclass


function rtr_rd_at_0::new(string name = "rtr_rd_at_0");
super.new(name);
endfunction



task rtr_rd_at_0::body();
begin
 req = read_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with { no_of_cycles == 0;});
`uvm_info("ROUTER_DST_SEQUENCE",$sformatf("printing from sequence with soft reset\n %s", req.sprint()),UVM_LOW)
 finish_item(req);
end
endtask






class rtr_rd_at_1 extends router_dst_sequence;

 `uvm_object_utils(rtr_rd_at_1)

extern function new(string name = "rtr_rd_at_1");
extern task body();
endclass


function rtr_rd_at_1::new(string name = "rtr_rd_at_1");
super.new(name);
endfunction



task rtr_rd_at_1::body();
begin
 req = read_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with { no_of_cycles == 1;});
`uvm_info("ROUTER_DST_SEQUENCE",$sformatf("printing from sequence with soft reset\n %s", req.sprint()),UVM_LOW)
 finish_item(req);
end
endtask

