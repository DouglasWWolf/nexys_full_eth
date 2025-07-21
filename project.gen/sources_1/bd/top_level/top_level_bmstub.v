// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module top_level (
  UART_rxd,
  UART_txd,
  MDIO_mdc,
  MDIO_mdio_i,
  MDIO_mdio_o,
  MDIO_mdio_t,
  CLK100MHZ,
  CPU_RESETN,
  ETH_CRSDV,
  ETH_TXD,
  ETH_TXEN,
  ETH_RXD,
  ETH_RXERR,
  ETH_RSTN,
  ETH_REFCLK
);

  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 UART RxD" *)
  (* X_INTERFACE_MODE = "master UART" *)
  input UART_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 UART TxD" *)
  output UART_txd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mdio:1.0 MDIO MDC" *)
  (* X_INTERFACE_MODE = "master MDIO" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME MDIO, CAN_DEBUG false" *)
  output MDIO_mdc;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mdio:1.0 MDIO MDIO_I" *)
  input MDIO_mdio_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mdio:1.0 MDIO MDIO_O" *)
  output MDIO_mdio_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:mdio:1.0 MDIO MDIO_T" *)
  output MDIO_mdio_t;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK100MHZ CLK" *)
  (* X_INTERFACE_MODE = "slave CLK.CLK100MHZ" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK100MHZ, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN top_level_CLK100MHZ, INSERT_VIP 0" *)
  input CLK100MHZ;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.CPU_RESETN RST" *)
  (* X_INTERFACE_MODE = "slave RST.CPU_RESETN" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.CPU_RESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  input CPU_RESETN;
  (* X_INTERFACE_IGNORE = "true" *)
  input ETH_CRSDV;
  (* X_INTERFACE_IGNORE = "true" *)
  output [1:0]ETH_TXD;
  (* X_INTERFACE_IGNORE = "true" *)
  output ETH_TXEN;
  (* X_INTERFACE_IGNORE = "true" *)
  input [1:0]ETH_RXD;
  (* X_INTERFACE_IGNORE = "true" *)
  input ETH_RXERR;
  (* X_INTERFACE_IGNORE = "true" *)
  output [0:0]ETH_RSTN;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ETH_REFCLK CLK" *)
  (* X_INTERFACE_MODE = "master CLK.ETH_REFCLK" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ETH_REFCLK, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 45.0, CLK_DOMAIN /source_100mhz/system_clock_clk_out1, INSERT_VIP 0" *)
  output ETH_REFCLK;

  // stub module has no contents

endmodule
