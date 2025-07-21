
module ethernet_reg
(
    input   clk, resetn,

    output[31:0] dbg_rxs_status_word,
    
    output[47:0] dbg_rx_eth_dst,
    output[47:0] dbg_rx_eth_src,    
    output[15:0] dbg_rx_eth_type,
    
    output[15:0] dbg_arp_req_hw,
    output[15:0] dbg_arp_req_prot,
    output[ 7:0] dbg_arp_req_hw_len,
    output[ 7:0] dbg_arp_req_prot_len,
    output[15:0] dbg_arp_req_opcode,
    output[47:0] dbg_arp_req_sender_mac,
    output[31:0] dbg_arp_req_sender_ip,
    output[47:0] dbg_arp_req_target_mac,
    output[31:0] dbg_arp_req_target_ip,


    output[15:0] dbg_inc_ip4_ver_dsf,
    output[15:0] dbg_inc_ip4_length,
    output[15:0] dbg_inc_ip4_id,
    output[15:0] dbg_inc_ip4_flags,
    output[15:0] dbg_inc_ip4_ttl_prot,
    output[15:0] dbg_inc_ip4_checksum,
    output[31:0] dbg_inc_ip4_src_ip,
    output[31:0] dbg_inc_ip4_dst_ip,

    output[15:0] dbg_ping_req_type,
    output[15:0] dbg_ping_req_id,
    output[15:0] dbg_ping_req_seq,

    output       dbg_is_icmp_ping,


    // The received-packet status stream
    input[31:0]  rxs_tdata,
    input        rxs_tlast,
    input        rxs_tvalid,
    output reg   rxs_tready,

    // The received-packet data stream
    input[31:0]  rxd_tdata,
    input        rxd_tlast,
    input        rxd_tvalid,
    output reg   rxd_tready,


    // The transmit control stream
    output reg[31:0] txc_tdata,
    output    [ 3:0] txc_tkeep,
    output           txc_tlast,
    output           txc_tvalid,
    input            txc_tready,

    // The transmit data stream
    output reg[31:0] txd_tdata,
    output reg[ 3:0] txd_tkeep,
    output           txd_tlast,
    output           txd_tvalid,
    input            txd_tready
);
genvar i;

//===================================================================
// Function to swap the endian-ness of a 32-bit value
//===================================================================
function [31:0] swap;
    input[31:0] value;
    swap = {value[7:0], value[15:8], value[23:16], value[31:24]};
endfunction
//===================================================================

localparam[15:0] ETH_TYPE_ARP = 16'h0806;
localparam[15:0] ETH_TYPE_IP4 = 16'h0800;
localparam[15:0] ARP_TYPE_REQ = 1;
localparam[15:0] ARP_TYPE_RSP = 2;
localparam[ 7:0] PROT_PING = 1;
localparam[ 7:0] PROT_UDP  = 17;
localparam[ 7:0] PING_REQ  = 8;

localparam PACKET_WORDS  = 16;
localparam ARP_WORDS     = 11;
localparam PING_WORDS    = 11;

reg[1:0]   fsm_state;
localparam FSM_IDLE          = 0;
localparam FSM_RESPOND       = 1;
localparam FSM_WAIT_FOR_XMIT = 2;

// Strobe these for 1 cycle to initiate the corresponding packet
reg send_arp_response;
reg send_ping_response;

// The status word of the most recently received packet
reg[31:0] rxs_status_word;

// The MAC address and IP address of this device
reg[31:0] local_ip  = 32'h0C_0C_0C_07;
reg[47:0] local_mac = 48'hC1_C2_C3_C4_C5_C6;

// The packet data of the most recently received packet
reg[31:0] packet[0:PACKET_WORDS - 1];

//----------------------------------------------------------------------------
// Break out the fields of the 14-byte Ethernet header on the received packet
//----------------------------------------------------------------------------
wire[47:0] rx_eth_dst, rx_eth_src;
wire[15:0] rx_eth_type; 

assign
{
    rx_eth_dst,
    rx_eth_src,
    rx_eth_type
} = {
    packet[0], packet[1], packet[2], packet[3][31:16]
};
//----------------------------------------------------------------------------


//----------------------------------------------------------------------------
// Break out the fields of an IPv4 header
//----------------------------------------------------------------------------
wire[15:0] inc_ip4_ver_dsf;
wire[15:0] inc_ip4_length;
wire[15:0] inc_ip4_id;
wire[15:0] inc_ip4_flags;
wire[15:0] inc_ip4_ttl_prot;
wire[15:0] inc_ip4_checksum;
wire[31:0] inc_ip4_src_ip;
wire[31:0] inc_ip4_dst_ip;

