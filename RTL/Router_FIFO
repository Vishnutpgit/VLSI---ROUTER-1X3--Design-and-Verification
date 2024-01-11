module router_fifo(clock, resetn,write_enb,read_enb, soft_reset,data_in,lfd_state,empty,full,data_out);
      input clock,resetn,write_enb,read_enb,soft_reset,lfd_state;
      input [7:0]data_in;
      output empty,full;
      output reg[7:0]data_out;
      
      integer i;
      reg lfd_state_s;
      reg[8:0]mem[63:0];
      reg [6:0]wr_ptr ;
      reg [6:0]rd_ptr;
      reg [7:0]fifo_cntr;  
      
always@(posedge clock)
   begin
   if(~resetn)
     begin
       wr_ptr<=7'b0000000;
       rd_ptr<=7'b0000000;
     end

   else if(soft_reset==1'b1)
   begin
       wr_ptr<=7'b0000000;
       rd_ptr<=7'b0000000;
    end

   else
   begin

    if(write_enb && !full)
    wr_ptr<= wr_ptr + 1'b1;
    else
    wr_ptr<=wr_ptr;
  
   if(read_enb && !empty)
    rd_ptr<=rd_ptr + 1'b1;
   else
    rd_ptr<=rd_ptr;

   end
  end

 always@(posedge clock)
   begin
     if(~resetn) 
     begin
      for(i=0;i<64;i=i+1)
        mem[i]<=9'b0;
      end
     else if(soft_reset==1'b1)
     begin
      for(i=0;i<64;i=i+1)
         mem[i]<=9'b0;
     end

    else 
    begin 
    if(write_enb && !full)
      {mem[wr_ptr[5:0]][8],mem[wr_ptr[5:0]][7:0] }<= {lfd_state_s,data_in};
      end

   end

always@(posedge clock)
  begin
  if(~resetn)
   fifo_cntr<=8'b0;

  else if(soft_reset==1'b1)
   fifo_cntr<=8'b0;

  else if(read_enb && ~empty)
   begin
    if(mem[rd_ptr[5:0]][8] == 1'b1)
      fifo_cntr <= mem[ rd_ptr[5:0]][7:2] + 1'b1;
    else if(fifo_cntr!=0)
      fifo_cntr <= fifo_cntr - 1'b1;
   end

  end 
   
wire w1= ((fifo_cntr==0) && (data_out!=0)) ? 1'b1 : 1'b0;
always@(posedge clock)
  begin
     if(~resetn)
       data_out<=8'b00000000;
     
     else if(soft_reset==1'b1)
       data_out<=8'b0; 

     else
      begin
       if(w1)
          data_out<= 8'b0;
       else if(read_enb && !empty)
         data_out<= mem[rd_ptr[5:0]];
      end  
   end      

always@(posedge clock)
begin
if(~resetn)
  lfd_state_s<=0;
else 
  lfd_state_s<=lfd_state;

end



  assign full= (wr_ptr == {~rd_ptr[6],rd_ptr[5:0]}) ? 1'b1 : 1'b0 ;
  assign empty=  (wr_ptr==rd_ptr)?1'b1:1'b0;   
   

endmodule



