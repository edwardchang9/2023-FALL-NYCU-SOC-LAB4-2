

// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

`timescale 1 ns / 1 ps

module counter_la_fir_tb;
reg clock;
reg RSTB;
reg CSB;

reg power1, power2;

wire gpio;
wire uart_tx;
wire [37:0] mprj_io;
wire [15:0] checkbits;


reg signed [31:0] taps [0:10];
reg signed [31:0] golden_ans [0:63];
reg signed [31:0] data_in [0:63];

assign checkbits  = mprj_io[31:16];
assign uart_tx = mprj_io[6];

always #12.5 clock <= (clock === 1'b0);
integer i, j;
integer lat;
integer total_lat;
initial begin
    clock = 0;
end

	`ifdef ENABLE_SDF
initial begin
    $sdf_annotate("../../../sdf/user_proj_example.sdf", uut.mprj) ;
    $sdf_annotate("../../../sdf/user_project_wrapper.sdf", uut.mprj.mprj) ;
    $sdf_annotate("../../../mgmt_core_wrapper/sdf/DFFRAM.sdf", uut.soc.DFFRAM_0) ;
    $sdf_annotate("../../../mgmt_core_wrapper/sdf/mgmt_core.sdf", uut.soc.core) ;
    $sdf_annotate("../../../caravel/sdf/housekeeping.sdf", uut.housekeeping) ;
    $sdf_annotate("../../../caravel/sdf/chip_io.sdf", uut.padframe) ;
    $sdf_annotate("../../../caravel/sdf/mprj_logic_high.sdf", uut.mgmt_buffers.mprj_logic_high_inst) ;
    $sdf_annotate("../../../caravel/sdf/mprj2_logic_high.sdf", uut.mgmt_buffers.mprj2_logic_high_inst) ;
    $sdf_annotate("../../../caravel/sdf/mgmt_protect_hv.sdf", uut.mgmt_buffers.powergood_check) ;
    $sdf_annotate("../../../caravel/sdf/mgmt_protect.sdf", uut.mgmt_buffers) ;
    $sdf_annotate("../../../caravel/sdf/caravel_clocking.sdf", uut.clocking) ;
    $sdf_annotate("../../../caravel/sdf/digital_pll.sdf", uut.pll) ;
    $sdf_annotate("../../../caravel/sdf/xres_buf.sdf", uut.rstb_level) ;
    $sdf_annotate("../../../caravel/sdf/user_id_programming.sdf", uut.user_id_value) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_1[0] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_1[1] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[0] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[1] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[2] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[0] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[1] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[2] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[3] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[4] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[5] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[6] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[7] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[8] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[9] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[10] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[0] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[1] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[2] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[3] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[4] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[5] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[0] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[1] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[2] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[3] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[4] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[5] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[6] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[7] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[8] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[9] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[10] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[11] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[12] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[13] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[14] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[15] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_0[0] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_0[1] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[0] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[1] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[2] ) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_5) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_6) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_7) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_8) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_9) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_10) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_11) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_12) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_13) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_14) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_15) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_16) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_17) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_18) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_19) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_20) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_21) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_22) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_23) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_24) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_25) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_26) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_27) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_28) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_29) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_30) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_31) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_32) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_33) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_34) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_35) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_36) ;
    $sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_37) ;
