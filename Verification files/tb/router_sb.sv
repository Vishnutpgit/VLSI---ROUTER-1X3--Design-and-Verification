class router_sb extends uvm_scoreboard ;

 `uvm_component_utils(router_sb)

   uvm_tlm_analysis_fifo #(write_xtn) fifo_wrh[] ;
   uvm_tlm_analysis_fifo #(read_xtn) fifo_rdh[] ;
 
   router_env_config m_cfg;
   write_xtn wr_xtn ;
   read_xtn rd_xtn ;
   write_xtn wr_cov ;
   read_xtn rd_cov ;

covergroup wr_cov_grp ;

 option.per_instance = 1 ;

 channel: coverpoint wr_cov.header[1:0] { bins zero = {2'b00};
                                          bins one  = {2'b01};
                                          bins two  = {2'b10}; }

 payload_size: coverpoint wr_cov.header[7:2] { bins small_pkt  = {[1:15]};
                                               bins medium_pkt = {[16:30]};
                                               bins big_pkt    = {[31:63]}; }


 channelXpayload_size: cross channel,payload_size;

endgroup



covergroup rd_cov_grp ;

 option.per_instance = 1 ;

 channel: coverpoint rd_cov.header[1:0] { bins zero = {2'b00};
                                          bins one  = {2'b01};
                                          bins two  = {2'b10}; }

 payload_size: coverpoint rd_cov.header[7:2] { bins small_pkt  = {[1:15]};
                                               bins medium_pkt = {[16:30]};
                                               bins big_pkt    = {[31:63]}; }


 channelXpayload_size: cross channel,payload_size;

endgroup

 
extern function new(string name = "router_sb" , uvm_component parent = null );
extern function void build_phase(uvm_phase phase); 
extern task run_phase(uvm_phase phase);
extern task user_compare(write_xtn h1 , read_xtn h2);
endclass 

function router_sb::new(string name = "router_sb" , uvm_component parent = null );
 super.new(name,parent);
 wr_cov_grp = new();
 rd_cov_grp = new();
endfunction




function void router_sb::build_phase(uvm_phase phase);

 super.build_phase(phase);
 if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
 `uvm_fatal("ROUTER_SB","getting the config item is failed")

  fifo_wrh = new[m_cfg.no_of_src_agts];
  fifo_rdh = new[m_cfg.no_of_dst_agts];

  foreach(fifo_wrh[i]) 
     fifo_wrh[i] = new($sformatf("fifo_wrh[%od]",i),this); 

  foreach(fifo_rdh[i]) 
     fifo_rdh[i] = new($sformatf("fifo_rdh[%od]",i),this);

endfunction



task router_sb::run_phase(uvm_phase phase);

forever 
begin

 fork 
    begin
    fifo_wrh[0].get(wr_xtn);   
    wr_cov = wr_xtn ;
    wr_cov_grp.sample();
    $display("write_coverage = %f ", wr_cov_grp.get_coverage());
    end

    begin
     fork
      fifo_rdh[0].get(rd_xtn);
      fifo_rdh[1].get(rd_xtn);
      fifo_rdh[2].get(rd_xtn);
     join_any
     disable fork;
    rd_cov = rd_xtn;
    rd_cov_grp.sample();
    $display("read_coverage = %f ", rd_cov_grp.get_coverage());
    end
 join

 user_compare(wr_xtn,rd_xtn);
#450;
end

endtask


task router_sb::user_compare(write_xtn h1 , read_xtn h2);

if(h1.header == h2.header)
begin

 `uvm_info("COMPARE HEADER" , " Header is matched", UVM_LOW) 
  
  foreach(h1.payload[i]) begin
  if(h1.payload[i] == h2.payload[i])
 `uvm_info("COMPARE PAYLOADS" , $sformatf(" payload[%0d] is matched",i), UVM_LOW)
  else
 `uvm_error("COMPARE PAYLOADS" , $sformatf(" payload[%0d] is not matched",i))
  end

  if(h1.parity == h2.parity)
 `uvm_info("COMPARE PARITY" , " Parity is matched", UVM_LOW)
  else
 `uvm_error("COMPARE PARITY" , " Parity is not matched") 


end

else
  `uvm_error("COMPARE HEADER" , " Header is not matched")

endtask






