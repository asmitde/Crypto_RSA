///////////////////////////////////////////////////////////////////////////////
//
//  Module:         crypto_rsa
//
//  Description:    This module is the top-level module that performs
//                  encryption on a plaintext 32-bit word using modular
//                  exponentiation. The key, modulus and plaintext are
//                  provided as input.
//
//  Authors:        Saptarashmi Bandyopadhyay, Asmit De
//  Date:           09/15/2019
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
`define WIDTH   32

module crypto_rsa (
    input   clk,
    input   [`WIDTH - 1 : 0] key,
    input   [`WIDTH - 1 : 0] n,
    input   [`WIDTH - 1 : 0] plaintext,
    input   reset,      // Resets all internal registers to 0.
    input   load,       // Loads data into registers.
    input   encrypt,    // Signals the mod_exp module to run.
    output  ready,      // Indicates completion of encryption.
    output  [`WIDTH - 1 : 0] ciphertext
);

parameter WIDTH = `WIDTH;

reg [WIDTH - 1 : 0] _key;
reg [WIDTH - 1 : 0] _n;
reg [WIDTH - 1 : 0] _plaintext;

mod_exp encrypt_rsa(clk, _plaintext, _key, _n, encrypt, ready, ciphertext);
defparam encrypt_rsa.WIDTH = `WIDTH;

always @(posedge clk) begin
    if (reset) begin
        _key        <= 0;
        _n          <= 0;
        _plaintext  <= 0;
    end
    else
    if (load) begin
        _key        <= key;
        _n          <= n;
        _plaintext  <= plaintext;
    end
end

endmodule // crypto_rsa