assign
{
    inc_ip4_ver_dsf,
    inc_ip4_length,
    inc_ip4_id,
    inc_ip4_flags,
    inc_ip4_ttl_prot,
    inc_ip4_checksum,
    inc_ip4_src_ip,
    inc_ip4_dst_ip
} = {
    packet[3][15:0],
    packet[4], packet[5], packet[6], packet[7],
    packet[8][31:16]
};
//----------------------------------------------------------------------------


//----------------------------------------------------------------------------
// Break out the fields of an ICMP ping
//----------------------------------------------------------------------------
wire[15:0] ping_req_type;
wire[15:0] ping_req_checksum;
wire[15:0] ping_req_id;
wire[15:0] ping_req_seq;

assign 
{
    ping_req_type,
    ping_req_checksum,
    ping_req_id,
    ping_req_seq
} = {
    packet[8][15:0],
    packet[9],
    packet[10][31:16]
};
//----------------------------------------------------------------------------


// This is asserted when we've received an IPv4 ICMP ping request
wire is_icmp_ping = (rx_eth_type           == ETH_TYPE_IP4) 
                  & (inc_ip4_ttl_prot[7:0] == PROT_PING   )
                  & (ping_req_type[15:8]   == PING_REQ    )
                  & (inc_ip4_dst_ip        == local_ip    );


//----------------------------------------------------------------------------
// Breakout the fields of an ARP request
//----------------------------------------------------------------------------
wire[15:0] arp_req_hw;
wire[15:0] arp_req_prot;
wire[ 7:0] arp_req_hw_len;
wire[ 7:0] arp_req_prot_len;
wire[15:0] arp_req_opcode;
wire[47:0] arp_req_sender_mac;
wire[31:0] arp_req_sender_ip;
wire[47:0] arp_req_target_mac;
wire[31:0] arp_req_target_ip;

assign
{
    arp_req_hw,
    arp_req_prot,
    arp_req_hw_len,
    arp_req_prot_len,
    arp_req_opcode,
    arp_req_sender_mac,
    arp_req_sender_ip,
    arp_req_target_mac,
    arp_req_target_ip
} = 
{
    packet[3][15:0],
    packet[4], packet[5], packet[6], packet[7], packet[8], packet[9],
    packet[10][31:16]
};
//----------------------------------------------------------------------------

// This is asserted when we've received an IPv4 ARP request
wire is_arp_request = (rx_eth_type       == ETH_TYPE_ARP) 
                    & (arp_req_prot      == ETH_TYPE_IP4)
                    & (arp_req_opcode    == ARP_TYPE_REQ)
                    & (arp_req_target_ip == local_ip    );



//----------------------------------------------------------------------------
// This is an ARP response and consists of 11 32-bit words for a total of
// 44 bytes.   Only 42 bytes are actually transmitted on the wire.
//----------------------------------------------------------------------------
wire[ARP_WORDS*32-1:0] arp_rsp =
{
    rx_eth_src,     // Destination MAC
    local_mac,      // Source MAC
    ETH_TYPE_ARP,   // This is an ARP packet
    16'h0001,       // Hardware type is "Ethernet"
    ETH_TYPE_IP4,   // Protocol is "IPv4"
    16'h0604,       // MAC is 6 bytes long, IP addr is 4 bytes long
    ARP_TYPE_RSP,   // This is an ARP response
    local_mac,
    local_ip,
    arp_req_sender_mac,
    arp_req_sender_ip,
    16'h0000        // Pads this to a multiple of 32-bits
};
//----------------------------------------------------------------------------

// Here we break "arp_rsp" into an array of 32-bit words
wire[31:0] arp_rsp_word[0:ARP_WORDS-1];
for (i=0; i<ARP_WORDS; i=i+1) begin
    assign arp_rsp_word[i] = arp_rsp[(ARP_WORDS-1-i)*32 +: 32];
end
//----------------------------------------------------------------------------


//----------------------------------------------------------------------------
// IPv4 headers - These are valid any time after we've received the relevant
// packet
//----------------------------------------------------------------------------
wire[159:0] ping_rsp_ip4;
make_ip4_header#(PROT_PING) make_ip4_0(ping_rsp_ip4, local_ip, inc_ip4_src_ip, 8);
//----------------------------------------------------------------------------


//----------------------------------------------------------------------------
// This is a ping response and consists of 11 32-bit words for a total of
// 44 bytes.   Only 42 bytes are actually transmitted on the wire.
//----------------------------------------------------------------------------
// Compute the 32-bit 
wire[31:0] ping_cs32 = ping_req_id + ping_req_seq;
wire[15:0] ping_checksum = ~(ping_cs32[31:16] + ping_cs32[15:0]);

