class read_xtn extends uvm_sequence_item ;
  
  `uvm_object_utils(read_xtn)

   bit[7:0] header;
   bit[7:0] payload[];
   bit[7:0] parity;
  
  static rand bit[4:0] no_of_cycles;

extern function new(string name = "read_xtn");
extern function void do_print(uvm_printer printer );

endclass 

function read_xtn::new(string name = "read_xtn");
 super.new(name);
endfunction


function void read_xtn::do_print(uvm_printer printer );
 super.do_print(printer);

 printer.print_field("header" ,   this.header  , 8 ,UVM_DEC);
 printer.print_field("dst_address" , this.header[1:0] ,2 ,UVM_DEC);
 printer.print_field("payload size", this.header[7:2] ,6 ,UVM_DEC);

foreach(this.payload[i])begin 
printer.print_field($sformatf("payload[%0d]",i) ,this.payload[i], 8, UVM_DEC );
end

printer.print_field("parity" , this.parity ,8 ,UVM_DEC );
printer.print_field("no_of_cycles" , this.no_of_cycles , 5 , UVM_DEC );

endfunction 


  



