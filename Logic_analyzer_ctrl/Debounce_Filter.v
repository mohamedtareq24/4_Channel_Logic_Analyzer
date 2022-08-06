module Debounce_Switch (
    input clk,
    input i_Switch, //this is the bouncy signal 
    output o_Switch
);

parameter c_debounce_limit = 500000;//10ms = 500,000 clock cycles

// r_state & r_counter are regs as they are assigned in always block
reg  r_State = 1'b0;      //state of switch can either be 0 or 1
reg [18:0] r_Count = 0;   //the counter needs to count till 500,000 so, we need 19 bits 

always @(posedge clk) 
    begin
        if (i_Switch !== r_State && r_Count < c_debounce_limit ) //if the switch is still debouncing, then conitnoue counting
            r_Count <= r_Count + 1; //Counter

        else if(r_Count == c_debounce_limit)
        begin
            r_Count <= 0;
            r_State <= i_Switch; // get a new sample and store it in r_state
        end

        else
            r_Count <= 0; //define all posiilitites to avoid latches
    end

assign o_Switch = r_State;

endmodule
//we gat a sample of i_switch and stored it in r_state
//if the i_switch keeps changing so, the counter will countinoue counting