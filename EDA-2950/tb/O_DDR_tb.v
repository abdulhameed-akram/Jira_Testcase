`timescale 1ns/1ps

module O_DDR_tb;

  // Ports
  reg CLK = 0;
  wire prim, behv;
  reg R;
  reg [1:0] DD = 2'd0;
  integer mismatch = 0;
  integer i;

  always #5 CLK = ~CLK;

  always @(CLK) begin
    compare(prim, behv);
  end

  initial begin
    begin
      $display ("Random input ");  
      R = 0;
      #2
      R = 1;
      #2

      for (i = 0; i < 20; i = i + 1) begin
        @(posedge CLK);
        DD <= $random;
      end
      repeat(2) @(posedge CLK);
      if (mismatch > 0) begin
      $display("-----------------Simulation Failed-----------------");
      end
      else begin
        $display("-----------------Simulation Passed-----------------");
      end
    end
  end

  initial begin
      $dumpfile("O_DDR.vcd");
      $dumpvars;
      #500;
      $display ("FINISH");
      $finish;
  end

  O_DDR O_DDR_dut1 (
    .D (DD),
    .R (R),
    .E (1'b1),
    .C (CLK),
    .Q (prim)
  );

  o_ddr o_ddr_dut2 (
    .data(DD),
    .rst(R),
    .en(1'b1),
    .clk(CLK),
    .Q(behv)
  );

task compare(prim, behv);
    if(prim !== behv) begin
        $display("Output Mismatch. dut1: %0h, dut2: %0h", prim, behv);
        mismatch = mismatch + 1;
    end
endtask

endmodule

module o_ddr (
  input wire [1:0]data, 
  input wire rst, 
  input wire en, 
  input wire clk, 
  output wire Q
  );

reg [1:0] temp;
reg  neg_dat;

always@(posedge clk or negedge rst) begin
  if (!rst)
    temp <= 2'd0;
  else if (en) begin
    temp <= data;
  end 
end

always@(negedge clk or negedge rst) begin
  if (!rst)
    neg_dat <= 1'd0;
  else if (en) begin
    neg_dat <= temp[1];
  end
end

assign Q = clk ? temp[0] : neg_dat;

endmodule