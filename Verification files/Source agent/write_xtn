class write_xtn extends uvm_sequence_item ;
  
  `uvm_object_utils(write_xtn)
   
   rand bit [7:0] header ;
   rand bit [7:0] payload[] ;
   bit [7:0] parity;

   constraint a { header[1:0] != 2'b11 ;
                  header[7:2] inside {[1:63]} ;
                  payload.size == header[7:2]  ;
                }


function new(string name = "write_xtn");
super.new(name);
endfunction

function void post_randomize();
  parity = header ^ 8'b0 ;
 foreach(payload[i]) begin
  parity = payload[i] ^ parity ;
 end
endfunction

function void do_print (uvm_printer printer);
super.do_print(printer);

                  //field_name                     //value           //size    //radix
printer.print_field("header" ,                    this.header ,         8,    UVM_DEC   ) ;

printer.print_field("dst address" ,               this.header[1:0] ,      2,    UVM_DEC   ) ;

printer.print_field("payload size ",              this.payload.size,     6,    UVM_DEC   ) ;

foreach(this.payload[i]) begin
printer.print_field($sformatf("payload[%d]",i) ,  this.payload[i],       8,    UVM_DEC   ) ;
end

printer.print_field("parity" ,                    this.parity,           8,    UVM_DEC   ) ;

endfunction

endclass


