// Humidity Fuzzification Module
// Converts crisp humidity values to fuzzy membership values
// Membership Functions: Dry, Normal, Wet
`timescale 1ns/1ps
module humidity_fuzzifier (
    input wire [7:0] humidity,
    output reg [7:0] dry,
    output reg [7:0] normal,
    output reg [7:0] wet
);

    // Humidity ranges (assuming 0-255 scale, representing 0-100% RH)
    // Dry: 0-85 (peak at 0)
    // Normal: 43-170 (peak at 106)
    // Wet: 128-255 (peak at 255)
   
    parameter HUM_DRY_MAX = 85;
    parameter HUM_NORMAL_LOW = 43;
    parameter HUM_NORMAL_MID = 106;
    parameter HUM_NORMAL_HIGH = 170;
    parameter HUM_WET_MIN = 128;
   
    always @(*) begin
        // Dry membership function (decreasing ramp)
        if (humidity <= HUM_DRY_MAX) begin
            dry = 8'd255 - ((humidity * 8'd255) / HUM_DRY_MAX);
        end else begin
            dry = 8'd0;
        end
       
        // Normal membership function (triangular)
        if (humidity <= HUM_NORMAL_LOW) begin
            normal = 8'd0;
        end else if (humidity <= HUM_NORMAL_MID) begin
            normal = ((humidity - HUM_NORMAL_LOW) * 8'd255) / (HUM_NORMAL_MID - HUM_NORMAL_LOW);
        end else if (humidity <= HUM_NORMAL_HIGH) begin
            normal = 8'd255 - ((humidity - HUM_NORMAL_MID) * 8'd255) / (HUM_NORMAL_HIGH - HUM_NORMAL_MID);
        end else begin
            normal = 8'd0;
        end
       
        // Wet membership function (increasing ramp)
        if (humidity >= HUM_WET_MIN) begin
            wet = ((humidity - HUM_WET_MIN) * 8'd255) / (8'd255 - HUM_WET_MIN);
        end else begin
            wet = 8'd0;
        end
    end

endmodule
