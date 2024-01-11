module Router_top(clock,resetn,read_enb_0,read_enb_1,read_enb_2,pkt_valid,data_in,data_out_0,data_out_1,data_out_2,valid_out_0,valid_out_1,valid_out_2,error,busy);

input clock,resetn,read_enb_0,read_enb_1,read_enb_2,pkt_valid;
input [7:0]data_in;
output  [7:0]data_out_0,data_out_1,data_out_2;
output  busy,error,valid_out_0,valid_out_1,valid_out_2;

wire empty0,empty1,empty2;
wire full0,full1,full2;
wire [7:0]d_out;
wire lfd;
wire softr0,softr1,softr2;
wire [2:0]wr_enb;
wire par_dn;
wire f_full;
wire lp_valid;
wire ld;
wire laf;
wire full_s;
wire wr_en_reg;
wire rst_reg;
wire d_add;
router_fifo rtr_fifo1(.clock(clock), .resetn(resetn),.write_enb(wr_enb[0]),.read_enb(read_enb_0), .soft_reset(softr0),.data_in(d_out),.lfd_state(lfd),.empty(empty0)
                                       ,.full(full0),.data_out(data_out_0));


router_fifo rtr_fifo2(.clock(clock), .resetn(resetn),.write_enb(wr_enb[1]),.read_enb(read_enb_1), .soft_reset(softr1),.data_in(d_out),.lfd_state(lfd),.empty(empty1)
                                      ,.full(full1),.data_out(data_out_1));


router_fifo rtr_fifo3(.clock(clock), .resetn(resetn),.write_enb(wr_enb[2]),.read_enb(read_enb_2), .soft_reset(softr2),.data_in(d_out),.lfd_state(lfd),.empty(empty2)
                                        ,.full(full2),.data_out(data_out_2));

router_FSM rtr_fsm(.clock(clock), .resetn(resetn),.pkt_valid(pkt_valid),.parity_done(par_dn),.data_in(data_in[1:0]),.soft_reset_0(softr0),.soft_reset_1(softr1),.soft_reset_2(softr2),
               .fifo_full(f_full),.low_pkt_valid(lp_valid),.fifo_empty_0(empty0),.fifo_empty_1(empty1),.fifo_empty_2(empty2),.detect_add(d_add),.ld_state(ld),
               .laf_state(laf),.full_state(full_s),
                .write_enb_reg(wr_en_reg),.rst_int_reg(rst_reg),.lfd_state(lfd),.busy(busy));


router_reg rtr_reg(.clock(clock),.resetn(resetn),.pkt_valid(pkt_valid),.data_in(data_in),.fifo_full(f_full),.rst_int_reg(rst_reg),.detect_add(d_add),.ld_state(ld),
                 .laf_state(laf),.full_state(full_s),.lfd_state(lfd),.parity_done(par_dn),.low_pkt_valid(lp_valid),.err(error),.dout(d_out));



router_synch rtr_synch(.clock(clock),.resetn(resetn), .detect_add(d_add), .data_in(data_in[1:0]),.write_enb_reg(wr_en_reg), .read_enb_0(read_enb_0),.read_enb_1(read_enb_1),
                      .read_enb_2(read_enb_2),.empty_0(empty0) ,.empty_1(empty1),.empty_2(empty2), .full_0(full0),.full_1(full1),.full_2(full2) ,
                       .fifo_full(f_full), .soft_reset_0(softr0) , .soft_reset_1(softr1), 
                      .soft_reset_2(softr2), .valid_out_0(valid_out_0) ,.valid_out_1(valid_out_1), .valid_out_2(valid_out_2),.write_enb(wr_enb));







endmodule

