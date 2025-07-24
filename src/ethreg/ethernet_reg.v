//================================================================================================
// ethernet_reg.v
// Author: D.Wolf
//
// This module is used to perform AXI register reads and writes when instructed to do so
// by messages received over Ethernet.
//
// The Ethernet interface to this module is the 4-stream mechanism provided by the Xilinx
// 1G/2.5G Ethernet MAC.   If you're using some other MAC, it should be possible to write 
// a shim module to convert the input/output of that MAC to the 4-stream mechanism that
// this module requires
//
// Features:
//    Will properly respond to ARP requests
//
//    Will properly respond to ICMP ping requests
//
//    For both reading and writing registers, addresses and data may be any combination of 32-bit
//       fields and 64-bit fields.  64-bit-data writes are handled as two consecutive 32-bit data
//       writes
//
//    Register read requests and register write requests both generate a response message
//
//    Register read/write messages are standard IPv4 UDP packets 
//
//    Local IP address can be changed on the fly at runtime
//
//================================================================================================

// Define this to add debug ports that break out Ethernet header fields
`define DEBUG_ETH

// Define this to add debug ports that break out ARP request fields
//`define DEBUG_ARP

// Define this to add debug ports that break out IPv4 header fields
//`define DEBUG_IP4

// Define this to add debug ports to break out ICMP Ping request fields
//`define DEBUG_PING

// Define this to add debug ports to break out UDP header fields
`define DEBUG_UDP

// Define this to add some miscellaneous debug ports
`define DEBUG_MISC

module ethernet_reg #
(
    parameter AW = 32,
    parameter DW = 32,
    parameter[31:0] DEFAULT_LOCAL_IP  = 32'h0C_0C_0C_07,
    parameter[47:0] DEFAULT_LOCAL_MAC = 48'h01_02_03_04_05_06
)
(
    input   clk, resetn,

    `ifdef DEBUG_MISC
        output[31:0] dbg_rxs_status_word,
        output       dbg_is_icmp_ping,
        output       dbg_is_arp_request,
        output       dbg_is_udp_rw,
    `endif


    `ifdef DEBUG_ETH
        output[47:0] dbg_rx_eth_dst,
        output[47:0] dbg_rx_eth_src,    
        output[15:0] dbg_rx_eth_type,
    `endif


    `ifdef DEBUG_ARP
        output[15:0] dbg_arp_req_hw,
        output[15:0] dbg_arp_req_prot,
        output[ 7:0] dbg_arp_req_hw_len,
        output[ 7:0] dbg_arp_req_prot_len,
        output[15:0] dbg_arp_req_opcode,
        output[47:0] dbg_arp_req_sender_mac,
        output[31:0] dbg_arp_req_sender_ip,
        output[47:0] dbg_arp_req_target_mac,
        output[31:0] dbg_arp_req_target_ip,
    `endif


    `ifdef DEBUG_IP4
        output[15:0] dbg_inc_ip4_ver_dsf,
        output[15:0] dbg_inc_ip4_length,
        output[15:0] dbg_inc_ip4_id,
        output[15:0] dbg_inc_ip4_flags,
        output[15:0] dbg_inc_ip4_ttl_prot,
        output[15:0] dbg_inc_ip4_checksum,
        output[31:0] dbg_inc_ip4_src_ip,
        output[31:0] dbg_inc_ip4_dst_ip,
    `endif


    `ifdef DEBUG_PING
        output[15:0] dbg_ping_req_type,
        output[15:0] dbg_ping_req_id,
        output[15:0] dbg_ping_req_seq,
    `endif


    `ifdef DEBUG_UDP
        output[15:0] dbg_inc_udp_src_port,
        output[15:0] dbg_inc_udp_dst_port,
        output[15:0] dbg_inc_udp_length,
    `endif

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
    input            txd_tready,



    //====================  An AXI-Lite Master Interface  ======================
    // "Specify write address"          -- Master --    -- Slave --
    output [AW-1:0]                     M_AXI_AWADDR,   
    output                              M_AXI_AWVALID,  
    output    [2:0]                     M_AXI_AWPROT,
    input                                               M_AXI_AWREADY,

    // "Write Data"                     -- Master --    -- Slave --
    output [DW-1:0]                     M_AXI_WDATA,
    output [DW/8-1:0]                   M_AXI_WSTRB,      
    output                              M_AXI_WVALID,
    input                                               M_AXI_WREADY,

    // "Send Write Response"            -- Master --    -- Slave --
    input  [1:0]                                        M_AXI_BRESP,
    input                                               M_AXI_BVALID,
    output                              M_AXI_BREADY,

    // "Specify read address"           -- Master --    -- Slave --
    output [AW-1:0]                     M_AXI_ARADDR,     
    output [   2:0]                     M_AXI_ARPROT,
    output                              M_AXI_ARVALID,
    input                                               M_AXI_ARREADY,

    // "Read data back to master"       -- Master --    -- Slave --
    input [DW-1:0]                                      M_AXI_RDATA,
    input                                               M_AXI_RVALID,
    input [1:0]                                         M_AXI_RRESP,
    output                              M_AXI_RREADY
    //==========================================================================

);
genvar i;


