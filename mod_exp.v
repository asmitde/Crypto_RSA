///////////////////////////////////////////////////////////////////////////////
//
//  Module:         mod_exp
//
//  Description:    This module performs a modular exponentiation
//                  based on the right-to-left binary method.
//
//  Authors:        Saptarashmi Bandyopadhyay, Asmit De
//  Date:           09/14/2019
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
`define IDLE    1'b0
`define WORKING 1'b1
`define WIDTH   32

module mod_exp (
    input   clk,
    input   [`WIDTH - 1 : 0] base,
    input   [`WIDTH - 1 : 0] exponent,
    input   [`WIDTH - 1 : 0] modulo,
    input   valid,  // Indicates a valid data on the input port.
    output  ready,  // Signals the module is done with current computation and ready to accept new data.
    output  [`WIDTH - 1 : 0] result
);

parameter WIDTH = `WIDTH;

reg [WIDTH * 2 - 1 : 0] _base;
reg [WIDTH * 2 - 1 : 0] _exponent;
reg [WIDTH * 2 - 1 : 0] _result;
reg                     _status;

assign result   = _result;
assign ready    = (_status == `IDLE) ? 1'b1 : 1'b0;

initial _status = `IDLE;

always @(posedge clk) begin
    if (valid && ready) begin
        _base       <= base % modulo;
        _exponent   <= exponent;
        _result     <= 64'b1;
        _status     <= `WORKING;
    end
    else
        case (_status)
            `WORKING: begin
                if (_exponent >> 1 == 64'b0)
                    _status <= `IDLE;

                    if (_exponent[0] == 1'b1)
                        _result <= (_result * _base) % modulo;

                    _base       <= (_base * _base) % modulo;
                    _exponent   <= _exponent >> 1;
            end

            `IDLE:
                    _status <= `IDLE;
        endcase
end

endmodule // mod_exp
