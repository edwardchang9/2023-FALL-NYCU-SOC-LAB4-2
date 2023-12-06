// #ifndef __FIR_H__
// #define __FIR_H__

// #define N 11

// int taps[N] = {0,-10,-9,23,56,63,56,23,-9,-10,0};
// int inputbuffer[N];
// int inputsignal[N] = {1,2,3,4,5,6,7,8,9,10,11};
// int outputsignal[N];
// #endif
#ifndef __FIR_H__
#define __FIR_H__

#define N 64
// N stands for the number of data length
// int taps[11] = {0,-10,-9,23,56,63,56,23,-9,-10,0};
int taps_0 = 0;
int taps_1 = -10;
int taps_2 = -9;
int taps_3 = 23;
int taps_4 = 56;
int taps_5 = 63;
int taps_6 = 56;
int taps_7 = 23;
int taps_8 = -9;
int taps_9 = -10;
int taps_10 = 0;

int inputsignal[N];
int outputsignal[N];

#endif


// #ifndef __FIR_H__
// #define __FIR_H__
// #define N 20

// int taps[N] = {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0};
// int inputbuffer[N];
// int inputsignal[N] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20};
// int outputsignal[N];


// #endif