//==================  The AXI Master Control Interface  ====================
// AMCI signals for performing AXI writes
reg [AW-1:0]  AMCI_WADDR;
reg [DW-1:0]  AMCI_WDATA;
reg           AMCI_WRITE;
wire[   1:0]  AMCI_WRESP;
wire          AMCI_WIDLE;

// AMCI signals for performing AXI reads
reg [AW-1:0]  AMCI_RADDR;
reg           AMCI_READ ;
wire[DW-1:0]  AMCI_RDATA;
wire[   1:0]  AMCI_RRESP;
wire          AMCI_RIDLE;
//==========================================================================


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

// This is the UDP port that we listen for incoming packets on
localparam[15:0] UDP_SERVER_PORT = 16'h0122;

// An incoming packet is this many 32-bit words long
localparam PACKET_WORDS  = 16;

// An outgoing ARP response is this many 32-bit words long
localparam ARP_WORDS     = 11;

// An outgoing ICMP Ping response is this many 32-bit words long
localparam PING_WORDS    = 11;

// An outgoing UDP response is this many 32-bit words long
localparam UDP_RSP_WORDS = 16;

// Read/write command responses are this long
localparam RW_RESPONSE_LEN = UDP_RSP_WORDS * 4;

// The UDP packet length (not counting the Ethernet and IPv4 headers)
localparam UDP_RESPONSE_LEN = RW_RESPONSE_LEN - 14 - 20;

// Length of the payload in a UDP response packet (not counting Eth, IPv4, and UDP headers)
localparam UDP_PAYLOAD_LEN  = UDP_RESPONSE_LEN - 8;

// These are the opcodes for the commands we receive via UDP
localparam OP_WRITE32 = 1;
localparam OP_WRITE64 = 2;
localparam OP_READ32  = 3;
localparam OP_READ64  = 4;

// The states of the main state machine that handles incoming commands
reg[6:0]   fsm_state;
localparam FSM_IDLE          =   0;
localparam FSM_WRITE32       =  10;
localparam FSM_WRITE64       =  20;
localparam FSM_READ32        =  30;
localparam FSM_READ64        =  40;
localparam FSM_RESPOND       =  99;
localparam FSM_WAIT_FOR_XMIT = 100;

// Strobe this with one of the TX_nnn constants for 1 cycle to initiate
// transmission of the corresponding packet
reg[2:0]   send_packet;
localparam TX_ARP  = 1;
localparam TX_PING = 2;
localparam TX_UDP  = 3;

// The status word of the most recently received packet
reg[31:0] rxs_status_word;

// The MAC address and IP address of this device
reg[31:0]  local_ip  = DEFAULT_LOCAL_IP;
reg[47:0]  local_mac = DEFAULT_LOCAL_MAC;
localparam bcast_mac = 48'hFF_FF_FF_FF_FF_FF;

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
// Breakout the fields of a received ARP request
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


//----------------------------------------------------------------------------
// Break out the fields of a a received ICMP ping request
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


