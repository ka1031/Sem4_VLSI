// Temperature Fuzzification Module
// Converts crisp temperature values to fuzzy membership values
// Membership Functions: Cold, Normal, Hot
`timescale 1ns/1ps
module temperature_fuzzifier (
    input wire [7:0] temperature,
    output reg [7:0] cold,
    output reg [7:0] normal,
    output reg [7:0] hot
);

    // Temperature ranges (assuming 0-255 scale)
    // Cold: 0-85 (peak at 0)
    // Normal: 43-170 (peak at 106)
    // Hot: 128-255 (peak at 255)
   
    parameter TEMP_COLD_MAX = 85;
    parameter TEMP_NORMAL_LOW = 43;
    parameter TEMP_NORMAL_MID = 106;
    parameter TEMP_NORMAL_HIGH = 170;
    parameter TEMP_HOT_MIN = 128;
   
    always @(*) begin
        // Cold membership function (decreasing ramp)
        if (temperature <= TEMP_COLD_MAX) begin
            cold = 8'd255 - ((temperature * 8'd255) / TEMP_COLD_MAX);
        end else begin
            cold = 8'd0;
        end
       
        // Normal membership function (triangular)
        if (temperature <= TEMP_NORMAL_LOW) begin
            normal = 8'd0;
        end else if (temperature <= TEMP_NORMAL_MID) begin
            normal = ((temperature - TEMP_NORMAL_LOW) * 8'd255) / (TEMP_NORMAL_MID - TEMP_NORMAL_LOW);
        end else if (temperature <= TEMP_NORMAL_HIGH) begin
            normal = 8'd255 - ((temperature - TEMP_NORMAL_MID) * 8'd255) / (TEMP_NORMAL_HIGH - TEMP_NORMAL_MID);
        end else begin
            normal = 8'd0;
        end
       
        // Hot membership function (increasing ramp)
        if (temperature >= TEMP_HOT_MIN) begin
            hot = ((temperature - TEMP_HOT_MIN) * 8'd255) / (8'd255 - TEMP_HOT_MIN);
        end else begin
            hot = 8'd0;
        end
    end

endmodule
