//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Mon Jul 21 06:33:01 2025
//Host        : wolf-super-server running 64-bit Ubuntu 20.04.6 LTS
//Command     : generate_target top_level.bd
//Design      : top_level
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ethernet_imp_1SW6PPD
   (clk_50,
    gtx_clk,
    m_axis_rxd_tdata,
    m_axis_rxd_tkeep,
    m_axis_rxd_tlast,
    m_axis_rxd_tready,
    m_axis_rxd_tvalid,
    m_axis_rxs_tdata,
    m_axis_rxs_tkeep,
    m_axis_rxs_tlast,
    m_axis_rxs_tready,
    m_axis_rxs_tvalid,
    mdio_mdc,
    mdio_mdio_i,
    mdio_mdio_o,
    mdio_mdio_t,
    phy_crs_dv,
    phy_rst_n,
    phy_rx_er,
    phy_rxd,
    reset_n,
    rmii_tx_en,
    rmii_txd,
    s_axi_araddr,
    s_axi_arready,
    s_axi_arvalid,
    s_axi_awaddr,
    s_axi_awready,
    s_axi_awvalid,
    s_axi_bready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_rdata,
    s_axi_rready,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_wdata,
    s_axi_wready,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axis_txc_tdata,
    s_axis_txc_tkeep,
    s_axis_txc_tlast,
    s_axis_txc_tready,
    s_axis_txc_tvalid,
    s_axis_txd_tdata,
    s_axis_txd_tkeep,
    s_axis_txd_tlast,
    s_axis_txd_tready,
    s_axis_txd_tvalid,
    sys_clk);
  input clk_50;
  input gtx_clk;
  output [31:0]m_axis_rxd_tdata;
  output [3:0]m_axis_rxd_tkeep;
  output m_axis_rxd_tlast;
  input m_axis_rxd_tready;
  output m_axis_rxd_tvalid;
  output [31:0]m_axis_rxs_tdata;
  output [3:0]m_axis_rxs_tkeep;
  output m_axis_rxs_tlast;
  input m_axis_rxs_tready;
  output m_axis_rxs_tvalid;
  output mdio_mdc;
  input mdio_mdio_i;
  output mdio_mdio_o;
  output mdio_mdio_t;
  input phy_crs_dv;
  output [0:0]phy_rst_n;
  input phy_rx_er;
  input [1:0]phy_rxd;
  input reset_n;
  output rmii_tx_en;
  output [1:0]rmii_txd;
  input [0:0]s_axi_araddr;
  output s_axi_arready;
  input s_axi_arvalid;
  input [0:0]s_axi_awaddr;
  output s_axi_awready;
  input s_axi_awvalid;
  input s_axi_bready;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  output [31:0]s_axi_rdata;
  input s_axi_rready;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input [0:0]s_axi_wdata;
  output s_axi_wready;
  input [0:0]s_axi_wstrb;
  input s_axi_wvalid;
  input [31:0]s_axis_txc_tdata;
  input [3:0]s_axis_txc_tkeep;
  input s_axis_txc_tlast;
  output s_axis_txc_tready;
  input s_axis_txc_tvalid;
  input [31:0]s_axis_txd_tdata;
  input [3:0]s_axis_txd_tkeep;
  input s_axis_txd_tlast;
  output s_axis_txd_tready;
  input s_axis_txd_tvalid;
  input sys_clk;

  wire axi_ethernet_mii_tx_en;
  wire axi_ethernet_mii_tx_er;
  wire [3:0]axi_ethernet_mii_txd;
  wire clk_50;
  wire gtx_clk;
  wire [31:0]m_axis_rxd_tdata;
  wire [3:0]m_axis_rxd_tkeep;
  wire m_axis_rxd_tlast;
  wire m_axis_rxd_tready;
  wire m_axis_rxd_tvalid;
  wire [31:0]m_axis_rxs_tdata;
  wire [3:0]m_axis_rxs_tkeep;
  wire m_axis_rxs_tlast;
  wire m_axis_rxs_tready;
  wire m_axis_rxs_tvalid;
  wire mdio_mdc;
  wire mdio_mdio_i;
  wire mdio_mdio_o;
  wire mdio_mdio_t;
  wire mii_to_rmii_mii_rx_clk;
  wire mii_to_rmii_mii_rx_dv;
  wire mii_to_rmii_mii_rx_er;
  wire [3:0]mii_to_rmii_mii_rxd;
  wire mii_to_rmii_mii_tx_clk;
  wire phy_crs_dv;
  wire [0:0]phy_rst_n;
  wire phy_rx_er;
  wire [1:0]phy_rxd;
  wire reset_n;
  wire rmii_tx_en;
  wire [1:0]rmii_txd;
  wire [0:0]s_axi_araddr;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [0:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [1:0]s_axi_bresp;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire [0:0]s_axi_wdata;
  wire s_axi_wready;
  wire [0:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire [31:0]s_axis_txc_tdata;
  wire [3:0]s_axis_txc_tkeep;
  wire s_axis_txc_tlast;
  wire s_axis_txc_tready;
  wire s_axis_txc_tvalid;
  wire [31:0]s_axis_txd_tdata;
  wire [3:0]s_axis_txd_tkeep;
  wire s_axis_txd_tlast;
  wire s_axis_txd_tready;
  wire s_axis_txd_tvalid;
  wire sys_clk;

  top_level_axi_ethernet_0_0 axi_ethernet
       (.axi_rxd_arstn(reset_n),
        .axi_rxs_arstn(reset_n),
        .axi_txc_arstn(reset_n),
        .axi_txd_arstn(reset_n),
        .axis_clk(sys_clk),
        .gtx_clk(gtx_clk),
        .m_axis_rxd_tdata(m_axis_rxd_tdata),
        .m_axis_rxd_tkeep(m_axis_rxd_tkeep),
        .m_axis_rxd_tlast(m_axis_rxd_tlast),
        .m_axis_rxd_tready(m_axis_rxd_tready),
        .m_axis_rxd_tvalid(m_axis_rxd_tvalid),
        .m_axis_rxs_tdata(m_axis_rxs_tdata),
        .m_axis_rxs_tkeep(m_axis_rxs_tkeep),
        .m_axis_rxs_tlast(m_axis_rxs_tlast),
        .m_axis_rxs_tready(m_axis_rxs_tready),
        .m_axis_rxs_tvalid(m_axis_rxs_tvalid),
        .mdio_mdc(mdio_mdc),
        .mdio_mdio_i(mdio_mdio_i),
        .mdio_mdio_o(mdio_mdio_o),
        .mdio_mdio_t(mdio_mdio_t),
        .mii_rx_clk(mii_to_rmii_mii_rx_clk),
        .mii_rx_dv(mii_to_rmii_mii_rx_dv),
        .mii_rx_er(mii_to_rmii_mii_rx_er),
        .mii_rxd(mii_to_rmii_mii_rxd),
        .mii_tx_clk(mii_to_rmii_mii_tx_clk),
        .mii_tx_en(axi_ethernet_mii_tx_en),
        .mii_tx_er(axi_ethernet_mii_tx_er),
        .mii_txd(axi_ethernet_mii_txd),
        .phy_rst_n(phy_rst_n),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_araddr}),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_awaddr}),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_lite_clk(sys_clk),
        .s_axi_lite_resetn(reset_n),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_wdata}),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb({1'b1,1'b1,1'b1,s_axi_wstrb}),
        .s_axi_wvalid(s_axi_wvalid),
        .s_axis_txc_tdata(s_axis_txc_tdata),
        .s_axis_txc_tkeep(s_axis_txc_tkeep),
        .s_axis_txc_tlast(s_axis_txc_tlast),
        .s_axis_txc_tready(s_axis_txc_tready),
        .s_axis_txc_tvalid(s_axis_txc_tvalid),
        .s_axis_txd_tdata(s_axis_txd_tdata),
        .s_axis_txd_tkeep(s_axis_txd_tkeep),
        .s_axis_txd_tlast(s_axis_txd_tlast),
        .s_axis_txd_tready(s_axis_txd_tready),
        .s_axis_txd_tvalid(s_axis_txd_tvalid));
  top_level_mii_to_rmii_0_1 mii_to_rmii
       (.mac_tx_en(axi_ethernet_mii_tx_en),
        .mac_tx_er(axi_ethernet_mii_tx_er),
        .mac_txd(axi_ethernet_mii_txd),
        .mii_rx_clk(mii_to_rmii_mii_rx_clk),
        .mii_rx_dv(mii_to_rmii_mii_rx_dv),
        .mii_rx_er(mii_to_rmii_mii_rx_er),
        .mii_rxd(mii_to_rmii_mii_rxd),
        .mii_tx_clk(mii_to_rmii_mii_tx_clk),
        .phy_crs_dv(phy_crs_dv),
        .phy_rx_er(phy_rx_er),
        .phy_rxd(phy_rxd),
        .ref_clk(clk_50),
        .reset_n(reset_n),
        .rmii_tx_en(rmii_tx_en),
        .rmii_txd(rmii_txd));
endmodule

module source_100mhz_imp_MSWE0P
   (clk_100mhz,
    clk_50mhz,
    clk_in,
    gtx_clk,
    phy_clk,
    resetn_in,
    sys_resetn);
  output clk_100mhz;
  output clk_50mhz;
  input clk_in;
  output gtx_clk;
  output phy_clk;
  input resetn_in;
  output [0:0]sys_resetn;

  wire clk_100mhz;
  wire clk_50mhz;
  wire clk_in;
  wire gtx_clk;
  wire phy_clk;
  wire resetn_in;
  wire \^sys_resetn ;
  wire [0:0]system_reset_peripheral_aresetn;

  assign sys_resetn[0] = \^sys_resetn ;
  top_level_reset_extender_0_0 reset_extender
       (.clk(clk_100mhz),
        .resetn(system_reset_peripheral_aresetn),
        .resetn_out(\^sys_resetn ));
  top_level_clk_wiz_0_0 system_clock
       (.clk_100mhz(clk_100mhz),
        .clk_50mhz(clk_50mhz),
        .clk_in1(clk_in),
        .gtx_clk(gtx_clk),
        .phy_clk(phy_clk));
  top_level_proc_sys_reset_0_0 system_reset
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(resetn_in),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(system_reset_peripheral_aresetn),
        .slowest_sync_clk(clk_100mhz));