wire[PING_WORDS*32-1:0] ping_rsp = 
{
    // Ethernet header (14 bytes)
    rx_eth_src,     
    local_mac,      
    ETH_TYPE_IP4,   
    
    // IPv4 Header (20 bytes)
    ping_rsp_ip4,

    // ICMP ping header (8 bytes)
    16'h0000,
    ping_checksum,
    ping_req_id,
    ping_req_seq,

    // Padding in order to make this a multiple of 32-bits
    16'h0000
};

// Here we break "arp_rsp" into an array of 32-bit words
wire[31:0] ping_rsp_word[0:PING_WORDS-1];
for (i=0; i<PING_WORDS; i=i+1) begin
    assign ping_rsp_word[i] = ping_rsp[(PING_WORDS-1-i)*32 +: 32];
end
//----------------------------------------------------------------------------



//================================================================================================
// This state machine reads a packet in from the receive-status stream.   It saves the status-word
// from that packet, and turns on tready for the receive-data stream.
//
// This state machine starts when "fsm_state" is FSM_IDLE
//================================================================================================
reg[3:0] rssm_beat;
reg[1:0] rssm_state;
//------------------------------------------------------------------------------------------------
always @(posedge clk) begin


    // In reset, we're not ready to read either stream
    if (resetn == 0) begin
        rxs_tready <= 0;
        rxd_tready <= 0;
        rssm_state <= 0;
    end
  
    // Examine the state of the "receive-status" state machine
    else case (rssm_state) 


        // If we've been told to ingest a packet, enable tready on the
        // packet status stream and go to the next state
        0:  if (fsm_state == FSM_IDLE) begin
                rxs_tready <= 1;
                rxd_tready <= 0;
                rssm_beat  <= 0;
                rssm_state <= 1;
            end


        // Here we wait for beats to arrive on the status stream.   When we recive word 3
        // we save the status word, and enable tready on the packet data stream.
        //
        // On the last beat of the status data, we disable packet-status tready
        1:  if (rxs_tvalid & rxs_tready) begin
                if (rssm_beat == 3) begin
                    rxs_status_word <= rxs_tdata;
                    rxd_tready      <= 1;
                end

                if (rxs_tlast) begin
                    rxs_tready <= 0;
                    rssm_state <= 2;
                end else
                    rssm_beat  <= rssm_beat + 1;                 
            end

        // On the last beat of the received packet data, we
        // go back to waiting for the signal to inject a new
        // packet
        2:  if (rxd_tvalid & rxd_tready & rxd_tlast) begin
                rxd_tready <= 0;
                rssm_state <= 0;
            end

    endcase
end
//================================================================================================



//================================================================================================
// This block ingests packet data from the rxd stream and stuffs it into the packet[] array
//
// The 32-bit words are converted from little-endian to big-endian before storing them
//================================================================================================
reg[15:0] rdsm_beat;
always @(posedge clk) begin
    
    if (rxd_tready == 0)
        rdsm_beat <= 0;
    
    else if (rxd_tvalid & rxd_tready & (rdsm_beat < PACKET_WORDS)) begin 
        packet[rdsm_beat] <= swap(rxd_tdata);
        rdsm_beat         <= rdsm_beat + 1;
    end
end
//================================================================================================


//================================================================================================
// This is the state machine that waits for Ethernet packets to arrive and handles them
//================================================================================================
always @(posedge clk) begin

    // These will strobe high for exactly one cycle
    send_arp_response  <= 0;
    send_ping_response <= 0;

    if (resetn == 0)
        fsm_state <= 0;
    else case(fsm_state)

        // Wait for a packet to arrive, then determine what to do with it
        FSM_IDLE:
            if (rxd_tready & rxd_tvalid & rxd_tlast) begin
                fsm_state <= FSM_RESPOND;
            end

        FSM_RESPOND:
            if (is_arp_request) begin
                send_arp_response <= 1;
                fsm_state         <= FSM_WAIT_FOR_XMIT;
            end else

            if (is_icmp_ping) begin
                send_ping_response <= 1;
                fsm_state          <= FSM_WAIT_FOR_XMIT;
            end else
                fsm_state         <= FSM_IDLE;


        // Wait for the response packet to finish transmitting
        FSM_WAIT_FOR_XMIT:
            if (txd_tready & txd_tvalid & txd_tlast)
                fsm_state <= FSM_IDLE;

    endcase

end
//================================================================================================


//================================================================================================
// This block sends 6 control words to the transmit-control stream any time that a packet
// is about to be transmitted.  The first control word is 0xA000_0000, and the rest are 0x0
//================================================================================================
reg      tcsm_state;
reg[3:0] txc_beat;
//------------------------------------------------------------------------------------------------
always @(posedge clk) begin

    if (resetn == 0)
        tcsm_state <= 0;
    else case(tcsm_state)

        0:  if (send_arp_response | send_ping_response) begin
                txc_beat   <= 0;
                txc_tdata  <= 32'hA000_0000;
                tcsm_state <= 1;
            end

        1:  if (txc_tvalid & txc_tready) begin
                if (txc_tlast)
                    tcsm_state <= 0;
                else begin
                    txc_beat  <= txc_beat + 1;
                    txc_tdata <= 0;
                end
            end
    endcase

