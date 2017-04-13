//-----------------------------------------------------------------------------
// File          : instruction_decoder.v
// Creation date : 13.04.2017
// Creation time : 15:14:12
// Description   : 
// Created by    : TermosPullo
// Tool : Kactus2 3.4.79 32-bit
// Plugin : Verilog generator 2.0d
// This file was generated based on IP-XACT component tut.fi:core:instruction_decoder:1.0
// whose XML file is D:/kactus2Repos/ipxactexamplelib/tut.fi/core/instruction_decoder/1.0/instruction_decoder.1.0.xml
//-----------------------------------------------------------------------------

module instruction_decoder #(
    parameter                              REGISTER_ID_WIDTH = 4,    // Bits reserved for identification a single register.
    parameter                              LITERAL_WIDTH    = 16,    // How long literals the instructions may have.
    parameter                              OP_CODE_WIDTH    = 4,    // Bits reserved for operation identifiers.
    parameter                              INSTRUCTION_WIDTH = OP_CODE_WIDTH+2*REGISTER_ID_WIDTH+LITERAL_WIDTH,    // Total width of an instruction
    parameter                              DATA_WIDTH       = 16,    // Width for data in registers and instructions.
    parameter                              ALU_OP_WIDTH     = 4,    // Bits reserved for identification of alu operation
    parameter                              INSTRUCTION_ADDRESS_WIDTH = 8    // Width of an instruction address.
) (
    // Interface: cpu_clk_sink
    input                               clk_i,    // The mandatory clock, as this is synchronous logic.
    input                               rst_i,    // The mandatory reset, as this is synchronous logic.

    // Interface: cpu_system
    input          [DATA_WIDTH-1:0]     alu_status_i,
    input          [DATA_WIDTH-1:0]     load_value_i,
    input                               mem_rdy_i,
    output reg                          alu_active_o,
    output reg     [ALU_OP_WIDTH-1:0]   alu_op_o,
    output reg     [REGISTER_ID_WIDTH-1:0] choose_reg1_o,
    output reg     [REGISTER_ID_WIDTH-1:0] choose_reg2_o,
    output reg                          mem_active_o,
    output reg     [DATA_WIDTH:0]       register_value_o,
    output reg                          we_o,

    // These ports are not in any interface
    input          [INSTRUCTION_WIDTH-1:0] instruction_feed,
    output         [INSTRUCTION_ADDRESS_WIDTH-1:0] iaddr_o
);

// WARNING: EVERYTHING ON AND ABOVE THIS LINE MAY BE OVERWRITTEN BY KACTUS2!!!
    
    // The available instructions.
    parameter [OP_CODE_WIDTH-1:0]
        NOP         = 4'b0000, 
        SET         = 4'b0001, 
        LOAD        = 4'b0010, 
        STORE       = 4'b0011, 
        PLUS        = 4'b0100, 
        MINUS       = 4'b0101, 
        MUL         = 4'b0110, 
        DIV         = 4'b0111, 
        BRA         = 4'b1000, 
        BNE        = 4'b1001;

    integer instruction;
    integer reg1;
    integer reg2;
    integer literal;
    
    reg [INSTRUCTION_ADDRESS_WIDTH-1:0] instruction_pointer;
    
    assign iaddr_o = instruction_pointer;
    
    reg [DATA_WIDTH-1:0] last_alu;
    
    always @(posedge clk_i or posedge rst_i) begin
        if(rst_i == 1'b1) begin
            alu_active_o <= 0;
            alu_op_o <= 0;
            choose_reg1_o <= 0;
            choose_reg2_o <= 0;
            mem_active_o <= 0;
            we_o <= 0;
            instruction_pointer <= 0;
            last_alu <= 0;
        end
        else begin
            instruction = instruction_feed[LITERAL_WIDTH+2*REGISTER_ID_WIDTH+OP_CODE_WIDTH-1:LITERAL_WIDTH+2*REGISTER_ID_WIDTH];
            reg1 = instruction_feed[LITERAL_WIDTH+2*REGISTER_ID_WIDTH-1:LITERAL_WIDTH+REGISTER_ID_WIDTH];
            reg2 = instruction_feed[LITERAL_WIDTH+REGISTER_ID_WIDTH-1:LITERAL_WIDTH];
            literal = instruction_feed[LITERAL_WIDTH-1:0];
            
            if (mem_active_o)begin
                if (mem_rdy_i) begin
                    if (!we_o) begin
                        register_value_o[DATA_WIDTH] <= 1;
                        // Pass literal.
                        register_value_o[DATA_WIDTH-1:0] <= load_value_i;
                    end
                    else begin
                        register_value_o <= 0;
                    end
                    mem_active_o= 0;
                    instruction_pointer = instruction_pointer + 1;
                end
            end
            else begin
                // Pass the register choise.
                choose_reg1_o <= reg1;
                choose_reg2_o <= reg2;
                
                // Pass ALU operation: It should be part of the instruction, if any.
                alu_op_o <= instruction[ALU_OP_WIDTH-1:0];

                // Activate ALU if arithmetic operation.
                if (instruction == PLUS ||
                    instruction == MINUS ||
                    instruction == MUL ||
                    instruction == DIV)
                begin
                    alu_active_o <= 1;
                end
                else begin
                    alu_active_o <= 0;
                end
                
                // Activate memory controller if memory operation.
                if (instruction == LOAD ||
                    instruction == STORE)
                begin
                    mem_active_o <= 1;
                end
                else begin
                    mem_active_o <= 0;
                    instruction_pointer = instruction_pointer + 1;
                end
                
                // Activate write enable if storing to memory.
                if (instruction == STORE) begin
                    we_o <= 1;
                end
                else begin
                    we_o <= 0;
                end
                
                // Signify if passing a literal.
                if (instruction == SET) begin
                    register_value_o[DATA_WIDTH] <= 1;
                    // Pass literal.
                    register_value_o[DATA_WIDTH-1:0] <= literal;
                end
                else begin
                    register_value_o[DATA_WIDTH] <= 0;
                end
                
                last_alu <= alu_status_i;
            end
        end
    end
endmodule