end
	`endif 

// assign mprj_io[3] = 1'b1;
task gen_golden; begin
	taps[0] = 0;
	taps[1] = -10;
	taps[2] = -9;
	taps[3] = 23;
	taps[4] = 56;
	taps[5] = 63;
	taps[6] = 56;
	taps[7] = 23;
	taps[8] = -9;
	taps[9] = -10;
	taps[10] = 0;

	for(i=0; i<64; i=i+1) begin
		golden_ans[i] = 0;
		data_in[i] = 1;
	end

	for(i=0; i<64; i=i+1) begin
		for(j=0; j<11; j=j+1) begin
			if(i-j>=0)
			    golden_ans[i] += data_in[i-j] * taps[j];
		end
	end

end endtask
// lat_count part 
integer iter;
initial begin
    
    total_lat = 0;
    for(iter=0;iter<3;iter=iter+1) begin
        lat = 0;
        wait(checkbits[7:0] == 'hA5);
        $display("[INFO] start input pat %1d",iter+1);
        while(checkbits[7:0] != 'h5A) begin
            lat = lat + 1;
            @(posedge clock);
        end
        total_lat = total_lat + lat;
        $display("[INFO] Latency of this pat : %5d",lat);
    end
    $display("[INFO] Total Latency : %7d",total_lat);
end



initial begin
    $dumpfile("counter_la_fir.vcd");
    $dumpvars(0, counter_la_fir_tb);

    // Repeat cycles of 1000 clock edges as needed to complete testbench
    repeat (250) begin
        repeat (10000) @(posedge clock);
        // $display("+10000 cycles");
    end
    $display("%c[1;31m",27);
		`ifdef GL
    $display ("[ERROR] Monitor: Timeout, Test FIR (GL) Failed");
		`else
    $display ("[ERROR] Monitor: Timeout, Test FIR (RTL) Failed");
		`endif
    $display("%c[0m",27);
    $finish;
end
integer pat_cnt;
initial begin
    wait(checkbits == 16'hAB40);
    $display("----------FIR Test started----------");
    gen_golden;
    for(pat_cnt=0;pat_cnt<3;pat_cnt=pat_cnt+1) begin
        for(i=0; i<64; i=i+1) begin
            // $display("curr golden : %d",golden_ans[i][15:0]);
            wait(checkbits == golden_ans[i][15:0]);
            $display("[\033[1;32mPASS\033[0m] output %2d pass",i+1);
        end
        $display("[INFO] pat %1d pass XD",pat_cnt+1);
    end
    



    wait(checkbits == 16'hAB51);
    $display("----------FIR Test passed----------");
    #10000;
    $finish;
end

initial begin
    RSTB <= 1'b0;
    CSB  <= 1'b1;		// Force CSB high
    #2000;
    RSTB <= 1'b1;	    	// Release reset
    #170000;
    CSB = 1'b0;		// CSB can be released
end

initial begin		// Power-up sequence
    power1 <= 1'b0;
    power2 <= 1'b0;
    #200;
    power1 <= 1'b1;
    #200;
    power2 <= 1'b1;
end

wire flash_csb;
wire flash_clk;
wire flash_io0;
wire flash_io1;

wire VDD1V8;
wire VDD3V3;
wire VSS;

assign VDD3V3 = power1;
assign VDD1V8 = power2;
assign VSS = 1'b0;

assign mprj_io[3] = 1;  // Force CSB high.
assign mprj_io[0] = 0;  // Disable debug mode

caravel uut (
            /*
            		.vddio	  (VDD3V3),
            		.vddio_2  (VDD3V3),
            		.vssio	  (VSS),
            		.vssio_2  (VSS),
            		.vdda	  (VDD3V3),
            		.vssa	  (VSS),
            		.vccd	  (VDD1V8),
            		.vssd	  (VSS),
            		.vdda1    (VDD3V3),
            		.vdda1_2  (VDD3V3),
            		.vdda2    (VDD3V3),
            		.vssa1	  (VSS),
            		.vssa1_2  (VSS),
            		.vssa2	  (VSS),
            		.vccd1	  (VDD1V8),
            		.vccd2	  (VDD1V8),
            		.vssd1	  (VSS),
            		.vssd2	  (VSS),
            */
            .clock    (clock),
            .gpio     (gpio),
            .mprj_io  (mprj_io),
            .flash_csb(flash_csb),
            .flash_clk(flash_clk),
            .flash_io0(flash_io0),
            .flash_io1(flash_io1),
            .resetb	  (RSTB)
        );

spiflash #(
             .FILENAME("counter_la_fir.hex")
         ) spiflash (
             .csb(flash_csb),
             .clk(flash_clk),
             .io0(flash_io0),
             .io1(flash_io1),
             .io2(),			// not used
             .io3()			// not used
         );

// Testbench UART
tbuart tbuart (
           .ser_rx(uart_tx)
       );

endmodule
`default_nettype wire
