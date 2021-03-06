//-----------------------------------------------------------------------------
// Title         :
// Project       : ASYNC FIFO
//-----------------------------------------------------------------------------
// File          : async_fifo_show_ahead.v
// Author        : changhui.liu
// Created       : 04.04.2018
// Last modified : 04.04.2018
//-----------------------------------------------------------------------------
// Description :
//
//-----------------------------------------------------------------------------
// Copyright (c) 2018 by Free This model is the confidential and
// proprietary property of Free and the possession or use of this
// file requires a written license from Free.
//------------------------------------------------------------------------------
// Modification history :
// 04.04.2018 : created
//-----------------------------------------------------------------------------


module async_fifo_show_ahead
  (/*AUTOARG*/
   // Outputs
   q, wrusedw, rdusedw, prog_full, prog_empty, wrfull, rdempty,
   // Inputs
   wrclk, rdclk, reset_n, wrreq, data, rdreq
                                                                       );
   parameter                    FIFO_DATA_WIDTH = 32;
   parameter                    FIFO_ADDR_WIDTH = 8;

   parameter                    PROG_FULL_THR = 0;
   parameter                    PROG_EMPTY_THR = 0;

   input                        wrclk;
   input                        rdclk;
   input                        reset_n;

   input                        wrreq;
   input [FIFO_DATA_WIDTH-1:0]  data;
   input                        rdreq;
   output [FIFO_DATA_WIDTH-1:0] q;
   output [FIFO_ADDR_WIDTH-1:0] wrusedw;
   output [FIFO_ADDR_WIDTH-1:0] rdusedw;
   output                       prog_full;
   output                       prog_empty;
   output                       wrfull;
   output                       rdempty;


   wire                         wren;

   wire [FIFO_ADDR_WIDTH-1:0]   wraddr;
   wire [FIFO_ADDR_WIDTH-1:0]   rdaddr;

   wire [FIFO_ADDR_WIDTH:0]     wrq2_rdptr;
   wire [FIFO_ADDR_WIDTH:0]     rdq2_wrptr;

   wire [FIFO_ADDR_WIDTH:0]     wrptr;
   wire [FIFO_ADDR_WIDTH:0]     rdptr;





   sync_ram_std_dc
     #(/*AUTOINSTPARAM*/
       // Parameters
       .FIFO_DATA_WIDTH                 (FIFO_DATA_WIDTH               ),
       .FIFO_ADDR_WIDTH                 (FIFO_ADDR_WIDTH               ))
   sync_ram_std_dc_inst
     (.wr_q(                                                           ),
      /*AUTOINST*/
      // Outputs
      .q                                (q[FIFO_DATA_WIDTH-1:0]        ),
      // Inputs
      .wrclk                            (wrclk                         ),
      .rdclk                            (rdclk                         ),
      .wren                             (wren                          ),
      .wraddr                           (wraddr[FIFO_ADDR_WIDTH-1:0]   ),
      .data                             (data[FIFO_DATA_WIDTH-1:0]     ),
      .rdaddr                           (rdaddr[FIFO_ADDR_WIDTH-1:0]   ));







   async_fifo_show_ahead_wr_task_logic
     #(/*AUTOINSTPARAM*/
       // Parameters
       .FIFO_ADDR_WIDTH                 (FIFO_ADDR_WIDTH               ),
       .PROG_FULL_THR                   (PROG_FULL_THR                 ),
       .FIFO_DATA_WIDTH                 (FIFO_DATA_WIDTH               ))
   async_fifo_show_ahead_wr_task_logic_inst
     (
      /*AUTOINST*/
      // Outputs
      .wrusedw                          (wrusedw[FIFO_ADDR_WIDTH-1:0]  ),
      .prog_full                        (prog_full                     ),
      .wrfull                           (wrfull                        ),
      .wren                             (wren                          ),
      .wraddr                           (wraddr[FIFO_ADDR_WIDTH-1:0]   ),
      .wrptr                            (wrptr[FIFO_ADDR_WIDTH:0]      ),
      // Inputs
      .wrclk                            (wrclk                         ),
      .reset_n                          (reset_n                       ),
      .wrreq                            (wrreq                         ),
      .wrq2_rdptr                       (wrq2_rdptr[FIFO_ADDR_WIDTH:0] ));





   sync_w2r
     #(/*AUTOINSTPARAM*/
       // Parameters
       .FIFO_ADDR_WIDTH                 (FIFO_ADDR_WIDTH               ))
   sync_w2r_inst
     (
      /*AUTOINST*/
      // Outputs
      .rdq2_wrptr                       (rdq2_wrptr[FIFO_ADDR_WIDTH:0] ),
      // Inputs
      .rdclk                            (rdclk                         ),
      .reset_n                          (reset_n                       ),
      .wrptr                            (wrptr[FIFO_ADDR_WIDTH:0]      ));







   async_fifo_show_ahead_rd_task_logic
     #(/*AUTOINSTPARAM*/
       // Parameters
       .FIFO_ADDR_WIDTH                 (FIFO_ADDR_WIDTH               ),
       .PROG_EMPTY_THR                  (PROG_EMPTY_THR                ),
       .FIFO_DATA_WIDTH                 (FIFO_DATA_WIDTH               ))
   async_fifo_show_ahead_rd_task_logic_inst
     (
      /*AUTOINST*/
      // Outputs
      .rdusedw                          (rdusedw[FIFO_ADDR_WIDTH-1:0]  ),
      .prog_empty                       (prog_empty                    ),
      .rdempty                          (rdempty                       ),
      .rdaddr                           (rdaddr[FIFO_ADDR_WIDTH-1:0]   ),
      .rdptr                            (rdptr[FIFO_ADDR_WIDTH:0]      ),
      // Inputs
      .rdclk                            (rdclk                         ),
      .reset_n                          (reset_n                       ),
      .rdreq                            (rdreq                         ),
      .rdq2_wrptr                       (rdq2_wrptr[FIFO_ADDR_WIDTH:0] ));





   sync_r2w
     #(/*AUTOINSTPARAM*/
       // Parameters
       .FIFO_ADDR_WIDTH                 (FIFO_ADDR_WIDTH               ))
   sync_r2w_inst
     (
      /*AUTOINST*/
      // Outputs
      .wrq2_rdptr                       (wrq2_rdptr[FIFO_ADDR_WIDTH:0] ),
      // Inputs
      .wrclk                            (wrclk                         ),
      .reset_n                          (reset_n                       ),
      .rdptr                            (rdptr[FIFO_ADDR_WIDTH:0]      ));

endmodule
