module router_synch(clock,resetn, detect_add, data_in,write_enb_reg, read_enb_0,read_enb_1,read_enb_2,empty_0,empty_1,empty_2,
                     full_0,full_1,full_2 ,fifo_full, soft_reset_0 , soft_reset_1, soft_reset_2, valid_out_0 ,valid_out_1, valid_out_2,
                      write_enb);

input clock,resetn, detect_add,write_enb_reg;
input [1:0] data_in; 
input  read_enb_0,read_enb_1,read_enb_2,empty_0,empty_1,empty_2,
                     full_0,full_1,full_2 ;
output reg soft_reset_0 , soft_reset_1, soft_reset_2;
output reg [2:0] write_enb ;
output reg fifo_full;
output  valid_out_0 , valid_out_1, valid_out_2;


reg [1:0] int_add_reg; 

reg [4:0]timer0;
reg [4:0]timer1;
reg [4:0]timer2;

wire w0 = (timer0==5'd29) ? 1'b1: 1'b0;
wire w1 = (timer1==5'd29) ? 1'b1: 1'b0;
wire w2 = (timer2==5'd29) ? 1'b1: 1'b0;

always@(posedge clock)
begin
   if(~resetn)
       int_add_reg<=0;

   else if(detect_add)
     int_add_reg<= data_in;
end


always@(* )
begin
   write_enb<=3'b000;
  if(write_enb_reg)
    begin
    case(int_add_reg)
    2'b00 :  write_enb <= 3'b001;
    2'b01 :  write_enb <= 3'b010;
    2'b10 :  write_enb <= 3'b100;
    default : write_enb <= 3'b000;
    endcase
    end
end


always@(*)
begin
   case(int_add_reg)
   2'b00 :  fifo_full <= full_0;
   2'b01 :  fifo_full <= full_1;
   2'b10 :  fifo_full <= full_2;
   default :  fifo_full <= 0;
   endcase
end

assign valid_out_0=~empty_0;
assign valid_out_1=~empty_1;
assign valid_out_2=~empty_2;



always@(posedge clock)
begin
 if(~resetn)
    begin
    timer0<=0;
    soft_reset_0 <=0;
    end

 else if(valid_out_0)
      begin
        if(!read_enb_0)
         begin
             if(w0)
               begin
               soft_reset_0<=1'b1;
               timer0<=5'd0;
               end
             else 
                begin
                soft_reset_0<=1'b0;
                timer0<= timer0 + 5'd1;
                end
          end
       end
end

always@(posedge clock)
begin
 if(~resetn)
    begin
    timer1<=0;
    soft_reset_1<=0;
    end

 else if(valid_out_1)
      begin
        if(!read_enb_1)
         begin
             if(w1)
               begin
               soft_reset_1<=1'b1;
               timer1<=5'd0;
               end
             else 
                begin
                soft_reset_1<=1'b0;
                timer1<= timer1 + 5'd1;
                end
          end
       end
end



always@(posedge clock)
begin
 if(~resetn)
    begin
    timer2<=0;
    soft_reset_2<=0;
    end

 else if(valid_out_2)
      begin
        if(!read_enb_2)
         begin
             if(w2)
               begin
               soft_reset_2<=1'b1;
               timer2<=5'd0;
               end
             else 
                begin
                soft_reset_2<=1'b0;
                timer2<= timer2 + 5'd1;
                end
          end
       end
end


             
endmodule