end
//------------------------------------------------------------------------------------------------
assign txc_tlast  = (tcsm_state == 1) & (txc_beat == 5);
assign txc_tvalid = (tcsm_state == 1) & (resetn   == 1);
assign txc_tkeep  = 4'b1111;
//================================================================================================





//================================================================================================
// This state machine transmits outgoing packet data
//================================================================================================
reg[1:0]   tx_type;
localparam TX_ARP  = 0;
localparam TX_PING = 1;
localparam TX_UDP  = 2;

reg        tdsm_state;
localparam TDSM_IDLE = 0;
localparam TDSM_SEND = 1;

reg[15:0] txd_beat, txd_final_beat;
//------------------------------------------------------------------------------------------------
always @(posedge clk) begin

    if (resetn == 0)
        tdsm_state <= 0;
    else case(tdsm_state)

        TDSM_IDLE:
            if (send_arp_response) begin
                tx_type        <= TX_ARP;
                txd_beat       <= 0;
                txd_final_beat <= ARP_WORDS - 1;
                tdsm_state     <= TDSM_SEND;
            end 

            else if (send_ping_response) begin
                tx_type        <= TX_PING;
                txd_beat       <= 0;
                txd_final_beat <= PING_WORDS - 1;
                tdsm_state     <= TDSM_SEND;
            end

        TDSM_SEND:
            if (txd_tvalid & txd_tready) begin
                if (txd_tlast)
                    tdsm_state <= TDSM_IDLE;
                else 
                    txd_beat   <= txd_beat + 1;
            end
    endcase

end
//------------------------------------------------------------------------------------------------
assign txd_tvalid = (tdsm_state != TDSM_IDLE) & (resetn == 1);
assign txd_tlast  = (tdsm_state != TDSM_IDLE) & (txd_beat == txd_final_beat);

// Set the value of txd_tdata
always @* begin
    txd_tdata = 0;
    if (tdsm_state == TDSM_SEND) begin
        case (tx_type)
            TX_ARP:  txd_tdata = swap( arp_rsp_word[txd_beat]);
            TX_PING: txd_tdata = swap(ping_rsp_word[txd_beat]);
        endcase
    end
end

// Set the value of txd_tkeep
always @* begin
    txd_tkeep = 4'b1111;
    if (tdsm_state == TDSM_SEND && txd_tlast) begin
        case (tx_type)
            TX_ARP:  txd_tkeep = 4'b0011;
            TX_PING: txd_tkeep = 4'b0011;
        endcase
    end
end
//================================================================================================







assign dbg_rxs_status_word = rxs_status_word;
assign dbg_rx_eth_dst      = rx_eth_dst     ;
assign dbg_rx_eth_src      = rx_eth_src     ;
assign dbg_rx_eth_type     = rx_eth_type    ;

assign dbg_arp_req_hw         = arp_req_hw        ;    
assign dbg_arp_req_prot       = arp_req_prot      ;         
assign dbg_arp_req_hw_len     = arp_req_hw_len    ;         
assign dbg_arp_req_prot_len   = arp_req_prot_len  ;         
assign dbg_arp_req_opcode     = arp_req_opcode    ;      
assign dbg_arp_req_sender_mac = arp_req_sender_mac;           
assign dbg_arp_req_sender_ip  = arp_req_sender_ip ;          
assign dbg_arp_req_target_mac = arp_req_target_mac;           
assign dbg_arp_req_target_ip  = arp_req_target_ip ;                

assign dbg_is_icmp_ping       = is_icmp_ping;


assign dbg_inc_ip4_ver_dsf  = inc_ip4_ver_dsf ;       
assign dbg_inc_ip4_length   = inc_ip4_length  ;        
assign dbg_inc_ip4_id       = inc_ip4_id      ;      
assign dbg_inc_ip4_flags    = inc_ip4_flags   ;          
assign dbg_inc_ip4_ttl_prot = inc_ip4_ttl_prot;            
assign dbg_inc_ip4_checksum = inc_ip4_checksum;            
assign dbg_inc_ip4_src_ip   = inc_ip4_src_ip  ;            
assign dbg_inc_ip4_dst_ip   = inc_ip4_dst_ip  ;

assign dbg_ping_req_type    = ping_req_type;
assign dbg_ping_req_id      = ping_req_id;
assign dbg_ping_req_seq     = ping_req_seq;


endmodule
