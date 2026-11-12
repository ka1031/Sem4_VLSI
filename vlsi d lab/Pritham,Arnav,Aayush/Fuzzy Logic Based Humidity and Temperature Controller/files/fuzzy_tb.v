// Testbench for Fuzzy Logic Controller
// Tests various temperature and humidity combinations

`timescale 1ns/1ps

module fuzzy_controller_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg [7:0] temperature;
    reg [7:0] humidity;
    wire [7:0] heater_power;
    wire [7:0] cooler_power;
    wire [7:0] humidifier_power;
    wire [7:0] dehumidifier_power;
    
    // Declare loop variable here for Verilog compatibility
    integer i; 
   
    // Instantiate the fuzzy controller
    fuzzy_controller uut (
        .clk(clk),
        .rst(rst),
        .temperature(temperature),
        .humidity(humidity),
        .heater_power(heater_power),
        .cooler_power(cooler_power),
        .humidifier_power(humidifier_power),
        .dehumidifier_power(dehumidifier_power)
    );
   
    // Clock generation (50 MHz = 20ns period)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
   
    // Test stimulus
    initial begin
        // Initialize waveform dump
        $dumpfile("fuzzy_controller.vcd");
        $dumpvars(0, fuzzy_controller_tb);
      
        // Display header
        $display("=====================================");
        $display("Fuzzy Controller Simulation Started");
        $display("=====================================");
        $display("Time\tTemp\tHumid\tHeater\tCooler\tHumid\tDehumid");
        $display("----\t----\t-----\t------\t------\t-----\t-------");
      
        // Initialize signals
        rst = 1;
        temperature = 8'd0;
        humidity = 8'd0;
      
        // Reset sequence
        #40 rst = 0;
        #20;
      
        // Test Case 1: Cold and Dry
        temperature = 8'd30;
        humidity = 8'd30;
        #40;
        $display("%0t\t%d\t%d\t%d\t%d\t%d\t%d", $time, temperature, humidity,
                 heater_power, cooler_power, humidifier_power, dehumidifier_power);
      
        // Test Case 2: Cold and Normal
        temperature = 8'd40;
        humidity = 8'd106;
        #40;
        $display("%0t\t%d\t%d\t%d\t%d\t%d\t%d", $time, temperature, humidity,
                 heater_power, cooler_power, humidifier_power, dehumidifier_power);
      
        // Test Case 3: Cold and Wet
        temperature = 8'd50;
        humidity = 8'd200;
        #40;
        $display("%0t\t%d\t%d\t%d\t%d\t%d\t%d", $time, temperature, humidity,
                 heater_power, cooler_power, humidifier_power, dehumidifier_power);
      
        // Test Case 4: Normal and Dry
        temperature = 8'd106;
        humidity = 8'd40;
        #40;
        $display("%0t\t%d\t%d\t%d\t%d\t%d\t%d", $time, temperature, humidity,
                 heater_power, cooler_power, humidifier_power, dehumidifier_power);
      
        // Test Case 5: Normal and Normal
        temperature = 8'd106;
        humidity = 8'd106;
        #40;
        $display("%0t\t%d\t%d\t%d\t%d\t%d\t%d", $time, temperature, humidity,
                 heater_power, cooler_power, humidifier_power, dehumidifier_power);
      
        // Test Case 6: Normal and Wet
        temperature = 8'd106;
        humidity = 8'd200;
        #40;
        $display("%0t\t%d\t%d\t%d\t%d\t%d\t%d", $time, temperature, humidity,
                 heater_power, cooler_power, humidifier_power, dehumidifier_power);
      
        // Test Case 7: Hot and Dry
        temperature = 8'd200;
        humidity = 8'd30;
        #40;
        $display("%0t\t%d\t%d\t%d\t%d\t%d\t%d", $time, temperature, humidity,
                 heater_power, cooler_power, humidifier_power, dehumidifier_power);
      
        // Test Case 8: Hot and Normal
        temperature = 8'd220;
        humidity = 8'd106;
        #40;
        $display("%0t\t%d\t%d\t%d\t%d\t%d\t%d", $time, temperature, humidity,
                 heater_power, cooler_power, humidifier_power, dehumidifier_power);
      
        // Test Case 9: Hot and Wet
        temperature = 8'd240;
        humidity = 8'd220;
        #40;
        $display("%0t\t%d\t%d\t%d\t%d\t%d\t%d", $time, temperature, humidity,
                 heater_power, cooler_power, humidifier_power, dehumidifier_power);
      
        // Test Case 10: Sweep through temperatures
        $display("\n--- Temperature Sweep (Humidity = 106) ---");
        humidity = 8'd106;
        for (i = 0; i < 256; i = i + 32) begin
            temperature = i;
            #40;
            $display("%0t\t%d\t%d\t%d\t%d\t%d\t%d", $time, temperature, humidity,
                     heater_power, cooler_power, humidifier_power, dehumidifier_power);
        end
      
        // Test Case 11: Sweep through humidity
        $display("\n--- Humidity Sweep (Temperature = 106) ---");
        temperature = 8'd106;
        for (i = 0; i < 256; i = i + 32) begin
            humidity = i;
            #40;
            $display("%0t\t%d\t%d\t%d\t%d\t%d\t%d", $time, temperature, humidity,
                     heater_power, cooler_power, humidifier_power, dehumidifier_power);
        end
      
        // End simulation
        #100;
        $display("\n=====================================");
        $display("Simulation Completed Successfully");
        $display("=====================================");
        $finish;
    end
   
    // Monitor for debugging
    initial begin
        $monitor("Time=%0t Temp=%d Hum=%d | Heat=%d Cool=%d Humid=%d Dehum=%d",
                 $time, temperature, humidity, heater_power, cooler_power,
                 humidifier_power, dehumidifier_power);
    end

endmodule