endmodule

(* CORE_GENERATION_INFO = "top_level,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=top_level,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=15,numReposBlks=12,numNonXlnxBlks=0,numHierBlks=3,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=6,numPkgbdBlks=0,bdsource=USER,da_axi4_cnt=2,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "top_level.hwdef" *) 
module top_level
   (CLK100MHZ,
    CPU_RESETN,
    ETH_CRSDV,
    ETH_REFCLK,
    ETH_RSTN,
    ETH_RXD,
    ETH_RXERR,
    ETH_TXD,
    ETH_TXEN,
    MDIO_mdc,
    MDIO_mdio_i,
    MDIO_mdio_o,
    MDIO_mdio_t,
    UART_rxd,
    UART_txd);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK100MHZ CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK100MHZ, CLK_DOMAIN top_level_CLK100MHZ, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input CLK100MHZ;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.CPU_RESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.CPU_RESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input CPU_RESETN;
  input ETH_CRSDV;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ETH_REFCLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ETH_REFCLK, CLK_DOMAIN /source_100mhz/system_clock_clk_out1, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 45.0" *) output ETH_REFCLK;
  output [0:0]ETH_RSTN;
  input [1:0]ETH_RXD;
  input ETH_RXERR;
  output [1:0]ETH_TXD;
  output ETH_TXEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mdio:1.0 MDIO MDC" *) (* X_INTERFACE_MODE = "Master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME MDIO, CAN_DEBUG false" *) output MDIO_mdc;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mdio:1.0 MDIO MDIO_I" *) input MDIO_mdio_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mdio:1.0 MDIO MDIO_O" *) output MDIO_mdio_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mdio:1.0 MDIO MDIO_T" *) output MDIO_mdio_t;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 UART RxD" *) (* X_INTERFACE_MODE = "Master" *) input UART_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 UART TxD" *) output UART_txd;

  wire CLK100MHZ;
  wire CPU_RESETN;
  wire ETH_CRSDV;
  wire ETH_REFCLK;
  wire [0:0]ETH_RSTN;
  wire [1:0]ETH_RXD;
  wire ETH_RXERR;
  wire [1:0]ETH_TXD;
  wire ETH_TXEN;
  wire MDIO_mdc;
  wire MDIO_mdio_i;
  wire MDIO_mdio_o;
  wire MDIO_mdio_t;
  wire UART_rxd;
  wire UART_txd;
  (* CONN_BUS_INFO = "ethernet_m_axis_rxd xilinx.com:interface:axis:1.0 None TDATA" *) (* DONT_TOUCH *) wire [31:0]ethernet_m_axis_rxd_TDATA;
  (* CONN_BUS_INFO = "ethernet_m_axis_rxd xilinx.com:interface:axis:1.0 None TKEEP" *) (* DONT_TOUCH *) wire [3:0]ethernet_m_axis_rxd_TKEEP;
  (* CONN_BUS_INFO = "ethernet_m_axis_rxd xilinx.com:interface:axis:1.0 None TLAST" *) (* DONT_TOUCH *) wire ethernet_m_axis_rxd_TLAST;
  (* CONN_BUS_INFO = "ethernet_m_axis_rxd xilinx.com:interface:axis:1.0 None TREADY" *) (* DONT_TOUCH *) wire ethernet_m_axis_rxd_TREADY;
  (* CONN_BUS_INFO = "ethernet_m_axis_rxd xilinx.com:interface:axis:1.0 None TVALID" *) (* DONT_TOUCH *) wire ethernet_m_axis_rxd_TVALID;
  (* CONN_BUS_INFO = "ethernet_m_axis_rxs xilinx.com:interface:axis:1.0 None TDATA" *) (* DONT_TOUCH *) wire [31:0]ethernet_m_axis_rxs_TDATA;
  (* CONN_BUS_INFO = "ethernet_m_axis_rxs xilinx.com:interface:axis:1.0 None TKEEP" *) (* DONT_TOUCH *) wire [3:0]ethernet_m_axis_rxs_TKEEP;
  (* CONN_BUS_INFO = "ethernet_m_axis_rxs xilinx.com:interface:axis:1.0 None TLAST" *) (* DONT_TOUCH *) wire ethernet_m_axis_rxs_TLAST;
  (* CONN_BUS_INFO = "ethernet_m_axis_rxs xilinx.com:interface:axis:1.0 None TREADY" *) (* DONT_TOUCH *) wire ethernet_m_axis_rxs_TREADY;
  (* CONN_BUS_INFO = "ethernet_m_axis_rxs xilinx.com:interface:axis:1.0 None TVALID" *) (* DONT_TOUCH *) wire ethernet_m_axis_rxs_TVALID;
  wire [15:0]ethernet_reg_dbg_inc_ip4_checksum;
  wire [31:0]ethernet_reg_dbg_inc_ip4_dst_ip;
  wire [15:0]ethernet_reg_dbg_inc_ip4_flags;
  wire [15:0]ethernet_reg_dbg_inc_ip4_id;
  wire [15:0]ethernet_reg_dbg_inc_ip4_length;
  wire [31:0]ethernet_reg_dbg_inc_ip4_src_ip;
  wire [15:0]ethernet_reg_dbg_inc_ip4_ttl_prot;
  wire [15:0]ethernet_reg_dbg_inc_ip4_ver_dsf;
  wire ethernet_reg_dbg_is_icmp_ping;
  wire [15:0]ethernet_reg_dbg_ping_req_id;
  wire [15:0]ethernet_reg_dbg_ping_req_seq;
  wire [15:0]ethernet_reg_dbg_ping_req_type;
  wire [47:0]ethernet_reg_dbg_rx_eth_dst;
  wire [47:0]ethernet_reg_dbg_rx_eth_src;
  wire [15:0]ethernet_reg_dbg_rx_eth_type;
  wire [31:0]ethernet_reg_dbg_rxs_status_word;
  (* CONN_BUS_INFO = "s_axis_txc_1 xilinx.com:interface:axis:1.0 None TDATA" *) (* DONT_TOUCH *) wire [31:0]s_axis_txc_1_TDATA;
  (* CONN_BUS_INFO = "s_axis_txc_1 xilinx.com:interface:axis:1.0 None TKEEP" *) (* DONT_TOUCH *) wire [3:0]s_axis_txc_1_TKEEP;
  (* CONN_BUS_INFO = "s_axis_txc_1 xilinx.com:interface:axis:1.0 None TLAST" *) (* DONT_TOUCH *) wire s_axis_txc_1_TLAST;
  (* CONN_BUS_INFO = "s_axis_txc_1 xilinx.com:interface:axis:1.0 None TREADY" *) (* DONT_TOUCH *) wire s_axis_txc_1_TREADY;
  (* CONN_BUS_INFO = "s_axis_txc_1 xilinx.com:interface:axis:1.0 None TVALID" *) (* DONT_TOUCH *) wire s_axis_txc_1_TVALID;
  (* CONN_BUS_INFO = "s_axis_txd_1 xilinx.com:interface:axis:1.0 None TDATA" *) (* DONT_TOUCH *) wire [31:0]s_axis_txd_1_TDATA;
  (* CONN_BUS_INFO = "s_axis_txd_1 xilinx.com:interface:axis:1.0 None TKEEP" *) (* DONT_TOUCH *) wire [3:0]s_axis_txd_1_TKEEP;
  (* CONN_BUS_INFO = "s_axis_txd_1 xilinx.com:interface:axis:1.0 None TLAST" *) (* DONT_TOUCH *) wire s_axis_txd_1_TLAST;
  (* CONN_BUS_INFO = "s_axis_txd_1 xilinx.com:interface:axis:1.0 None TREADY" *) (* DONT_TOUCH *) wire s_axis_txd_1_TREADY;
  (* CONN_BUS_INFO = "s_axis_txd_1 xilinx.com:interface:axis:1.0 None TVALID" *) (* DONT_TOUCH *) wire s_axis_txd_1_TVALID;
  wire source_100mhz_clk_50mhz;
  wire source_100mhz_gtx_clk;
  wire source_100mhz_sys_clk;
  wire [0:0]source_100mhz_sys_resetn;
  wire system_interconnect_M00_AXI_ARADDR;
  wire [2:0]system_interconnect_M00_AXI_ARPROT;
  wire system_interconnect_M00_AXI_ARREADY;
  wire [0:0]system_interconnect_M00_AXI_ARVALID;
  wire system_interconnect_M00_AXI_AWADDR;
  wire [2:0]system_interconnect_M00_AXI_AWPROT;
  wire system_interconnect_M00_AXI_AWREADY;
  wire [0:0]system_interconnect_M00_AXI_AWVALID;
  wire [0:0]system_interconnect_M00_AXI_BREADY;
  wire [1:0]system_interconnect_M00_AXI_BRESP;
  wire system_interconnect_M00_AXI_BVALID;
  wire [31:0]system_interconnect_M00_AXI_RDATA;
  wire [0:0]system_interconnect_M00_AXI_RREADY;
  wire [1:0]system_interconnect_M00_AXI_RRESP;
  wire system_interconnect_M00_AXI_RVALID;
  wire system_interconnect_M00_AXI_WDATA;
  wire system_interconnect_M00_AXI_WREADY;
  wire system_interconnect_M00_AXI_WSTRB;
  wire [0:0]system_interconnect_M00_AXI_WVALID;
  wire system_interconnect_M01_AXI_ARADDR;
  wire [2:0]system_interconnect_M01_AXI_ARPROT;
  wire system_interconnect_M01_AXI_ARREADY;
  wire [0:0]system_interconnect_M01_AXI_ARVALID;
  wire system_interconnect_M01_AXI_AWADDR;
  wire [2:0]system_interconnect_M01_AXI_AWPROT;
  wire system_interconnect_M01_AXI_AWREADY;
  wire [0:0]system_interconnect_M01_AXI_AWVALID;
  wire [0:0]system_interconnect_M01_AXI_BREADY;
  wire [1:0]system_interconnect_M01_AXI_BRESP;
  wire system_interconnect_M01_AXI_BVALID;
  wire [31:0]system_interconnect_M01_AXI_RDATA;
  wire [0:0]system_interconnect_M01_AXI_RREADY;
  wire [1:0]system_interconnect_M01_AXI_RRESP;
  wire system_interconnect_M01_AXI_RVALID;
  wire system_interconnect_M01_AXI_WDATA;
  wire system_interconnect_M01_AXI_WREADY;
  wire system_interconnect_M01_AXI_WSTRB;
  wire [0:0]system_interconnect_M01_AXI_WVALID;
  wire system_interconnect_M02_AXI_ARADDR;
  wire system_interconnect_M02_AXI_ARREADY;
  wire [0:0]system_interconnect_M02_AXI_ARVALID;
  wire system_interconnect_M02_AXI_AWADDR;
  wire system_interconnect_M02_AXI_AWREADY;
  wire [0:0]system_interconnect_M02_AXI_AWVALID;
  wire [0:0]system_interconnect_M02_AXI_BREADY;
  wire [1:0]system_interconnect_M02_AXI_BRESP;
  wire system_interconnect_M02_AXI_BVALID;
  wire [31:0]system_interconnect_M02_AXI_RDATA;
  wire [0:0]system_interconnect_M02_AXI_RREADY;
  wire [1:0]system_interconnect_M02_AXI_RRESP;
  wire system_interconnect_M02_AXI_RVALID;
  wire system_interconnect_M02_AXI_WDATA;
  wire system_interconnect_M02_AXI_WREADY;
  wire system_interconnect_M02_AXI_WSTRB;
  wire [0:0]system_interconnect_M02_AXI_WVALID;
  wire uart_axi_bridge_M_AXI_ARADDR;
  wire [0:0]uart_axi_bridge_M_AXI_ARREADY;
  wire [0:0]uart_axi_bridge_M_AXI_ARVALID;
  wire uart_axi_bridge_M_AXI_AWADDR;
  wire [0:0]uart_axi_bridge_M_AXI_AWREADY;
  wire [0:0]uart_axi_bridge_M_AXI_AWVALID;
  wire [0:0]uart_axi_bridge_M_AXI_BREADY;
  wire [1:0]uart_axi_bridge_M_AXI_BRESP;
  wire [0:0]uart_axi_bridge_M_AXI_BVALID;
  wire uart_axi_bridge_M_AXI_RDATA;
  wire [0:0]uart_axi_bridge_M_AXI_RREADY;
  wire [1:0]uart_axi_bridge_M_AXI_RRESP;
  wire [0:0]uart_axi_bridge_M_AXI_RVALID;
  wire uart_axi_bridge_M_AXI_WDATA;
  wire [0:0]uart_axi_bridge_M_AXI_WREADY;
  wire uart_axi_bridge_M_AXI_WSTRB;
  wire [0:0]uart_axi_bridge_M_AXI_WVALID;

  top_level_axi_revision_0_0 axi_revision
       (.AXI_ACLK(source_100mhz_sys_clk),
        .AXI_ARESETN(source_100mhz_sys_resetn),
        .S_AXI_ARADDR({system_interconnect_M00_AXI_ARADDR,system_interconnect_M00_AXI_ARADDR,system_interconnect_M00_AXI_ARADDR,system_interconnect_M00_AXI_ARADDR,system_interconnect_M00_AXI_ARADDR}),
        .S_AXI_ARPROT(system_interconnect_M00_AXI_ARPROT),
        .S_AXI_ARREADY(system_interconnect_M00_AXI_ARREADY),
        .S_AXI_ARVALID(system_interconnect_M00_AXI_ARVALID),
        .S_AXI_AWADDR({system_interconnect_M00_AXI_AWADDR,system_interconnect_M00_AXI_AWADDR,system_interconnect_M00_AXI_AWADDR,system_interconnect_M00_AXI_AWADDR,system_interconnect_M00_AXI_AWADDR}),
        .S_AXI_AWPROT(system_interconnect_M00_AXI_AWPROT),
        .S_AXI_AWREADY(system_interconnect_M00_AXI_AWREADY),
        .S_AXI_AWVALID(system_interconnect_M00_AXI_AWVALID),
        .S_AXI_BREADY(system_interconnect_M00_AXI_BREADY),
        .S_AXI_BRESP(system_interconnect_M00_AXI_BRESP),
        .S_AXI_BVALID(system_interconnect_M00_AXI_BVALID),
        .S_AXI_RDATA(system_interconnect_M00_AXI_RDATA),
        .S_AXI_RREADY(system_interconnect_M00_AXI_RREADY),
        .S_AXI_RRESP(system_interconnect_M00_AXI_RRESP),
        .S_AXI_RVALID(system_interconnect_M00_AXI_RVALID),
        .S_AXI_WDATA({system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA,system_interconnect_M00_AXI_WDATA}),
        .S_AXI_WREADY(system_interconnect_M00_AXI_WREADY),
        .S_AXI_WSTRB({system_interconnect_M00_AXI_WSTRB,system_interconnect_M00_AXI_WSTRB,system_interconnect_M00_AXI_WSTRB,system_interconnect_M00_AXI_WSTRB}),
        .S_AXI_WVALID(system_interconnect_M00_AXI_WVALID));
  ethernet_imp_1SW6PPD ethernet
       (.clk_50(source_100mhz_clk_50mhz),
        .gtx_clk(source_100mhz_gtx_clk),
        .m_axis_rxd_tdata(ethernet_m_axis_rxd_TDATA),
        .m_axis_rxd_tkeep(ethernet_m_axis_rxd_TKEEP),
        .m_axis_rxd_tlast(ethernet_m_axis_rxd_TLAST),
        .m_axis_rxd_tready(ethernet_m_axis_rxd_TREADY),
        .m_axis_rxd_tvalid(ethernet_m_axis_rxd_TVALID),
        .m_axis_rxs_tdata(ethernet_m_axis_rxs_TDATA),
        .m_axis_rxs_tkeep(ethernet_m_axis_rxs_TKEEP),
        .m_axis_rxs_tlast(ethernet_m_axis_rxs_TLAST),
        .m_axis_rxs_tready(ethernet_m_axis_rxs_TREADY),
        .m_axis_rxs_tvalid(ethernet_m_axis_rxs_TVALID),
        .mdio_mdc(MDIO_mdc),
        .mdio_mdio_i(MDIO_mdio_i),
        .mdio_mdio_o(MDIO_mdio_o),
        .mdio_mdio_t(MDIO_mdio_t),
        .phy_crs_dv(ETH_CRSDV),
        .phy_rst_n(ETH_RSTN),
        .phy_rx_er(ETH_RXERR),
        .phy_rxd(ETH_RXD),
        .reset_n(source_100mhz_sys_resetn),
        .rmii_tx_en(ETH_TXEN),
        .rmii_txd(ETH_TXD),
        .s_axi_araddr(system_interconnect_M02_AXI_ARADDR),
        .s_axi_arready(system_interconnect_M02_AXI_ARREADY),
        .s_axi_arvalid(system_interconnect_M02_AXI_ARVALID),
        .s_axi_awaddr(system_interconnect_M02_AXI_AWADDR),
        .s_axi_awready(system_interconnect_M02_AXI_AWREADY),
        .s_axi_awvalid(system_interconnect_M02_AXI_AWVALID),
        .s_axi_bready(system_interconnect_M02_AXI_BREADY),
        .s_axi_bresp(system_interconnect_M02_AXI_BRESP),
        .s_axi_bvalid(system_interconnect_M02_AXI_BVALID),
        .s_axi_rdata(system_interconnect_M02_AXI_RDATA),
        .s_axi_rready(system_interconnect_M02_AXI_RREADY),
        .s_axi_rresp(system_interconnect_M02_AXI_RRESP),
        .s_axi_rvalid(system_interconnect_M02_AXI_RVALID),
        .s_axi_wdata(system_interconnect_M02_AXI_WDATA),
        .s_axi_wready(system_interconnect_M02_AXI_WREADY),
        .s_axi_wstrb(system_interconnect_M02_AXI_WSTRB),
        .s_axi_wvalid(system_interconnect_M02_AXI_WVALID),
        .s_axis_txc_tdata(s_axis_txc_1_TDATA),
        .s_axis_txc_tkeep(s_axis_txc_1_TKEEP),
        .s_axis_txc_tlast(s_axis_txc_1_TLAST),
        .s_axis_txc_tready(s_axis_txc_1_TREADY),
        .s_axis_txc_tvalid(s_axis_txc_1_TVALID),
        .s_axis_txd_tdata(s_axis_txd_1_TDATA),
        .s_axis_txd_tkeep(s_axis_txd_1_TKEEP),
        .s_axis_txd_tlast(s_axis_txd_1_TLAST),
        .s_axis_txd_tready(s_axis_txd_1_TREADY),
        .s_axis_txd_tvalid(s_axis_txd_1_TVALID),
        .sys_clk(source_100mhz_sys_clk));
  top_level_ethernet_reg_0_0 ethernet_reg
       (.clk(source_100mhz_sys_clk),
        .dbg_inc_ip4_checksum(ethernet_reg_dbg_inc_ip4_checksum),
        .dbg_inc_ip4_dst_ip(ethernet_reg_dbg_inc_ip4_dst_ip),
        .dbg_inc_ip4_flags(ethernet_reg_dbg_inc_ip4_flags),
        .dbg_inc_ip4_id(ethernet_reg_dbg_inc_ip4_id),
        .dbg_inc_ip4_length(ethernet_reg_dbg_inc_ip4_length),
        .dbg_inc_ip4_src_ip(ethernet_reg_dbg_inc_ip4_src_ip),
        .dbg_inc_ip4_ttl_prot(ethernet_reg_dbg_inc_ip4_ttl_prot),
        .dbg_inc_ip4_ver_dsf(ethernet_reg_dbg_inc_ip4_ver_dsf),
        .dbg_is_icmp_ping(ethernet_reg_dbg_is_icmp_ping),
        .dbg_ping_req_id(ethernet_reg_dbg_ping_req_id),
        .dbg_ping_req_seq(ethernet_reg_dbg_ping_req_seq),
        .dbg_ping_req_type(ethernet_reg_dbg_ping_req_type),
        .dbg_rx_eth_dst(ethernet_reg_dbg_rx_eth_dst),
        .dbg_rx_eth_src(ethernet_reg_dbg_rx_eth_src),
        .dbg_rx_eth_type(ethernet_reg_dbg_rx_eth_type),
        .dbg_rxs_status_word(ethernet_reg_dbg_rxs_status_word),
        .resetn(source_100mhz_sys_resetn),
        .rxd_tdata(ethernet_m_axis_rxd_TDATA),
        .rxd_tlast(ethernet_m_axis_rxd_TLAST),
        .rxd_tready(ethernet_m_axis_rxd_TREADY),
        .rxd_tvalid(ethernet_m_axis_rxd_TVALID),
        .rxs_tdata(ethernet_m_axis_rxs_TDATA),
        .rxs_tlast(ethernet_m_axis_rxs_TLAST),
        .rxs_tready(ethernet_m_axis_rxs_TREADY),
        .rxs_tvalid(ethernet_m_axis_rxs_TVALID),
        .txc_tdata(s_axis_txc_1_TDATA),
        .txc_tkeep(s_axis_txc_1_TKEEP),
        .txc_tlast(s_axis_txc_1_TLAST),
        .txc_tready(s_axis_txc_1_TREADY),
        .txc_tvalid(s_axis_txc_1_TVALID),
        .txd_tdata(s_axis_txd_1_TDATA),
        .txd_tkeep(s_axis_txd_1_TKEEP),
        .txd_tlast(s_axis_txd_1_TLAST),
        .txd_tready(s_axis_txd_1_TREADY),
        .txd_tvalid(s_axis_txd_1_TVALID));
  top_level_axil_slave_0_0 example_slave
       (.S_AXI_ARADDR({system_interconnect_M01_AXI_ARADDR,system_interconnect_M01_AXI_ARADDR,system_interconnect_M01_AXI_ARADDR,system_interconnect_M01_AXI_ARADDR,system_interconnect_M01_AXI_ARADDR,system_interconnect_M01_AXI_ARADDR,system_interconnect_M01_AXI_ARADDR,system_interconnect_M01_AXI_ARADDR}),
        .S_AXI_ARPROT(system_interconnect_M01_AXI_ARPROT),
        .S_AXI_ARREADY(system_interconnect_M01_AXI_ARREADY),
        .S_AXI_ARVALID(system_interconnect_M01_AXI_ARVALID),
        .S_AXI_AWADDR({system_interconnect_M01_AXI_AWADDR,system_interconnect_M01_AXI_AWADDR,system_interconnect_M01_AXI_AWADDR,system_interconnect_M01_AXI_AWADDR,system_interconnect_M01_AXI_AWADDR,system_interconnect_M01_AXI_AWADDR,system_interconnect_M01_AXI_AWADDR,system_interconnect_M01_AXI_AWADDR}),
        .S_AXI_AWPROT(system_interconnect_M01_AXI_AWPROT),
        .S_AXI_AWREADY(system_interconnect_M01_AXI_AWREADY),
        .S_AXI_AWVALID(system_interconnect_M01_AXI_AWVALID),
        .S_AXI_BREADY(system_interconnect_M01_AXI_BREADY),
        .S_AXI_BRESP(system_interconnect_M01_AXI_BRESP),
        .S_AXI_BVALID(system_interconnect_M01_AXI_BVALID),
        .S_AXI_RDATA(system_interconnect_M01_AXI_RDATA),
        .S_AXI_RREADY(system_interconnect_M01_AXI_RREADY),
        .S_AXI_RRESP(system_interconnect_M01_AXI_RRESP),
        .S_AXI_RVALID(system_interconnect_M01_AXI_RVALID),
        .S_AXI_WDATA({system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA,system_interconnect_M01_AXI_WDATA}),
        .S_AXI_WREADY(system_interconnect_M01_AXI_WREADY),
        .S_AXI_WSTRB({system_interconnect_M01_AXI_WSTRB,system_interconnect_M01_AXI_WSTRB,system_interconnect_M01_AXI_WSTRB,system_interconnect_M01_AXI_WSTRB}),
        .S_AXI_WVALID(system_interconnect_M01_AXI_WVALID),
        .clk(source_100mhz_sys_clk),
        .resetn(source_100mhz_sys_resetn));
  source_100mhz_imp_MSWE0P source_100mhz
       (.clk_100mhz(source_100mhz_sys_clk),
        .clk_50mhz(source_100mhz_clk_50mhz),
        .clk_in(CLK100MHZ),
        .gtx_clk(source_100mhz_gtx_clk),
        .phy_clk(ETH_REFCLK),
        .resetn_in(CPU_RESETN),
        .sys_resetn(source_100mhz_sys_resetn));
  top_level_system_ila_0_0 system_ila
       (.SLOT_0_AXIS_tdata(ethernet_m_axis_rxs_TDATA[0]),
        .SLOT_0_AXIS_tdest(1'b0),
        .SLOT_0_AXIS_tid(1'b0),
        .SLOT_0_AXIS_tkeep(ethernet_m_axis_rxs_TKEEP[0]),
        .SLOT_0_AXIS_tlast(ethernet_m_axis_rxs_TLAST),
        .SLOT_0_AXIS_tready(ethernet_m_axis_rxs_TREADY),
        .SLOT_0_AXIS_tstrb(1'b1),
        .SLOT_0_AXIS_tuser(1'b0),
        .SLOT_0_AXIS_tvalid(ethernet_m_axis_rxs_TVALID),
        .SLOT_1_AXIS_tdata(ethernet_m_axis_rxd_TDATA[0]),
        .SLOT_1_AXIS_tdest(1'b0),
        .SLOT_1_AXIS_tid(1'b0),
        .SLOT_1_AXIS_tkeep(ethernet_m_axis_rxd_TKEEP[0]),
        .SLOT_1_AXIS_tlast(ethernet_m_axis_rxd_TLAST),
        .SLOT_1_AXIS_tready(ethernet_m_axis_rxd_TREADY),
        .SLOT_1_AXIS_tstrb(1'b1),
        .SLOT_1_AXIS_tuser(1'b0),
        .SLOT_1_AXIS_tvalid(ethernet_m_axis_rxd_TVALID),
        .SLOT_2_AXIS_tdata(s_axis_txc_1_TDATA[0]),
        .SLOT_2_AXIS_tdest(1'b0),
        .SLOT_2_AXIS_tid(1'b0),
        .SLOT_2_AXIS_tkeep(s_axis_txc_1_TKEEP[0]),
        .SLOT_2_AXIS_tlast(s_axis_txc_1_TLAST),
        .SLOT_2_AXIS_tready(s_axis_txc_1_TREADY),
        .SLOT_2_AXIS_tstrb(1'b1),
        .SLOT_2_AXIS_tuser(1'b0),
        .SLOT_2_AXIS_tvalid(s_axis_txc_1_TVALID),
        .SLOT_3_AXIS_tdata(s_axis_txd_1_TDATA[0]),
        .SLOT_3_AXIS_tdest(1'b0),
        .SLOT_3_AXIS_tid(1'b0),
        .SLOT_3_AXIS_tkeep(s_axis_txd_1_TKEEP[0]),
        .SLOT_3_AXIS_tlast(s_axis_txd_1_TLAST),
        .SLOT_3_AXIS_tready(s_axis_txd_1_TREADY),
        .SLOT_3_AXIS_tstrb(1'b1),
        .SLOT_3_AXIS_tuser(1'b0),
        .SLOT_3_AXIS_tvalid(s_axis_txd_1_TVALID),
        .clk(source_100mhz_sys_clk),
        .probe0(ethernet_reg_dbg_rxs_status_word[0]),
        .probe1(ethernet_reg_dbg_rx_eth_src[0]),
        .probe10(ethernet_reg_dbg_inc_ip4_checksum[0]),
        .probe11(ethernet_reg_dbg_ping_req_type[0]),
        .probe12(ethernet_reg_dbg_ping_req_id[0]),
        .probe13(ethernet_reg_dbg_ping_req_seq[0]),
        .probe14(ethernet_reg_dbg_inc_ip4_src_ip[0]),
        .probe15(ethernet_reg_dbg_inc_ip4_dst_ip[0]),
        .probe2(ethernet_reg_dbg_rx_eth_dst[0]),
        .probe3(ethernet_reg_dbg_rx_eth_type[0]),
        .probe4(ethernet_reg_dbg_is_icmp_ping),
        .probe5(ethernet_reg_dbg_inc_ip4_ver_dsf[0]),
        .probe6(ethernet_reg_dbg_inc_ip4_length[0]),
        .probe7(ethernet_reg_dbg_inc_ip4_id[0]),
        .probe8(ethernet_reg_dbg_inc_ip4_flags[0]),
        .probe9(ethernet_reg_dbg_inc_ip4_ttl_prot[0]),
        .resetn(source_100mhz_sys_resetn));
  top_level_smartconnect_0_0 system_interconnect
       (.M00_AXI_araddr(system_interconnect_M00_AXI_ARADDR),
        .M00_AXI_arprot(system_interconnect_M00_AXI_ARPROT),
        .M00_AXI_arready(system_interconnect_M00_AXI_ARREADY),
        .M00_AXI_arvalid(system_interconnect_M00_AXI_ARVALID),
        .M00_AXI_awaddr(system_interconnect_M00_AXI_AWADDR),
        .M00_AXI_awprot(system_interconnect_M00_AXI_AWPROT),
        .M00_AXI_awready(system_interconnect_M00_AXI_AWREADY),
        .M00_AXI_awvalid(system_interconnect_M00_AXI_AWVALID),
        .M00_AXI_bid(1'b0),
        .M00_AXI_bready(system_interconnect_M00_AXI_BREADY),
        .M00_AXI_bresp(system_interconnect_M00_AXI_BRESP),
        .M00_AXI_buser(1'b0),
        .M00_AXI_bvalid(system_interconnect_M00_AXI_BVALID),
        .M00_AXI_rdata(system_interconnect_M00_AXI_RDATA[0]),
        .M00_AXI_rid(1'b0),
        .M00_AXI_rlast(1'b0),
        .M00_AXI_rready(system_interconnect_M00_AXI_RREADY),
        .M00_AXI_rresp(system_interconnect_M00_AXI_RRESP),
        .M00_AXI_ruser(1'b0),
        .M00_AXI_rvalid(system_interconnect_M00_AXI_RVALID),
        .M00_AXI_wdata(system_interconnect_M00_AXI_WDATA),
        .M00_AXI_wready(system_interconnect_M00_AXI_WREADY),
        .M00_AXI_wstrb(system_interconnect_M00_AXI_WSTRB),
        .M00_AXI_wvalid(system_interconnect_M00_AXI_WVALID),
        .M01_AXI_araddr(system_interconnect_M01_AXI_ARADDR),
        .M01_AXI_arprot(system_interconnect_M01_AXI_ARPROT),
        .M01_AXI_arready(system_interconnect_M01_AXI_ARREADY),
        .M01_AXI_arvalid(system_interconnect_M01_AXI_ARVALID),
        .M01_AXI_awaddr(system_interconnect_M01_AXI_AWADDR),
        .M01_AXI_awprot(system_interconnect_M01_AXI_AWPROT),
        .M01_AXI_awready(system_interconnect_M01_AXI_AWREADY),
        .M01_AXI_awvalid(system_interconnect_M01_AXI_AWVALID),
        .M01_AXI_bid(1'b0),
        .M01_AXI_bready(system_interconnect_M01_AXI_BREADY),
        .M01_AXI_bresp(system_interconnect_M01_AXI_BRESP),
        .M01_AXI_buser(1'b0),
        .M01_AXI_bvalid(system_interconnect_M01_AXI_BVALID),
        .M01_AXI_rdata(system_interconnect_M01_AXI_RDATA[0]),
        .M01_AXI_rid(1'b0),
        .M01_AXI_rlast(1'b0),
        .M01_AXI_rready(system_interconnect_M01_AXI_RREADY),
        .M01_AXI_rresp(system_interconnect_M01_AXI_RRESP),
        .M01_AXI_ruser(1'b0),
        .M01_AXI_rvalid(system_interconnect_M01_AXI_RVALID),
        .M01_AXI_wdata(system_interconnect_M01_AXI_WDATA),
        .M01_AXI_wready(system_interconnect_M01_AXI_WREADY),
        .M01_AXI_wstrb(system_interconnect_M01_AXI_WSTRB),
        .M01_AXI_wvalid(system_interconnect_M01_AXI_WVALID),
        .M02_AXI_araddr(system_interconnect_M02_AXI_ARADDR),
        .M02_AXI_arready(system_interconnect_M02_AXI_ARREADY),
        .M02_AXI_arvalid(system_interconnect_M02_AXI_ARVALID),
        .M02_AXI_awaddr(system_interconnect_M02_AXI_AWADDR),
        .M02_AXI_awready(system_interconnect_M02_AXI_AWREADY),
        .M02_AXI_awvalid(system_interconnect_M02_AXI_AWVALID),
        .M02_AXI_bid(1'b0),
        .M02_AXI_bready(system_interconnect_M02_AXI_BREADY),
        .M02_AXI_bresp(system_interconnect_M02_AXI_BRESP),
        .M02_AXI_buser(1'b0),
        .M02_AXI_bvalid(system_interconnect_M02_AXI_BVALID),
        .M02_AXI_rdata(system_interconnect_M02_AXI_RDATA[0]),
        .M02_AXI_rid(1'b0),
        .M02_AXI_rlast(1'b0),
        .M02_AXI_rready(system_interconnect_M02_AXI_RREADY),
        .M02_AXI_rresp(system_interconnect_M02_AXI_RRESP),
        .M02_AXI_ruser(1'b0),
        .M02_AXI_rvalid(system_interconnect_M02_AXI_RVALID),
        .M02_AXI_wdata(system_interconnect_M02_AXI_WDATA),
        .M02_AXI_wready(system_interconnect_M02_AXI_WREADY),
        .M02_AXI_wstrb(system_interconnect_M02_AXI_WSTRB),
        .M02_AXI_wvalid(system_interconnect_M02_AXI_WVALID),
        .S00_AXI_araddr(uart_axi_bridge_M_AXI_ARADDR),
        .S00_AXI_arburst({1'b0,1'b1}),
        .S00_AXI_arcache({1'b0,1'b0,1'b1,1'b1}),
        .S00_AXI_arid(1'b0),
        .S00_AXI_arlen(1'b0),
        .S00_AXI_arlock(1'b0),
        .S00_AXI_arprot({1'b0,1'b0,1'b0}),
        .S00_AXI_arqos({1'b0,1'b0,1'b0,1'b0}),
        .S00_AXI_arready(uart_axi_bridge_M_AXI_ARREADY),
        .S00_AXI_arregion({1'b0,1'b0,1'b0,1'b0}),
        .S00_AXI_arsize({1'b0,1'b1,1'b0}),
        .S00_AXI_aruser(1'b0),
        .S00_AXI_arvalid(uart_axi_bridge_M_AXI_ARVALID),
        .S00_AXI_awaddr(uart_axi_bridge_M_AXI_AWADDR),
        .S00_AXI_awburst({1'b0,1'b1}),
        .S00_AXI_awcache({1'b0,1'b0,1'b1,1'b1}),
        .S00_AXI_awid(1'b0),
        .S00_AXI_awlen(1'b0),
        .S00_AXI_awlock(1'b0),
        .S00_AXI_awprot({1'b0,1'b0,1'b0}),
        .S00_AXI_awqos({1'b0,1'b0,1'b0,1'b0}),
        .S00_AXI_awready(uart_axi_bridge_M_AXI_AWREADY),
        .S00_AXI_awregion({1'b0,1'b0,1'b0,1'b0}),
        .S00_AXI_awsize({1'b0,1'b1,1'b0}),
        .S00_AXI_awuser(1'b0),
        .S00_AXI_awvalid(uart_axi_bridge_M_AXI_AWVALID),
        .S00_AXI_bready(uart_axi_bridge_M_AXI_BREADY),
        .S00_AXI_bresp(uart_axi_bridge_M_AXI_BRESP),
        .S00_AXI_bvalid(uart_axi_bridge_M_AXI_BVALID),
        .S00_AXI_rdata(uart_axi_bridge_M_AXI_RDATA),
        .S00_AXI_rready(uart_axi_bridge_M_AXI_RREADY),
        .S00_AXI_rresp(uart_axi_bridge_M_AXI_RRESP),
        .S00_AXI_rvalid(uart_axi_bridge_M_AXI_RVALID),
        .S00_AXI_wdata(uart_axi_bridge_M_AXI_WDATA),
        .S00_AXI_wid(1'b0),
        .S00_AXI_wlast(1'b0),
        .S00_AXI_wready(uart_axi_bridge_M_AXI_WREADY),
        .S00_AXI_wstrb(uart_axi_bridge_M_AXI_WSTRB),
        .S00_AXI_wuser(1'b0),
        .S00_AXI_wvalid(uart_axi_bridge_M_AXI_WVALID),
        .aclk(source_100mhz_sys_clk),
        .aresetn(source_100mhz_sys_resetn));
  uart_axi_bridge_imp_1TNTD43 uart_axi_bridge
       (.M_AXI_araddr(uart_axi_bridge_M_AXI_ARADDR),
        .M_AXI_arready(uart_axi_bridge_M_AXI_ARREADY),
        .M_AXI_arvalid(uart_axi_bridge_M_AXI_ARVALID),
        .M_AXI_awaddr(uart_axi_bridge_M_AXI_AWADDR),
        .M_AXI_awready(uart_axi_bridge_M_AXI_AWREADY),
        .M_AXI_awvalid(uart_axi_bridge_M_AXI_AWVALID),
        .M_AXI_bready(uart_axi_bridge_M_AXI_BREADY),
        .M_AXI_bresp(uart_axi_bridge_M_AXI_BRESP),
        .M_AXI_bvalid(uart_axi_bridge_M_AXI_BVALID),
        .M_AXI_rdata(uart_axi_bridge_M_AXI_RDATA),
        .M_AXI_rready(uart_axi_bridge_M_AXI_RREADY),
        .M_AXI_rresp(uart_axi_bridge_M_AXI_RRESP),
        .M_AXI_rvalid(uart_axi_bridge_M_AXI_RVALID),
        .M_AXI_wdata(uart_axi_bridge_M_AXI_WDATA),
        .M_AXI_wready(uart_axi_bridge_M_AXI_WREADY),
        .M_AXI_wstrb(uart_axi_bridge_M_AXI_WSTRB),
        .M_AXI_wvalid(uart_axi_bridge_M_AXI_WVALID),
        .UART_rxd(UART_rxd),
        .UART_txd(UART_txd),
        .s_axi_aclk(source_100mhz_sys_clk),
        .s_axi_aresetn(source_100mhz_sys_resetn));
endmodule

module uart_axi_bridge_imp_1TNTD43
   (M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    UART_rxd,
    UART_txd,
    s_axi_aclk,
    s_axi_aresetn);
  output M_AXI_araddr;
  input [0:0]M_AXI_arready;
  output [0:0]M_AXI_arvalid;
  output M_AXI_awaddr;
  input [0:0]M_AXI_awready;
  output [0:0]M_AXI_awvalid;
  output [0:0]M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input [0:0]M_AXI_bvalid;
  input M_AXI_rdata;
  output [0:0]M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input [0:0]M_AXI_rvalid;
  output M_AXI_wdata;
  input [0:0]M_AXI_wready;
  output M_AXI_wstrb;
  output [0:0]M_AXI_wvalid;
  input UART_rxd;
  output UART_txd;
  input s_axi_aclk;
  input s_axi_aresetn;

  wire [63:0]\^M_AXI_araddr ;
  wire [0:0]M_AXI_arready;
  wire \^M_AXI_arvalid ;
  wire [63:0]\^M_AXI_awaddr ;
  wire [0:0]M_AXI_awready;
  wire \^M_AXI_awvalid ;
  wire \^M_AXI_bready ;
  wire [1:0]M_AXI_bresp;
  wire [0:0]M_AXI_bvalid;
  wire M_AXI_rdata;
  wire \^M_AXI_rready ;
  wire [1:0]M_AXI_rresp;
  wire [0:0]M_AXI_rvalid;
  wire [31:0]\^M_AXI_wdata ;
  wire [0:0]M_AXI_wready;
  wire [3:0]\^M_AXI_wstrb ;
  wire \^M_AXI_wvalid ;
  wire UART_rxd;
  wire UART_txd;
  wire [31:0]axi_uart_bridge_M_UART_ARADDR;
  wire axi_uart_bridge_M_UART_ARREADY;
  wire axi_uart_bridge_M_UART_ARVALID;
  wire [31:0]axi_uart_bridge_M_UART_AWADDR;
  wire axi_uart_bridge_M_UART_AWREADY;
  wire axi_uart_bridge_M_UART_AWVALID;
  wire axi_uart_bridge_M_UART_BREADY;
  wire [1:0]axi_uart_bridge_M_UART_BRESP;
  wire axi_uart_bridge_M_UART_BVALID;
  wire [31:0]axi_uart_bridge_M_UART_RDATA;
  wire axi_uart_bridge_M_UART_RREADY;
  wire [1:0]axi_uart_bridge_M_UART_RRESP;
  wire axi_uart_bridge_M_UART_RVALID;
  wire [31:0]axi_uart_bridge_M_UART_WDATA;
  wire axi_uart_bridge_M_UART_WREADY;
  wire [3:0]axi_uart_bridge_M_UART_WSTRB;
  wire axi_uart_bridge_M_UART_WVALID;
  wire axi_uartlite_interrupt;
  wire s_axi_aclk;
  wire s_axi_aresetn;

  assign M_AXI_araddr = \^M_AXI_araddr [0];
  assign M_AXI_arvalid[0] = \^M_AXI_arvalid ;
  assign M_AXI_awaddr = \^M_AXI_awaddr [0];
  assign M_AXI_awvalid[0] = \^M_AXI_awvalid ;
  assign M_AXI_bready[0] = \^M_AXI_bready ;
  assign M_AXI_rready[0] = \^M_AXI_rready ;
  assign M_AXI_wdata = \^M_AXI_wdata [0];
  assign M_AXI_wstrb = \^M_AXI_wstrb [0];
  assign M_AXI_wvalid[0] = \^M_AXI_wvalid ;
  top_level_axi_uart_bridge_0_0 axi_uart_bridge
       (.M_AXI_ARADDR(\^M_AXI_araddr ),
        .M_AXI_ARREADY(M_AXI_arready),
        .M_AXI_ARVALID(\^M_AXI_arvalid ),
        .M_AXI_AWADDR(\^M_AXI_awaddr ),
        .M_AXI_AWREADY(M_AXI_awready),
        .M_AXI_AWVALID(\^M_AXI_awvalid ),
        .M_AXI_BREADY(\^M_AXI_bready ),
        .M_AXI_BRESP(M_AXI_bresp),
        .M_AXI_BVALID(M_AXI_bvalid),
        .M_AXI_RDATA({M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata,M_AXI_rdata}),
        .M_AXI_RREADY(\^M_AXI_rready ),
        .M_AXI_RRESP(M_AXI_rresp),
        .M_AXI_RVALID(M_AXI_rvalid),
        .M_AXI_WDATA(\^M_AXI_wdata ),
        .M_AXI_WREADY(M_AXI_wready),
        .M_AXI_WSTRB(\^M_AXI_wstrb ),
        .M_AXI_WVALID(\^M_AXI_wvalid ),
        .M_UART_ARADDR(axi_uart_bridge_M_UART_ARADDR),
        .M_UART_ARREADY(axi_uart_bridge_M_UART_ARREADY),
        .M_UART_ARVALID(axi_uart_bridge_M_UART_ARVALID),
        .M_UART_AWADDR(axi_uart_bridge_M_UART_AWADDR),
        .M_UART_AWREADY(axi_uart_bridge_M_UART_AWREADY),
        .M_UART_AWVALID(axi_uart_bridge_M_UART_AWVALID),
        .M_UART_BREADY(axi_uart_bridge_M_UART_BREADY),
        .M_UART_BRESP(axi_uart_bridge_M_UART_BRESP),
        .M_UART_BVALID(axi_uart_bridge_M_UART_BVALID),
        .M_UART_RDATA(axi_uart_bridge_M_UART_RDATA),
        .M_UART_RREADY(axi_uart_bridge_M_UART_RREADY),
        .M_UART_RRESP(axi_uart_bridge_M_UART_RRESP),
        .M_UART_RVALID(axi_uart_bridge_M_UART_RVALID),
        .M_UART_WDATA(axi_uart_bridge_M_UART_WDATA),
        .M_UART_WREADY(axi_uart_bridge_M_UART_WREADY),
        .M_UART_WSTRB(axi_uart_bridge_M_UART_WSTRB),
        .M_UART_WVALID(axi_uart_bridge_M_UART_WVALID),
        .UART_INT(axi_uartlite_interrupt),
        .aclk(s_axi_aclk),
        .aresetn(s_axi_aresetn));
  top_level_axi_uartlite_0_0 axi_uartlite
       (.interrupt(axi_uartlite_interrupt),
        .rx(UART_rxd),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(axi_uart_bridge_M_UART_ARADDR[3:0]),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(axi_uart_bridge_M_UART_ARREADY),
        .s_axi_arvalid(axi_uart_bridge_M_UART_ARVALID),
        .s_axi_awaddr(axi_uart_bridge_M_UART_AWADDR[3:0]),
        .s_axi_awready(axi_uart_bridge_M_UART_AWREADY),
        .s_axi_awvalid(axi_uart_bridge_M_UART_AWVALID),
        .s_axi_bready(axi_uart_bridge_M_UART_BREADY),
        .s_axi_bresp(axi_uart_bridge_M_UART_BRESP),
        .s_axi_bvalid(axi_uart_bridge_M_UART_BVALID),
        .s_axi_rdata(axi_uart_bridge_M_UART_RDATA),
        .s_axi_rready(axi_uart_bridge_M_UART_RREADY),
        .s_axi_rresp(axi_uart_bridge_M_UART_RRESP),
        .s_axi_rvalid(axi_uart_bridge_M_UART_RVALID),
        .s_axi_wdata(axi_uart_bridge_M_UART_WDATA),
        .s_axi_wready(axi_uart_bridge_M_UART_WREADY),
        .s_axi_wstrb(axi_uart_bridge_M_UART_WSTRB),
        .s_axi_wvalid(axi_uart_bridge_M_UART_WVALID),
        .tx(UART_txd));
endmodule