//----------------------------------------------------------------------------
// Break out the fields of a received IPv4 header (20 bytes)
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
// Break out the fields of a received UDP header (8 bytes)
//----------------------------------------------------------------------------
wire[15:0] inc_udp_src_port;
wire[15:0] inc_udp_dst_port;
wire[15:0] inc_udp_length;
wire[15:0] inc_udp_checksum;

assign
{
    inc_udp_src_port,
    inc_udp_dst_port,
    inc_udp_length,
    inc_udp_checksum
} = {
    packet[ 8][15:0],
    packet[ 9],
    packet[10][31:16]
};
//----------------------------------------------------------------------------


//----------------------------------------------------------------------------
// Break out the fields of a received register-read/write command (22 bytes)
//----------------------------------------------------------------------------
wire[ 7:0] rw_opcode;
wire[ 7:0] rw_error;
wire[15:0] rw_rsp_port;
wire[63:0] rw_address;
wire[63:0] rw_data;
wire[15:0] rw_reserved;

assign 
{
    rw_opcode,
    rw_error,
    rw_rsp_port,
    rw_address,
    rw_data,
    rw_reserved
} = {
    packet[10][15:0],
    packet[11], packet[12], packet[13], packet[14], packet[15]
};
//----------------------------------------------------------------------------

// This will be asserted if the current packet is intended for us
wire is_for_us = (rx_eth_dst == local_mac || rx_eth_dst == bcast_mac);

// This is asserted when we've received an IPv4 ICMP ping request
wire is_icmp_ping = is_for_us
                  & (rx_eth_type           == ETH_TYPE_IP4) 
                  & (inc_ip4_ttl_prot[7:0] == PROT_PING   )
                  & (ping_req_type[15:8]   == PING_REQ    )
                  & (inc_ip4_dst_ip        == local_ip    );

// This is asserted when we've received an IPv4 ARP request
wire is_arp_request = is_for_us
                    & (rx_eth_type       == ETH_TYPE_ARP) 
                    & (arp_req_prot      == ETH_TYPE_IP4)
                    & (arp_req_opcode    == ARP_TYPE_REQ)
                    & (arp_req_target_ip == local_ip    );

// This is asserted when a UDP request arrives for our UDP sport
wire is_udp_rw = is_for_us
               & (rx_eth_type           == ETH_TYPE_IP4   ) 
               & (inc_ip4_ttl_prot[7:0] == PROT_UDP       )
               & (inc_udp_dst_port      == UDP_SERVER_PORT)
               & (rw_opcode             <  16             );

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
make_ip4_header#(PROT_PING) make_ip4_0
(
    // Output     Source IP  Dest IP        Payload Len
    ping_rsp_ip4, local_ip, inc_ip4_src_ip, 8
);

wire[159:0] udp_rsp_ip4;
make_ip4_header#(PROT_UDP) make_ip4_1
(
    // Output     Source IP  Dest IP         Payload Len    
    udp_rsp_ip4,  local_ip,  inc_ip4_src_ip, UDP_RESPONSE_LEN
);
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


//----------------------------------------------------------------------------
// This is the response to a UDP "read/write" command, and is 16 32-bit words
// for a total of 64 bytes
//----------------------------------------------------------------------------
reg [ 7:0] udp_rw_rsp_error;
reg [63:0] udp_rw_rsp_data;

wire[UDP_RSP_WORDS*32-1:0] udp_rw_rsp =
{
    // Ethernet header (14 bytes)
    rx_eth_src,     
    local_mac,      
    ETH_TYPE_IP4,   
    
    // IPv4 Header (20 bytes)
    udp_rsp_ip4,

    // UDP header (8 bytes)
    UDP_SERVER_PORT,
    rw_rsp_port,
    UDP_RESPONSE_LEN[15:0],
    16'h0000,

    // UDP Payload (22 bytes)
    rw_opcode,
    udp_rw_rsp_error,
    rw_rsp_port,
    rw_address,
    udp_rw_rsp_data,
    16'h0000
};

