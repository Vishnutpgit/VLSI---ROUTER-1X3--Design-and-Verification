interface router_src_if(input bit clock);

logic pkt_valid;
logic [7:0]data_in;
logic resetn;
logic error;
logic busy;

clocking sdrv_cb @ (posedge clock);
  default input #1 output #1 ;
  output pkt_valid;
  output data_in;
  output resetn;
  input error ;
  input busy ;
endclocking


clocking smon_cb @ (posedge clock);
  default input #1 output #1 ;
  input pkt_valid;
  input data_in;
  input resetn;
  input error ;
  input busy ;
endclocking

modport SDRV_MP (clocking sdrv_cb );

modport SMON_MP (clocking smon_cb );

endinterface

 
