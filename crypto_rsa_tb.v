///////////////////////////////////////////////////////////////////////////////
//
//  Module:         crypto_rsa_tb
//
//  Description:    Testbench for functional testing of crypto_rsa module.
//
//  Authors:        Saptarashmi Bandyopadhyay, Asmit De
//  Date:           09/15/2019
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
`define WIDTH 32

module crypto_rsa_tb ();

reg [`WIDTH - 1 : 0] key;
reg [`WIDTH - 1 : 0] n;
reg [`WIDTH - 1 : 0] plaintext;
reg                  clk;
reg                  reset;
reg                  load;
reg                  encrypt;
wire                  ready;
wire [`WIDTH - 1 : 0] ciphertext;

crypto_rsa t_crypto_rsa(clk, key, n, plaintext, reset, load, encrypt, ready, ciphertext);
defparam t_crypto_rsa.WIDTH = `WIDTH;

initial begin
    clk         = 0;
    key         = 7;
    plaintext   = 9;
    n           = 143;
    reset       = 1;
    load        = 0;
    encrypt     = 0;

#5  reset       = 0;
    load        = 1;

#5  load        = 0;

#5  encrypt     = 1;

#5  encrypt     = 0;
end

always #5 clk   = ~clk;

endmodule // crypto_rsa_tb