// Here we break "udp_rw_rsp" into an array of 32-bit words
wire[31:0] udp_rw_rsp_word[0:UDP_RSP_WORDS-1];
for (i=0; i<UDP_RSP_WORDS; i=i+1) begin
    assign udp_rw_rsp_word[i] = udp_rw_rsp[(UDP_RSP_WORDS-1-i)*32 +: 32];
end
//----------------------------------------------------------------------------



//================================================================================================
// This state machine reads a packet in from the receive-status stream.   It saves the status-word
// from that packet, and turns on tready for the receive-data stream.
//
// This state machine starts when "fsm_state" is FSM_IDLE
//================================================================================================
reg[3:0] rxs_beat;
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
                rxs_beat   <= 0;
                rssm_state <= 1;
            end


        // Here we wait for beats to arrive on the status stream.   When we recive word 3
        // we save the status word, and enable tready on the packet data stream.
        //
        // On the last beat of the status data, we disable packet-status tready
        1:  if (rxs_tvalid & rxs_tready) begin
                if (rxs_beat == 3) begin
                    rxs_status_word <= rxs_tdata;
                    rxd_tready      <= 1;
                end

                if (rxs_tlast) begin
                    rxs_tready <= 0;
                    rssm_state <= 2;
                end else
                    rxs_beat   <= rxs_beat + 1;                 
            end

        // On the last beat of the received packet data, we
        // go back to waiting for the signal to ingest a new
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
reg[15:0] rxd_beat;
always @(posedge clk) begin
    
    if (rxd_tready == 0)
        rxd_beat <= 0;
    
    else if (rxd_tvalid & rxd_tready & (rxd_beat < PACKET_WORDS)) begin 
        packet[rxd_beat] <= swap(rxd_tdata);
        rxd_beat         <= rxd_beat + 1;
    end
end
//================================================================================================


