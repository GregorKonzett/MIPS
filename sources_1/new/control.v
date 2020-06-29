module control (
    input wire clk,
    input wire[5:0] op,
    output reg pcWriteCond,
    output reg pcWrite,
    output reg IorD,
    output reg memRead,
    output reg memWrite,
    output reg memToReg,
    output reg irWrite,
    output reg[1:0] pcSource,
    output reg[1:0] aluOp,
    output reg[1:0] aluSrcB,
    output reg aluSrcA,
    output reg regWrite,
    output reg regDst
    );
    
    reg[3:0] state;
    reg[3:0] nextState;
    
    parameter InstructionFetch = 4'b0000;
    parameter InstructionDecode = 4'b0001;
    parameter MemoryAddressComputation = 4'b0010;
    parameter MemoryAccessRead = 4'b0011;
    parameter MemoryReadCompletion = 4'b0100;
    parameter MemoryAccessWrite = 4'b0101;
    parameter Execution = 4'b0110;
    parameter RType = 4'b0111;
    parameter BranchCompletion = 4'b1000;
    parameter JumpCompletion = 4'b1001;
    parameter AddiExecute = 4'b1010;
    parameter AddiWrite = 4'b1011;
    
    initial state = InstructionFetch;
    
    // State machine
    always @(posedge clk)
    begin
        state <= nextState;
    end
    
    always @(state, op) begin
        case(state)
            InstructionFetch: nextState <= InstructionDecode;
            InstructionDecode: begin
                case(op)
                    6'b000000: nextState <= RType;
                    6'b001000: nextState <= AddiExecute;
                    6'b100011: nextState <= MemoryAddressComputation;
                    6'b101011: nextState <= MemoryAddressComputation;
                    6'b000100: nextState <= BranchCompletion;
                    6'b000010: nextState <= JumpCompletion;
                    default: nextState <= InstructionFetch;
                endcase
            end
            MemoryAddressComputation: begin
                case(op)
                    6'b100011: nextState <= MemoryAccessRead;
                    6'b101011: nextState <= MemoryAccessWrite;
                    default: nextState <= InstructionFetch;
                endcase
            end
            MemoryAccessRead: nextState <= InstructionFetch;
            MemoryReadCompletion: nextState <= InstructionFetch;
            MemoryAccessWrite: nextState <= InstructionFetch;
            Execution: nextState <= RType;
            RType: nextState <= InstructionFetch;
            BranchCompletion: nextState <= InstructionFetch;
            JumpCompletion: nextState <= InstructionFetch;
            default: nextState <= InstructionFetch;
        endcase
    end
    
    //Control Outputs
    always @(state)
    begin
        pcWriteCond = 0;
        pcWrite = 0;
        IorD = 0;
        memRead = 0;
        memWrite = 0;
        memToReg = 0;
        irWrite = 0;
        pcSource = 2'b00;
        aluOp = 2'b00;
        aluSrcB = 2'b00;
        aluSrcA = 0;
        regWrite = 0;
        regDst = 0;
        
        case(state)
            InstructionFetch: begin
                irWrite = 1;
                aluSrcB = 2'b01;
                pcWrite = 1;
                memRead = 1;
            end
            InstructionDecode: begin
                aluSrcB = 2'b11;
            end
            MemoryAddressComputation: begin
                aluSrcA = 1;
                aluSrcB = 2'b10;
            end
            MemoryAccessRead: begin
                IorD = 1;
                memRead = 1;
            end
            MemoryReadCompletion: begin
                regWrite = 1;
                memToReg = 1;
            end
            MemoryAccessWrite: begin
                IorD = 1;
                memWrite = 1;
            end
            Execution: begin
                aluSrcA = 1;
                aluOp = 2'b10;
            end
            RType: begin
                regDst = 1;
                regWrite = 1;
            end
            BranchCompletion: begin
                aluSrcA = 1;
                aluOp = 2'b01;
                pcWriteCond = 1;
                pcSource = 2'b01;
            end
            JumpCompletion: begin
                pcWrite = 1;
                pcSource = 2'b10;
            end
            AddiExecute: begin
                aluSrcA = 1;
                aluSrcB = 2'b10;
            end
            AddiWrite: begin
                regWrite = 1;
            end
        endcase
    end
endmodule