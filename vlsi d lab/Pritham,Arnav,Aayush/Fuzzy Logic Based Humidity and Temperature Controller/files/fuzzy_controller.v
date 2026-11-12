// Fuzzy Logic Based Humidity and Temperature Controller
// Main Controller Module
`timescale 1ns/1ps
module fuzzy_controller (
    input wire clk,
    input wire rst,
    input wire [7:0] temperature,    // 8-bit temperature input (0-255)
    input wire [7:0] humidity,       // 8-bit humidity input (0-255)
    output reg [7:0] heater_power,   // Heater control output
    output reg [7:0] cooler_power,   // Cooler control output
    output reg [7:0] humidifier_power, // Humidifier control output
    output reg [7:0] dehumidifier_power // Dehumidifier control output
);

    // Membership function outputs for Temperature
    wire [7:0] temp_cold, temp_normal, temp_hot;
   
    // Membership function outputs for Humidity
    wire [7:0] hum_dry, hum_normal, hum_wet;
   
    // Rule outputs
    wire [7:0] rule_out [0:8];
   
    // Instantiate Temperature Fuzzification
    temperature_fuzzifier temp_fuzz (
        .temperature(temperature),
        .cold(temp_cold),
        .normal(temp_normal),
        .hot(temp_hot)
    );
   
    // Instantiate Humidity Fuzzification
    humidity_fuzzifier hum_fuzz (
        .humidity(humidity),
        .dry(hum_dry),
        .normal(hum_normal),
        .wet(hum_wet)
    );
   
    // Instantiate Inference Engine
    inference_engine inference (
        .temp_cold(temp_cold),
        .temp_normal(temp_normal),
        .temp_hot(temp_hot),
        .hum_dry(hum_dry),
        .hum_normal(hum_normal),
        .hum_wet(hum_wet),
        .rule0(rule_out[0]),
        .rule1(rule_out[1]),
        .rule2(rule_out[2]),
        .rule3(rule_out[3]),
        .rule4(rule_out[4]),
        .rule5(rule_out[5]),
        .rule6(rule_out[6]),
        .rule7(rule_out[7]),
        .rule8(rule_out[8])
    );
   
    // Defuzzification and Output Control
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            heater_power <= 8'd0;
            cooler_power <= 8'd0;
            humidifier_power <= 8'd0;
            dehumidifier_power <= 8'd0;
        end else begin
            // Heater: High when cold
            heater_power <= temp_cold;
           
            // Cooler: High when hot
            cooler_power <= temp_hot;
           
            // Humidifier: High when dry
            humidifier_power <= hum_dry;
           
            // Dehumidifier: High when wet
            dehumidifier_power <= hum_wet;
        end
    end

endmodule