//================================================================================================
// This is the state machine that waits for Ethernet packets to arrive and handles them
//================================================================================================
always @(posedge clk) begin

    // These will strobe high for exactly one cycle
    send_packet <= 0;
    AMCI_WRITE  <= 0;
    AMCI_READ   <= 0;
 
    if (resetn == 0)
        fsm_state <= 0;
    
    else case(fsm_state)

        // Wait for a packet to arrive, and if it's intended for us,
        // determine what to do with it
        FSM_IDLE:
            if (rxd_tready & rxd_tvalid & rxd_tlast) begin
                if (is_udp_rw) case (rw_opcode)
                    OP_WRITE32: fsm_state <= FSM_WRITE32;
                    OP_WRITE64: fsm_state <= FSM_WRITE64;
                    OP_READ32:  fsm_state <= FSM_READ32;
                    OP_READ64:  fsm_state <= FSM_READ64;
                endcase 
                else fsm_state <= FSM_RESPOND;
            end

        FSM_WRITE32:
            begin
                AMCI_WADDR <= rw_address[AW-1:0];
                AMCI_WDATA <= rw_data[31:0];
                AMCI_WRITE <= 1;
                fsm_state  <= fsm_state + 1;
            end
        
        FSM_WRITE32 + 1:
            if (AMCI_WIDLE) begin
                udp_rw_rsp_error <= AMCI_WRESP;
                udp_rw_rsp_data  <= rw_data;
                fsm_state        <= FSM_RESPOND;
            end


        FSM_WRITE64:
            begin
                AMCI_WADDR <= rw_address[AW-1:0];
                AMCI_WDATA <= rw_data[63:32];
                AMCI_WRITE <= 1;
                fsm_state  <= fsm_state + 1;
            end

        FSM_WRITE64 + 1:
            if (AMCI_WIDLE) begin
                AMCI_WADDR <= AMCI_WADDR + 4;
                AMCI_WDATA <= rw_data[31:0];
                AMCI_WRITE <= 1;
                fsm_state  <= fsm_state + 1;
            end

        FSM_WRITE64 + 2:
            if (AMCI_WIDLE) begin
                udp_rw_rsp_error <= AMCI_WRESP;
                udp_rw_rsp_data  <= rw_data;
                fsm_state        <= FSM_RESPOND;
            end

        FSM_READ32:
            begin
                AMCI_RADDR <= rw_address[AW-1:0];
                AMCI_READ  <= 1;
                fsm_state  <= fsm_state + 1;
            end

        FSM_READ32 + 1:
            if (AMCI_RIDLE) begin
                udp_rw_rsp_error       <= AMCI_RRESP;
                udp_rw_rsp_data[63:32] <= 0;
                udp_rw_rsp_data[31:00] <= AMCI_RDATA;
                fsm_state              <= FSM_RESPOND;
            end

        FSM_READ64:
            begin
                AMCI_RADDR <= rw_address[AW-1:0];
                AMCI_READ  <= 1;
                fsm_state  <= fsm_state + 1;
            end

        FSM_READ64 + 1:
            if (AMCI_RIDLE) begin
                udp_rw_rsp_data[63:32] <= AMCI_RDATA;
                AMCI_RADDR             <= AMCI_RADDR + 4;
                AMCI_READ              <= 1;
                fsm_state              <= fsm_state + 1;
            end

        FSM_READ64 + 2:
            if (AMCI_RIDLE) begin
                udp_rw_rsp_error       <= AMCI_RRESP;
                udp_rw_rsp_data[31:00] <= AMCI_RDATA;
                fsm_state              <= FSM_RESPOND;
            end

        FSM_RESPOND:
            if (is_arp_request) begin
                send_packet <= TX_ARP;
                fsm_state   <= FSM_WAIT_FOR_XMIT;
            end 

            else if (is_icmp_ping) begin
                send_packet <= TX_PING;
                fsm_state   <= FSM_WAIT_FOR_XMIT;
            end
            
            else if (is_udp_rw) begin
                send_packet <= TX_UDP;
                fsm_state   <= FSM_WAIT_FOR_XMIT;
            end

            else fsm_state   <= FSM_IDLE;


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

        0:  if (send_packet) begin
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
reg[2:0]   tx_type;

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
            case (send_packet)
                TX_ARP:
                    begin
                        tx_type        <= TX_ARP;
                        txd_beat       <= 0;
                        txd_final_beat <= ARP_WORDS - 1;
                        tdsm_state     <= TDSM_SEND;
                    end

                TX_PING:
                    begin
                        tx_type        <= TX_PING;
                        txd_beat       <= 0;
                        txd_final_beat <= PING_WORDS - 1;
                        tdsm_state     <= TDSM_SEND;
                    end

                TX_UDP:
                    begin
                        tx_type        <= TX_UDP;
                        txd_beat       <= 0;
                        txd_final_beat <= UDP_RSP_WORDS - 1;
                        tdsm_state     <= TDSM_SEND;
                    end
            endcase

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
            TX_ARP:  txd_tdata = swap(    arp_rsp_word[txd_beat]);
            TX_PING: txd_tdata = swap(   ping_rsp_word[txd_beat]);
            TX_UDP:  txd_tdata = swap( udp_rw_rsp_word[txd_beat]);
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
            TX_UDP:  txd_tkeep = 4'b1111;
        endcase
    end
end
//================================================================================================



