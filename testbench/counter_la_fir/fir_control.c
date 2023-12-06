// #include "fir.h"

// void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {
// 	//initial your fir
// 	for(int i=0; i<N; i=i+1){
// 		inputbuffer[i] = 0;
// 		outputsignal[i] = 0;
// 	}
// }

// int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
// 	// initfir();
// 	//write down your fir
// 	for(int idx = 0; idx < N ; idx ++){
// 		for(int i=N-1; i > 0;i--){ // shift the data to be calculate in fir process
// 			inputbuffer[i] = inputbuffer[i-1];
// 		}
// 		inputbuffer[0] = inputsignal[idx];
// 		for(int cnt = 0; cnt < N; cnt ++){ // fir mult
// 			outputsignal[idx] += inputbuffer[cnt] * taps[cnt];
// 		}
// 	}
	
// 	return outputsignal;
// }
		



#include "fir.h"
#include <defs.h>
void __attribute__((section(".mprjram"))) initfir()
{
	// initial your fir
	for (int i = 0; i < N; i++)
	{
		inputsignal[i] = 0;
		outputsignal[i] = 0;
	}


}

int *__attribute__((section(".mprjram"))) fir()
{
	taps_0 = 0;
	taps_1 = -10;
	taps_2 = -9;
	taps_3 = 23;
	taps_4 = 56;
	taps_5 = 63;
	taps_6 = 56;
	taps_7 = 23;
	taps_8 = -9;
	taps_9 = -10;
	taps_10 = 0;
	
	datalength = 64;
	
	initfir();
	reg_mprj_datal = 0x00A50000;
	config = 0x00000001;
	int program_config; // this defines in def.h
	// write down your fir
	for(int i = 0;i < N ; i++){
		inputsignal[i] = 1;
	}
	program_config = config;
	for(int i = 0; i < N; i++){
		//3. RISC V sends X[n] to FIR (note: make sure FIR is readily to accept X[n))
		while(!((program_config >> 4) & 0x00000001))/*not ready to send input to fir.v   -> check config[4]*/ 
			program_config = config; // refresh config
		d_in = inputsignal[i];
		//4. RISC V receives Y[n] from FIR (note: make sure Y[n] is ready)
		while(!((program_config >> 5) & 0x00000001)) /*not ready to read output from fir.v -> check config[5]*/
			program_config = config; // refresh config
		outputsignal[i] = d_out; 
	}
	// 6. When finish, write final Y (Y[7:0] output to mprj [31:24]), EndMark ((‘h5A mprj [23:16]),
	program_config = config;
	reg_mprj_datal = ((0x000000ff && outputsignal[63]) << 24) | 0x005A0000; // finish

	return outputsignal;
}