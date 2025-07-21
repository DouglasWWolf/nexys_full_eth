//=====================================================================
// This module creates a 20-byte (i.e., 160 bit) IPv4 header
//
// PROTOCOL should be:
//    1 for ICMP 
//   17 for UDP
//=====================================================================
module make_ip4_header # (parameter[7:0] PROTOCOL = 17)
(
    output[159:0] result,
    input [ 31:0] src_ip,
    input [ 31:0] dst_ip,
    input [ 15:0] payload_len
);

    localparam[15:0] ip4_ver_dsf  = 16'h4500;
    wire      [15:0] ip4_length   = 20 + payload_len;
    localparam[15:0] ip4_id       = 16'hDEAD;
    localparam[15:0] ip4_flags    = 16'h4000;
    localparam[15:0] ip4_ttl_prot = {8'h40, PROTOCOL};

    // Compute the 32-bit checksum of the IPv4 header
    wire[31:0] ip4_cs32 = ip4_ver_dsf 
                        + ip4_length
                        + ip4_id
                        + ip4_flags
                        + ip4_ttl_prot
                        + src_ip[31:16]
                        + src_ip[15:00]
                        + dst_ip[31:16]
                        + dst_ip[15:00];

    // Compute the 16-bit checksum of the IPv4 header
    wire[15:0] ip4_checksum = ~(ip4_cs32[31:16] + ip4_cs32[15:0]);

    // These are the 20 bytes of an IPv4 header    
    assign result = 
    {
        ip4_ver_dsf,
        ip4_length,
        ip4_id, 
        ip4_flags,
        ip4_ttl_prot,
        ip4_checksum,
        src_ip,
        dst_ip
    };

endmodule
//===================================================================