//================================================================================================
// This instantiates an AXI4-Lite master that we will controll with the AMCI_xxx signals
//================================================================================================
axi4_lite_master # (.DW(DW), .AW(AW)) axi4_master
(
    // Clock and reset
    .clk            (clk),
    .resetn         (resetn),

    // AXI Master Control Interface for performing writes
    .AMCI_WADDR     (AMCI_WADDR),
    .AMCI_WDATA     (AMCI_WDATA),
    .AMCI_WRITE     (AMCI_WRITE),
    .AMCI_WRESP     (AMCI_WRESP),
    .AMCI_WIDLE     (AMCI_WIDLE),

    // AXI Master Control Interface for performing reads
    .AMCI_RADDR     (AMCI_RADDR),
    .AMCI_READ      (AMCI_READ ),
    .AMCI_RDATA     (AMCI_RDATA),
    .AMCI_RRESP     (AMCI_RRESP),
    .AMCI_RIDLE     (AMCI_RIDLE),

    // AXI4-Lite AW channel
    .AXI_AWADDR     (M_AXI_AWADDR ),
    .AXI_AWVALID    (M_AXI_AWVALID),
    .AXI_AWPROT     (M_AXI_AWPROT ),
    .AXI_AWREADY    (M_AXI_AWREADY),

    // AXI4-Lite W channel
    .AXI_WDATA      (M_AXI_WDATA  ),
    .AXI_WSTRB      (M_AXI_WSTRB  ),
    .AXI_WVALID     (M_AXI_WVALID ),
    .AXI_WREADY     (M_AXI_WREADY ),

    // AXI4-Lite B channel
    .AXI_BRESP      (M_AXI_BRESP  ),
    .AXI_BVALID     (M_AXI_BVALID ),
    .AXI_BREADY     (M_AXI_BREADY ),

    // AXI4-Lite AR channel
    .AXI_ARADDR     (M_AXI_ARADDR ),
    .AXI_ARPROT     (M_AXI_ARPROT ),
    .AXI_ARVALID    (M_AXI_ARVALID),
    .AXI_ARREADY    (M_AXI_ARREADY),

    .AXI_RDATA      (M_AXI_RDATA  ),
    .AXI_RVALID     (M_AXI_RVALID ),
    .AXI_RRESP      (M_AXI_RRESP  ),
    .AXI_RREADY     (M_AXI_RREADY )
);
//================================================================================================


//================================================================================================
// These are optional assignments to output fields for examination in an ILA
//================================================================================================

`ifdef DEBUG_MISC
    assign dbg_rxs_status_word = rxs_status_word;
    assign dbg_is_icmp_ping    = is_icmp_ping;
    assign dbg_is_arp_request  = is_arp_request;
    assign dbg_is_udp_rw       = is_udp_rw;
`endif


`ifdef DEBUG_ETH
    assign dbg_rx_eth_dst  = rx_eth_dst ;
    assign dbg_rx_eth_src  = rx_eth_src ;
    assign dbg_rx_eth_type = rx_eth_type;
`endif

`ifdef DEBUG_ARP
    assign dbg_arp_req_hw         = arp_req_hw        ;    
    assign dbg_arp_req_prot       = arp_req_prot      ;         
    assign dbg_arp_req_hw_len     = arp_req_hw_len    ;         
    assign dbg_arp_req_prot_len   = arp_req_prot_len  ;         
    assign dbg_arp_req_opcode     = arp_req_opcode    ;      
    assign dbg_arp_req_sender_mac = arp_req_sender_mac;           
    assign dbg_arp_req_sender_ip  = arp_req_sender_ip ;          
    assign dbg_arp_req_target_mac = arp_req_target_mac;           
    assign dbg_arp_req_target_ip  = arp_req_target_ip ;                
`endif


`ifdef DEBUG_IP4
    assign dbg_inc_ip4_ver_dsf  = inc_ip4_ver_dsf ;       
    assign dbg_inc_ip4_length   = inc_ip4_length  ;        
    assign dbg_inc_ip4_id       = inc_ip4_id      ;      
    assign dbg_inc_ip4_flags    = inc_ip4_flags   ;          
    assign dbg_inc_ip4_ttl_prot = inc_ip4_ttl_prot;            
    assign dbg_inc_ip4_checksum = inc_ip4_checksum;            
    assign dbg_inc_ip4_src_ip   = inc_ip4_src_ip  ;            
    assign dbg_inc_ip4_dst_ip   = inc_ip4_dst_ip  ;
`endif


`ifdef DEBUG_PING
    assign dbg_ping_req_type = ping_req_type;
    assign dbg_ping_req_id   = ping_req_id  ;
    assign dbg_ping_req_seq  = ping_req_seq ;
`endif

`ifdef DEBUG_UDP
    assign dbg_inc_udp_src_port = inc_udp_src_port;
    assign dbg_inc_udp_dst_port = inc_udp_dst_port;
    assign dbg_inc_udp_length   = inc_udp_length  ;
`endif
//================================================================================================


endmodule
