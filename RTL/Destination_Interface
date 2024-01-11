interface router_dst_if ( input bit clock) ;
   
   logic [7:0]data_out ;
   logic read_enb ;
   logic valid_out ;

 
clocking ddrv_cb @ (posedge clock);
 default input #1 output #1 ;
 input valid_out ;
 output read_enb;
endclocking 

clocking dmon_cb @ (posedge clock);
 default input #1 output #1 ;
 input data_out;
 input read_enb;
endclocking

modport DDRV_MP (clocking ddrv_cb );
 
modport DMON_MP (clocking dmon_cb );

endinterface


