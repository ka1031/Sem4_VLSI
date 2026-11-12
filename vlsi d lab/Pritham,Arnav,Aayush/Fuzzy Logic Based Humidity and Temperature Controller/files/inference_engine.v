// Fuzzy Inference Engine
// Implements fuzzy rules using MIN operator for AND, MAX for OR
// Rule Base: 9 rules (3x3 matrix)
`timescale 1ns/1ps
module inference_engine (
    input wire [7:0] temp_cold,
    input wire [7:0] temp_normal,
    input wire [7:0] temp_hot,
    input wire [7:0] hum_dry,
    input wire [7:0] hum_normal,
    input wire [7:0] hum_wet,
    output wire [7:0] rule0,
    output wire [7:0] rule1,
    output wire [7:0] rule2,
    output wire [7:0] rule3,
    output wire [7:0] rule4,
    output wire [7:0] rule5,
    output wire [7:0] rule6,
    output wire [7:0] rule7,
    output wire [7:0] rule8
);

    // Fuzzy Rules using Mamdani inference
    // Rule format: IF (Temperature is X) AND (Humidity is Y) THEN (Output is Z)
   
    // Rule 0: IF temp is COLD AND humidity is DRY THEN heater HIGH, humidifier HIGH
    assign rule0 = min_op(temp_cold, hum_dry);
   
    // Rule 1: IF temp is COLD AND humidity is NORMAL THEN heater HIGH
    assign rule1 = min_op(temp_cold, hum_normal);
   
    // Rule 2: IF temp is COLD AND humidity is WET THEN heater HIGH, dehumidifier HIGH
    assign rule2 = min_op(temp_cold, hum_wet);
   
    // Rule 3: IF temp is NORMAL AND humidity is DRY THEN humidifier MEDIUM
    assign rule3 = min_op(temp_normal, hum_dry);
   
    // Rule 4: IF temp is NORMAL AND humidity is NORMAL THEN all OFF (ideal state)
    assign rule4 = min_op(temp_normal, hum_normal);
   
    // Rule 5: IF temp is NORMAL AND humidity is WET THEN dehumidifier MEDIUM
    assign rule5 = min_op(temp_normal, hum_wet);
   
    // Rule 6: IF temp is HOT AND humidity is DRY THEN cooler HIGH, humidifier HIGH
    assign rule6 = min_op(temp_hot, hum_dry);
   
    // Rule 7: IF temp is HOT AND humidity is NORMAL THEN cooler HIGH
    assign rule7 = min_op(temp_hot, hum_normal);
   
    // Rule 8: IF temp is HOT AND humidity is WET THEN cooler HIGH, dehumidifier HIGH
    assign rule8 = min_op(temp_hot, hum_wet);
   
    // MIN operator function
    function [7:0] min_op;
        input [7:0] a, b;
        begin
            min_op = (a < b) ? a : b;
        end
    endfunction

endmodule
