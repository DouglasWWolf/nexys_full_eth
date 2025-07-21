//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Mon Jul 21 06:33:02 2025
//Host        : wolf-super-server running 64-bit Ubuntu 20.04.6 LTS
//Command     : generate_target top_level_wrapper.bd
//Design      : top_level_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module top_level_wrapper
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
    MDIO_mdio_io,
    UART_rxd,
    UART_txd);
  input CLK100MHZ;
  input CPU_RESETN;
  input ETH_CRSDV;
  output ETH_REFCLK;
  output [0:0]ETH_RSTN;
  input [1:0]ETH_RXD;
  input ETH_RXERR;
  output [1:0]ETH_TXD;
  output ETH_TXEN;
  output MDIO_mdc;
  inout MDIO_mdio_io;
  input UART_rxd;
  output UART_txd;

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
  wire MDIO_mdio_io;
  wire MDIO_mdio_o;
  wire MDIO_mdio_t;
  wire UART_rxd;
  wire UART_txd;

  IOBUF MDIO_mdio_iobuf
       (.I(MDIO_mdio_o),
        .IO(MDIO_mdio_io),
        .O(MDIO_mdio_i),
        .T(MDIO_mdio_t));
  top_level top_level_i
       (.CLK100MHZ(CLK100MHZ),
        .CPU_RESETN(CPU_RESETN),
        .ETH_CRSDV(ETH_CRSDV),
        .ETH_REFCLK(ETH_REFCLK),
        .ETH_RSTN(ETH_RSTN),
        .ETH_RXD(ETH_RXD),
        .ETH_RXERR(ETH_RXERR),
        .ETH_TXD(ETH_TXD),
        .ETH_TXEN(ETH_TXEN),
        .MDIO_mdc(MDIO_mdc),
        .MDIO_mdio_i(MDIO_mdio_i),
        .MDIO_mdio_o(MDIO_mdio_o),
        .MDIO_mdio_t(MDIO_mdio_t),
        .UART_rxd(UART_rxd),
        .UART_txd(UART_txd));
endmodule
