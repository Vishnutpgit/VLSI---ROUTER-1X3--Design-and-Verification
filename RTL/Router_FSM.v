module router_FSM(clock, resetn,pkt_valid,parity_done,data_in,soft_reset_0,soft_reset_1,soft_reset_2,
               fifo_full,low_pkt_valid,fifo_empty_0,fifo_empty_1,fifo_empty_2,detect_add,ld_state,
               laf_state,full_state,
                write_enb_reg,rst_int_reg,lfd_state,busy);

             
 input clock,resetn,pkt_valid,parity_done ,soft_reset_0,soft_reset_1,soft_reset_2,
          fifo_full,low_pkt_valid,fifo_empty_0,fifo_empty_1,fifo_empty_2;
 input [1:0]data_in;
 output detect_add,ld_state,laf_state,full_state,write_enb_reg,rst_int_reg,lfd_state,busy;

parameter DECODE_ADDRESS=3'b000,
          LOAD_FIRST_DATA=3'b001,
          LOAD_DATA=3'b010,
          FIFO_FULL_STATE=3'b011,
          LOAD_AFTER_FULL=3'b100,
          LOAD_PARITY=3'b101,
          CHECK_PARITY_ERROR=3'b110,
          WAIT_TILL_EMPTY=3'b111;

reg [2:0] p_state ,n_state ;

always@(posedge clock)
 begin
 if(~resetn)
     p_state<=DECODE_ADDRESS;
 else if((soft_reset_0 && data_in==2'b00)||(soft_reset_1 && data_in==2'b01)||(soft_reset_2 && data_in==2'b10))
     p_state<=DECODE_ADDRESS;
 else 
     p_state<=n_state;

 end


always@(*)
begin
if(data_in!=2'b11)
begin


case(p_state)

DECODE_ADDRESS://000
 begin
if((pkt_valid && (data_in[1:0]==2'b00) && fifo_empty_0)
  |(pkt_valid && (data_in[1:0]==2'b01) && fifo_empty_1) 
  |(pkt_valid && (data_in[1:0]==2'b10) && fifo_empty_2))
          n_state= LOAD_FIRST_DATA;//001

else if((pkt_valid && (data_in[1:0]==2'b00) && (~fifo_empty_0)) 
       |(pkt_valid && (data_in[1:0]==2'b01) && (~fifo_empty_1))
       |(pkt_valid && (data_in[1:0]==2'b10) && (~fifo_empty_2))) 
          n_state= WAIT_TILL_EMPTY;//111

else
          n_state= DECODE_ADDRESS;//000

end
WAIT_TILL_EMPTY:begin//111
    if((data_in[1:0]==2'b00) && (fifo_empty_0) 
       |((data_in[1:0]==2'b01) && (fifo_empty_1)
       |(data_in[1:0]==2'b10) && (fifo_empty_2)))
      n_state=LOAD_FIRST_DATA;//001
    else 
    n_state=WAIT_TILL_EMPTY;//111
  end 


LOAD_FIRST_DATA: begin//001
         n_state= LOAD_DATA;//010
         end

LOAD_DATA : begin//010
       if(fifo_full)
       n_state= FIFO_FULL_STATE;//011
       else if (!fifo_full && !pkt_valid)
       n_state= LOAD_PARITY;//101
       else
       n_state= LOAD_DATA;//010
   end

FIFO_FULL_STATE: begin//011
      if(!fifo_full)
      n_state=LOAD_AFTER_FULL;//100
      else
      n_state=FIFO_FULL_STATE;//011
     end


LOAD_AFTER_FULL: begin//100
      if(!parity_done && !low_pkt_valid)
      n_state=LOAD_DATA;//010
      else if(!parity_done && low_pkt_valid)
      n_state=LOAD_PARITY;//101
     else if(parity_done)
      n_state=DECODE_ADDRESS;//000
      else 
      n_state=LOAD_AFTER_FULL;//100
    end


LOAD_PARITY: begin//101
     n_state=CHECK_PARITY_ERROR;//110
     end


CHECK_PARITY_ERROR: begin//110
    if(fifo_full)
    n_state=FIFO_FULL_STATE;//011
    else if(!fifo_full)
    n_state=DECODE_ADDRESS;//000
    else
    n_state=CHECK_PARITY_ERROR;//110
   end


default : n_state=DECODE_ADDRESS;//000
endcase
end
else 
begin
	n_state=DECODE_ADDRESS;
end	
end




assign detect_add     = (p_state==DECODE_ADDRESS) ? 1'b1 : 1'b0 ;
assign lfd_state      = (p_state== LOAD_FIRST_DATA) ? 1'b1 : 1'b0 ;
assign ld_state       = (p_state== LOAD_DATA) ? 1'b1 : 1'b0 ;
assign full_state     = (p_state== FIFO_FULL_STATE) ? 1'b1 : 1'b0 ;
assign laf_state      = (p_state== LOAD_AFTER_FULL) ? 1'b1 : 1'b0 ;
assign rst_int_reg    = (p_state== CHECK_PARITY_ERROR) ? 1'b1 : 1'b0 ;
assign write_enb_reg  = (p_state== LOAD_DATA|p_state== LOAD_AFTER_FULL|p_state== LOAD_PARITY) ? 1'b1 : 1'b0 ;
assign busy  = (p_state== LOAD_FIRST_DATA| p_state== LOAD_AFTER_FULL| p_state== FIFO_FULL_STATE| 
                 p_state== LOAD_PARITY| p_state== CHECK_PARITY_ERROR| p_state== WAIT_TILL_EMPTY) ? 1'b1 : 1'b0 ;


endmodule

 
