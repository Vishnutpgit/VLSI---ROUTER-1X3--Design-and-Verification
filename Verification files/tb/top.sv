module top ;

import router_pkg::*;

import uvm_pkg::*;

bit clock;
 always
   #10 clock = !clock; 

router_src_if in0 (clock);
router_dst_if in1 (clock);
router_dst_if in2 (clock);
router_dst_if in3 (clock);


Router_top DUT ( .clock(clock),  .resetn(in0.resetn),  .read_enb_0(in1.read_enb),  .read_enb_1(in2.read_enb),
                 .read_enb_2(in3.read_enb),  .pkt_valid(in0.pkt_valid),  .data_in(in0.data_in),  .data_out_0(in1.data_out)      ,  
                 .data_out_1(in2.data_out),  .data_out_2(in3.data_out),   .valid_out_0(in1.valid_out),  
                 .valid_out_1(in2.valid_out),  .valid_out_2(in3.valid_out),  .error(in0.error),  .busy(in0.busy));



  
initial 
   begin
    
   `ifdef VCS
      $fsdbDumpvars(0,top);
    $fsdbDumpSVA(0,top);
   `endif

  uvm_config_db #(virtual router_src_if)::set(null,"*","vif0",in0);
  uvm_config_db #(virtual router_dst_if)::set(null,"*","vif1",in1);
  uvm_config_db #(virtual router_dst_if)::set(null,"*","vif2",in2);
  uvm_config_db #(virtual router_dst_if)::set(null,"*","vif3",in3);

  run_test();
end

endmodule



