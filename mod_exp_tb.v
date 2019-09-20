///////////////////////////////////////////////////////////////////////////////
//
//  Module:         mod_exp_tb
//
//  Description:    Testbench for functional testing of mod_exp module.
//
//  Authors:        Saptarashmi Bandyopadhyay, Asmit De
//  Date:           09/15/2019
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
`define WIDTH 32

module mod_exp_tb ();

reg [`WIDTH - 1 : 0] base;
reg [`WIDTH - 1 : 0] exponent;
reg [`WIDTH - 1 : 0] modulo;
reg                  clk;
reg                  valid;
wire                  ready;
wire [`WIDTH - 1 : 0] result;

mod_exp t_mod_exp(clk, base, exponent, modulo, valid, ready, result);
defparam t_mod_exp.WIDTH = `WIDTH;

initial begin
    clk         = 0;
    base        = 4;
    exponent    = 13;
    modulo      = 497;
    valid       = 0;
#5  valid       = 1;
#5  valid       = 0;
end

always #5 clk   = ~clk;


endmodule // mod_exp_tb
