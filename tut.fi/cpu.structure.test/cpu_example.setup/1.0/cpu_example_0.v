//-----------------------------------------------------------------------------
// File          : cpu_example_0.v
// Creation date : 28.11.2017
// Creation time : 16:31:16
// Description   : An example CPU with example core and a number of wishbone peripherals, one of which is SPI bridge.
// Created by    : TermosPullo
// Tool : Kactus2 3.4.1184 32-bit
// Plugin : Verilog generator 2.1
// This file was generated based on IP-XACT component tut.fi:cpu.structure:cpu_example:1.0
// whose XML file is D:/kactus2Repos/ipxactexamplelib/tut.fi/cpu.structure/cpu_example/1.0/cpu_example.1.0.xml
//-----------------------------------------------------------------------------

module cpu_example_0 #(
    parameter                              ADDR_WIDTH       = 10,    // Width of the addresses.
    parameter                              DATA_WIDTH       = 16,    // Width for data in registers and instructions.
    parameter                              INSTRUCTION_ADDRESS_WIDTH = 8,    // Width of an instruction address.
    parameter                              INSTRUCTION_WIDTH = 28,    // Total width of an instruction
    parameter                              SUPPORTED_MEMORY = 1024,    // How much the system supports memory in total.
    parameter                              WB_ADDRESS_BASE  = 256,    // Base address for wishbone in the system memory.
    parameter                              WB_SLAVE0_BASE   = 32,    // Base address for wishbone slave 0.
    parameter                              WB_SLAVE1_BASE   = 160,    // Base address for wishbone slave 1.
    parameter                              WB_SLAVE2_BASE   = 288,    // Base address for wishbone slave 2.
    parameter                              WB_SLAVE3_BASE   = 416,    // Base address for wishbone slave 3.
    parameter                              WB_SLAVE_RANGE   = 128    // How much space is allocated for each slave.
) (
    // Interface: instructions
    input          [27:0]               instruction_feed,
    output         [7:0]                iaddr_o,

    // Interface: local_data
    input          [15:0]               local_read_data,
    output         [9:0]                local_address_o,
    output         [15:0]               local_write_data,
    output                              local_write_o,

    // Interface: spi_master
    input                               data_in,
    output                              clk_out,
    output                              data_out,
    output                              slave_select_out,

    // Interface: wb_system
    input                               clk_i,    // The mandatory clock, as this is synchronous logic.
    input                               rst_i    // The mandatory reset, as this is synchronous logic.
);

    // wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_master wires:
    wire        wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterack;
    wire [9:0]  wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masteradr;
    wire        wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_mastercyc;
    wire [15:0] wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterdat_ms;
    wire [15:0] wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterdat_sm;
    wire        wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_mastererr;
    wire        wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterstb;
    wire        wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterwe;
    // wishbone_bridge_wb_system_to_wb_system wires:
    wire        wishbone_bridge_wb_system_to_wb_systemclk;
    wire        wishbone_bridge_wb_system_to_wb_systemrst;
    // wishbone_bus_slave_0_to_external_mem_large_wb_slave wires:
    wire        wishbone_bus_slave_0_to_external_mem_large_wb_slaveack;
    wire [9:0]  wishbone_bus_slave_0_to_external_mem_large_wb_slaveadr;
    wire        wishbone_bus_slave_0_to_external_mem_large_wb_slavecyc;
    wire [15:0] wishbone_bus_slave_0_to_external_mem_large_wb_slavedat_ms;
    wire [15:0] wishbone_bus_slave_0_to_external_mem_large_wb_slavedat_sm;
    wire        wishbone_bus_slave_0_to_external_mem_large_wb_slaveerr;
    wire        wishbone_bus_slave_0_to_external_mem_large_wb_slavestb;
    wire        wishbone_bus_slave_0_to_external_mem_large_wb_slavewe;
    // external_mem_hash_wb_slave_to_wishbone_bus_slave_1 wires:
    wire        external_mem_hash_wb_slave_to_wishbone_bus_slave_1ack;
    wire [9:0]  external_mem_hash_wb_slave_to_wishbone_bus_slave_1adr;
    wire        external_mem_hash_wb_slave_to_wishbone_bus_slave_1cyc;
    wire [15:0] external_mem_hash_wb_slave_to_wishbone_bus_slave_1dat_ms;
    wire [15:0] external_mem_hash_wb_slave_to_wishbone_bus_slave_1dat_sm;
    wire        external_mem_hash_wb_slave_to_wishbone_bus_slave_1err;
    wire        external_mem_hash_wb_slave_to_wishbone_bus_slave_1stb;
    wire        external_mem_hash_wb_slave_to_wishbone_bus_slave_1we;
    // sum_buffer_wb_slave_to_wishbone_bus_slave_2 wires:
    wire        sum_buffer_wb_slave_to_wishbone_bus_slave_2ack;
    wire [9:0]  sum_buffer_wb_slave_to_wishbone_bus_slave_2adr;
    wire        sum_buffer_wb_slave_to_wishbone_bus_slave_2cyc;
    wire [15:0] sum_buffer_wb_slave_to_wishbone_bus_slave_2dat_ms;
    wire [15:0] sum_buffer_wb_slave_to_wishbone_bus_slave_2dat_sm;
    wire        sum_buffer_wb_slave_to_wishbone_bus_slave_2err;
    wire        sum_buffer_wb_slave_to_wishbone_bus_slave_2stb;
    wire        sum_buffer_wb_slave_to_wishbone_bus_slave_2we;
    // core_peripheral_access_to_wishbone_bridge_contoller wires:
    wire [9:0]  core_peripheral_access_to_wishbone_bridge_contolleraddress;
    wire [15:0] core_peripheral_access_to_wishbone_bridge_contollerdata_ms;
    wire [15:0] core_peripheral_access_to_wishbone_bridge_contollerdata_sm;
    wire        core_peripheral_access_to_wishbone_bridge_contollermaster_rdy;
    wire        core_peripheral_access_to_wishbone_bridge_contollerslave_rdy;
    wire        core_peripheral_access_to_wishbone_bridge_contollerwe;
    // wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slave wires:
    wire        wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slaveack;
    wire [9:0]  wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slaveadr;
    wire        wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavecyc;
    wire [15:0] wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavedat_ms;
    wire [15:0] wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavedat_sm;
    wire        wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slaveerr;
    wire        wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavestb;
    wire        wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavewe;
    // core_instructions_to_instructions wires:
    wire [7:0]  core_instructions_to_instructionsaddress;
    wire [27:0] core_instructions_to_instructionsread_data;
    // core_local_data_to_local_data wires:
    wire [9:0]  core_local_data_to_local_dataaddress;
    wire [15:0] core_local_data_to_local_dataread_data;
    wire        core_local_data_to_local_datawrite;
    wire [15:0] core_local_data_to_local_datawrite_data;
    // wb_slave_spi_master_spi_master_to_spi_master wires:
    wire        wb_slave_spi_master_spi_master_to_spi_masterMISO;
    wire        wb_slave_spi_master_spi_master_to_spi_masterMOSI;
    wire        wb_slave_spi_master_spi_master_to_spi_masterSCLK;
    wire        wb_slave_spi_master_spi_master_to_spi_masterSS;

    // Ad-hoc wires:
    wire        core_clk_i_to_clk_i;
    wire        core_rst_i_to_rst_i;

    // core port wires:
    wire        core_clk_i;
    wire [7:0]  core_iaddr_o;
    wire [27:0] core_instruction_feed;
    wire [9:0]  core_local_address_o;
    wire [15:0] core_local_read_data;
    wire [15:0] core_local_write_data;
    wire        core_local_write_o;
    wire [9:0]  core_mem_address_o;
    wire [15:0] core_mem_data_i;
    wire [15:0] core_mem_data_o;
    wire        core_mem_master_rdy;
    wire        core_mem_slave_rdy;
    wire        core_mem_we_o;
    wire        core_rst_i;
    // external_mem_hash port wires:
    wire        external_mem_hash_ack_o;
    wire [9:0]  external_mem_hash_adr_i;
    wire        external_mem_hash_clk_i;
    wire        external_mem_hash_cyc_i;
    wire [15:0] external_mem_hash_dat_i;
    wire [15:0] external_mem_hash_dat_o;
    wire        external_mem_hash_err_o;
    wire        external_mem_hash_rst_i;
    wire        external_mem_hash_stb_i;
    wire        external_mem_hash_store_hash_i;
    wire        external_mem_hash_we_i;
    // external_mem_large port wires:
    wire        external_mem_large_ack_o;
    wire [9:0]  external_mem_large_adr_i;
    wire        external_mem_large_clk_i;
    wire        external_mem_large_cyc_i;
    wire [15:0] external_mem_large_dat_i;
    wire [15:0] external_mem_large_dat_o;
    wire        external_mem_large_err_o;
    wire        external_mem_large_rst_i;
    wire        external_mem_large_stb_i;
    wire        external_mem_large_store_hash_i;
    wire        external_mem_large_we_i;
    // sum_buffer port wires:
    wire        sum_buffer_ack_o;
    wire [9:0]  sum_buffer_adr_i;
    wire        sum_buffer_clk_i;
    wire        sum_buffer_cyc_i;
    wire [15:0] sum_buffer_dat_i;
    wire [15:0] sum_buffer_dat_o;
    wire        sum_buffer_err_o;
    wire        sum_buffer_rst_i;
    wire        sum_buffer_stb_i;
    wire        sum_buffer_we_i;
    // wb_slave_spi_master port wires:
    wire        wb_slave_spi_master_ack_o;
    wire [9:0]  wb_slave_spi_master_adr_i;
    wire        wb_slave_spi_master_clk_i;
    wire        wb_slave_spi_master_clk_out;
    wire        wb_slave_spi_master_cyc_i;
    wire [15:0] wb_slave_spi_master_dat_i;
    wire [15:0] wb_slave_spi_master_dat_o;
    wire        wb_slave_spi_master_data_in;
    wire        wb_slave_spi_master_data_out;
    wire        wb_slave_spi_master_err_o;
    wire        wb_slave_spi_master_rst_i;
    wire        wb_slave_spi_master_slave_select_out;
    wire        wb_slave_spi_master_stb_i;
    wire        wb_slave_spi_master_we_i;
    // wishbone_bridge port wires:
    wire        wishbone_bridge_clk_i;
    wire [9:0]  wishbone_bridge_mem_address_in;
    wire [15:0] wishbone_bridge_mem_data_in;
    wire [15:0] wishbone_bridge_mem_data_out;
    wire        wishbone_bridge_mem_master_rdy;
    wire        wishbone_bridge_mem_slave_rdy;
    wire        wishbone_bridge_mem_we_in;
    wire        wishbone_bridge_rst_i;
    wire        wishbone_bridge_wb_ack_i;
    wire [9:0]  wishbone_bridge_wb_adr_o;
    wire        wishbone_bridge_wb_cyc_o;
    wire [15:0] wishbone_bridge_wb_dat_i;
    wire [15:0] wishbone_bridge_wb_dat_o;
    wire        wishbone_bridge_wb_err_i;
    wire        wishbone_bridge_wb_stb_o;
    wire        wishbone_bridge_wb_we_o;
    // wishbone_bus port wires:
    wire        wishbone_bus_ack_master;
    wire        wishbone_bus_ack_slave_0;
    wire        wishbone_bus_ack_slave_1;
    wire        wishbone_bus_ack_slave_2;
    wire        wishbone_bus_ack_slave_3;
    wire [9:0]  wishbone_bus_adr_master;
    wire [9:0]  wishbone_bus_adr_slave_0;
    wire [9:0]  wishbone_bus_adr_slave_1;
    wire [9:0]  wishbone_bus_adr_slave_2;
    wire [9:0]  wishbone_bus_adr_slave_3;
    wire        wishbone_bus_cyc_master;
    wire        wishbone_bus_cyc_slave_0;
    wire        wishbone_bus_cyc_slave_1;
    wire        wishbone_bus_cyc_slave_2;
    wire        wishbone_bus_cyc_slave_3;
    wire [15:0] wishbone_bus_dat_ms_master;
    wire [15:0] wishbone_bus_dat_ms_slave_0;
    wire [15:0] wishbone_bus_dat_ms_slave_1;
    wire [15:0] wishbone_bus_dat_ms_slave_2;
    wire [15:0] wishbone_bus_dat_ms_slave_3;
    wire [15:0] wishbone_bus_dat_sm_master;
    wire [15:0] wishbone_bus_dat_sm_slave_0;
    wire [15:0] wishbone_bus_dat_sm_slave_1;
    wire [15:0] wishbone_bus_dat_sm_slave_2;
    wire [15:0] wishbone_bus_dat_sm_slave_3;
    wire        wishbone_bus_err_master;
    wire        wishbone_bus_err_slave_0;
    wire        wishbone_bus_err_slave_1;
    wire        wishbone_bus_err_slave_2;
    wire        wishbone_bus_err_slave_3;
    wire        wishbone_bus_stb_master;
    wire        wishbone_bus_stb_slave_0;
    wire        wishbone_bus_stb_slave_1;
    wire        wishbone_bus_stb_slave_2;
    wire        wishbone_bus_stb_slave_3;
    wire        wishbone_bus_we_master;
    wire        wishbone_bus_we_slave_0;
    wire        wishbone_bus_we_slave_1;
    wire        wishbone_bus_we_slave_2;
    wire        wishbone_bus_we_slave_3;

    // Assignments for the ports of the encompassing component:
    assign wishbone_bridge_wb_system_to_wb_systemclk = clk_i;
    assign core_clk_i_to_clk_i = clk_i;
    assign clk_out = wb_slave_spi_master_spi_master_to_spi_masterSCLK;
    assign wb_slave_spi_master_spi_master_to_spi_masterMISO = data_in;
    assign data_out = wb_slave_spi_master_spi_master_to_spi_masterMOSI;
    assign iaddr_o[7:0] = core_instructions_to_instructionsaddress[7:0];
    assign core_instructions_to_instructionsread_data[27:0] = instruction_feed[27:0];
    assign local_address_o[9:0] = core_local_data_to_local_dataaddress[9:0];
    assign core_local_data_to_local_dataread_data[15:0] = local_read_data[15:0];
    assign local_write_data[15:0] = core_local_data_to_local_datawrite_data[15:0];
    assign local_write_o = core_local_data_to_local_datawrite;
    assign core_rst_i_to_rst_i = rst_i;
    assign wishbone_bridge_wb_system_to_wb_systemrst = rst_i;
    assign slave_select_out = wb_slave_spi_master_spi_master_to_spi_masterSS;

    // core assignments:
    assign core_clk_i = core_clk_i_to_clk_i;
    assign core_instructions_to_instructionsaddress[7:0] = core_iaddr_o[7:0];
    assign core_instruction_feed[27:0] = core_instructions_to_instructionsread_data[27:0];
    assign core_local_data_to_local_dataaddress[9:0] = core_local_address_o[9:0];
    assign core_local_read_data[15:0] = core_local_data_to_local_dataread_data[15:0];
    assign core_local_data_to_local_datawrite_data[15:0] = core_local_write_data[15:0];
    assign core_local_data_to_local_datawrite = core_local_write_o;
    assign core_peripheral_access_to_wishbone_bridge_contolleraddress[9:0] = core_mem_address_o[9:0];
    assign core_mem_data_i[15:0] = core_peripheral_access_to_wishbone_bridge_contollerdata_sm[15:0];
    assign core_peripheral_access_to_wishbone_bridge_contollerdata_ms[15:0] = core_mem_data_o[15:0];
    assign core_peripheral_access_to_wishbone_bridge_contollermaster_rdy = core_mem_master_rdy;
    assign core_mem_slave_rdy = core_peripheral_access_to_wishbone_bridge_contollerslave_rdy;
    assign core_peripheral_access_to_wishbone_bridge_contollerwe = core_mem_we_o;
    assign core_rst_i = core_rst_i_to_rst_i;
    // external_mem_hash assignments:
    assign external_mem_hash_wb_slave_to_wishbone_bus_slave_1ack = external_mem_hash_ack_o;
    assign external_mem_hash_adr_i[9:0] = external_mem_hash_wb_slave_to_wishbone_bus_slave_1adr[9:0];
    assign external_mem_hash_clk_i = wishbone_bridge_wb_system_to_wb_systemclk;
    assign external_mem_hash_cyc_i = external_mem_hash_wb_slave_to_wishbone_bus_slave_1cyc;
    assign external_mem_hash_dat_i[15:0] = external_mem_hash_wb_slave_to_wishbone_bus_slave_1dat_ms[15:0];
    assign external_mem_hash_wb_slave_to_wishbone_bus_slave_1dat_sm[15:0] = external_mem_hash_dat_o[15:0];
    assign external_mem_hash_wb_slave_to_wishbone_bus_slave_1err = external_mem_hash_err_o;
    assign external_mem_hash_rst_i = wishbone_bridge_wb_system_to_wb_systemrst;
    assign external_mem_hash_stb_i = external_mem_hash_wb_slave_to_wishbone_bus_slave_1stb;
    assign external_mem_hash_store_hash_i = 1;
    assign external_mem_hash_we_i = external_mem_hash_wb_slave_to_wishbone_bus_slave_1we;
    // external_mem_large assignments:
    assign wishbone_bus_slave_0_to_external_mem_large_wb_slaveack = external_mem_large_ack_o;
    assign external_mem_large_adr_i[9:0] = wishbone_bus_slave_0_to_external_mem_large_wb_slaveadr[9:0];
    assign external_mem_large_clk_i = wishbone_bridge_wb_system_to_wb_systemclk;
    assign external_mem_large_cyc_i = wishbone_bus_slave_0_to_external_mem_large_wb_slavecyc;
    assign external_mem_large_dat_i[15:0] = wishbone_bus_slave_0_to_external_mem_large_wb_slavedat_ms[15:0];
    assign wishbone_bus_slave_0_to_external_mem_large_wb_slavedat_sm[15:0] = external_mem_large_dat_o[15:0];
    assign wishbone_bus_slave_0_to_external_mem_large_wb_slaveerr = external_mem_large_err_o;
    assign external_mem_large_rst_i = wishbone_bridge_wb_system_to_wb_systemrst;
    assign external_mem_large_stb_i = wishbone_bus_slave_0_to_external_mem_large_wb_slavestb;
    assign external_mem_large_store_hash_i = 0;
    assign external_mem_large_we_i = wishbone_bus_slave_0_to_external_mem_large_wb_slavewe;
    // sum_buffer assignments:
    assign sum_buffer_wb_slave_to_wishbone_bus_slave_2ack = sum_buffer_ack_o;
    assign sum_buffer_adr_i[9:0] = sum_buffer_wb_slave_to_wishbone_bus_slave_2adr[9:0];
    assign sum_buffer_clk_i = wishbone_bridge_wb_system_to_wb_systemclk;
    assign sum_buffer_cyc_i = sum_buffer_wb_slave_to_wishbone_bus_slave_2cyc;
    assign sum_buffer_dat_i[15:0] = sum_buffer_wb_slave_to_wishbone_bus_slave_2dat_ms[15:0];
    assign sum_buffer_wb_slave_to_wishbone_bus_slave_2dat_sm[15:0] = sum_buffer_dat_o[15:0];
    assign sum_buffer_wb_slave_to_wishbone_bus_slave_2err = sum_buffer_err_o;
    assign sum_buffer_rst_i = wishbone_bridge_wb_system_to_wb_systemrst;
    assign sum_buffer_stb_i = sum_buffer_wb_slave_to_wishbone_bus_slave_2stb;
    assign sum_buffer_we_i = sum_buffer_wb_slave_to_wishbone_bus_slave_2we;
    // wb_slave_spi_master assignments:
    assign wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slaveack = wb_slave_spi_master_ack_o;
    assign wb_slave_spi_master_adr_i[9:0] = wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slaveadr[9:0];
    assign wb_slave_spi_master_clk_i = wishbone_bridge_wb_system_to_wb_systemclk;
    assign wb_slave_spi_master_spi_master_to_spi_masterSCLK = wb_slave_spi_master_clk_out;
    assign wb_slave_spi_master_cyc_i = wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavecyc;
    assign wb_slave_spi_master_dat_i[15:0] = wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavedat_ms[15:0];
    assign wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavedat_sm[15:0] = wb_slave_spi_master_dat_o[15:0];
    assign wb_slave_spi_master_data_in = wb_slave_spi_master_spi_master_to_spi_masterMISO;
    assign wb_slave_spi_master_spi_master_to_spi_masterMOSI = wb_slave_spi_master_data_out;
    assign wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slaveerr = wb_slave_spi_master_err_o;
    assign wb_slave_spi_master_rst_i = wishbone_bridge_wb_system_to_wb_systemrst;
    assign wb_slave_spi_master_spi_master_to_spi_masterSS = wb_slave_spi_master_slave_select_out;
    assign wb_slave_spi_master_stb_i = wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavestb;
    assign wb_slave_spi_master_we_i = wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavewe;
    // wishbone_bridge assignments:
    assign wishbone_bridge_clk_i = wishbone_bridge_wb_system_to_wb_systemclk;
    assign wishbone_bridge_mem_address_in[9:0] = core_peripheral_access_to_wishbone_bridge_contolleraddress[9:0];
    assign wishbone_bridge_mem_data_in[15:0] = core_peripheral_access_to_wishbone_bridge_contollerdata_ms[15:0];
    assign core_peripheral_access_to_wishbone_bridge_contollerdata_sm[15:0] = wishbone_bridge_mem_data_out[15:0];
    assign wishbone_bridge_mem_master_rdy = core_peripheral_access_to_wishbone_bridge_contollermaster_rdy;
    assign core_peripheral_access_to_wishbone_bridge_contollerslave_rdy = wishbone_bridge_mem_slave_rdy;
    assign wishbone_bridge_mem_we_in = core_peripheral_access_to_wishbone_bridge_contollerwe;
    assign wishbone_bridge_rst_i = wishbone_bridge_wb_system_to_wb_systemrst;
    assign wishbone_bridge_wb_ack_i = wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterack;
    assign wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masteradr[9:0] = wishbone_bridge_wb_adr_o[9:0];
    assign wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_mastercyc = wishbone_bridge_wb_cyc_o;
    assign wishbone_bridge_wb_dat_i[15:0] = wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterdat_sm[15:0];
    assign wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterdat_ms[15:0] = wishbone_bridge_wb_dat_o[15:0];
    assign wishbone_bridge_wb_err_i = wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_mastererr;
    assign wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterstb = wishbone_bridge_wb_stb_o;
    assign wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterwe = wishbone_bridge_wb_we_o;
    // wishbone_bus assignments:
    assign wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterack = wishbone_bus_ack_master;
    assign wishbone_bus_ack_slave_0 = wishbone_bus_slave_0_to_external_mem_large_wb_slaveack;
    assign wishbone_bus_ack_slave_1 = external_mem_hash_wb_slave_to_wishbone_bus_slave_1ack;
    assign wishbone_bus_ack_slave_2 = sum_buffer_wb_slave_to_wishbone_bus_slave_2ack;
    assign wishbone_bus_ack_slave_3 = wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slaveack;
    assign wishbone_bus_adr_master[9:0] = wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masteradr[9:0];
    assign wishbone_bus_slave_0_to_external_mem_large_wb_slaveadr[9:0] = wishbone_bus_adr_slave_0[9:0];
    assign external_mem_hash_wb_slave_to_wishbone_bus_slave_1adr[9:0] = wishbone_bus_adr_slave_1[9:0];
    assign sum_buffer_wb_slave_to_wishbone_bus_slave_2adr[9:0] = wishbone_bus_adr_slave_2[9:0];
    assign wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slaveadr[9:0] = wishbone_bus_adr_slave_3[9:0];
    assign wishbone_bus_cyc_master = wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_mastercyc;
    assign wishbone_bus_slave_0_to_external_mem_large_wb_slavecyc = wishbone_bus_cyc_slave_0;
    assign external_mem_hash_wb_slave_to_wishbone_bus_slave_1cyc = wishbone_bus_cyc_slave_1;
    assign sum_buffer_wb_slave_to_wishbone_bus_slave_2cyc = wishbone_bus_cyc_slave_2;
    assign wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavecyc = wishbone_bus_cyc_slave_3;
    assign wishbone_bus_dat_ms_master[15:0] = wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterdat_ms[15:0];
    assign wishbone_bus_slave_0_to_external_mem_large_wb_slavedat_ms[15:0] = wishbone_bus_dat_ms_slave_0[15:0];
    assign external_mem_hash_wb_slave_to_wishbone_bus_slave_1dat_ms[15:0] = wishbone_bus_dat_ms_slave_1[15:0];
    assign sum_buffer_wb_slave_to_wishbone_bus_slave_2dat_ms[15:0] = wishbone_bus_dat_ms_slave_2[15:0];
    assign wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavedat_ms[15:0] = wishbone_bus_dat_ms_slave_3[15:0];
    assign wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterdat_sm[15:0] = wishbone_bus_dat_sm_master[15:0];
    assign wishbone_bus_dat_sm_slave_0[15:0] = wishbone_bus_slave_0_to_external_mem_large_wb_slavedat_sm[15:0];
    assign wishbone_bus_dat_sm_slave_1[15:0] = external_mem_hash_wb_slave_to_wishbone_bus_slave_1dat_sm[15:0];
    assign wishbone_bus_dat_sm_slave_2[15:0] = sum_buffer_wb_slave_to_wishbone_bus_slave_2dat_sm[15:0];
    assign wishbone_bus_dat_sm_slave_3[15:0] = wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavedat_sm[15:0];
    assign wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_mastererr = wishbone_bus_err_master;
    assign wishbone_bus_err_slave_0 = wishbone_bus_slave_0_to_external_mem_large_wb_slaveerr;
    assign wishbone_bus_err_slave_1 = external_mem_hash_wb_slave_to_wishbone_bus_slave_1err;
    assign wishbone_bus_err_slave_2 = sum_buffer_wb_slave_to_wishbone_bus_slave_2err;
    assign wishbone_bus_err_slave_3 = wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slaveerr;
    assign wishbone_bus_stb_master = wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterstb;
    assign wishbone_bus_slave_0_to_external_mem_large_wb_slavestb = wishbone_bus_stb_slave_0;
    assign external_mem_hash_wb_slave_to_wishbone_bus_slave_1stb = wishbone_bus_stb_slave_1;
    assign sum_buffer_wb_slave_to_wishbone_bus_slave_2stb = wishbone_bus_stb_slave_2;
    assign wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavestb = wishbone_bus_stb_slave_3;
    assign wishbone_bus_we_master = wishbone_bridge_wb_master_to_wishbone_bus_one_to_many_masterwe;
    assign wishbone_bus_slave_0_to_external_mem_large_wb_slavewe = wishbone_bus_we_slave_0;
    assign external_mem_hash_wb_slave_to_wishbone_bus_slave_1we = wishbone_bus_we_slave_1;
    assign sum_buffer_wb_slave_to_wishbone_bus_slave_2we = wishbone_bus_we_slave_2;
    assign wishbone_bus_slave_3_to_wb_slave_spi_master_wb_slavewe = wishbone_bus_we_slave_3;

    // IP-XACT VLNV: tut.fi:cpu.subsystem:core_example:1.0
    core_example_0 #(
        .DATA_WIDTH          (16),
        .ADDR_WIDTH          (10),
        .SUPPORTED_MEMORY    (1024),
        .PERIPHERAL_BASE     (256),
        .INSTRUCTION_WIDTH   (28),
        .INSTRUCTION_ADDRESS_WIDTH(8))
    core(
        // Interface: instructions
        .instruction_feed    (core_instruction_feed),
        .iaddr_o             (core_iaddr_o),
        // Interface: local_data
        .local_read_data     (core_local_read_data),
        .local_address_o     (core_local_address_o),
        .local_write_data    (core_local_write_data),
        .local_write_o       (core_local_write_o),
        // Interface: peripheral_access
        .mem_data_i          (core_mem_data_i),
        .mem_slave_rdy       (core_mem_slave_rdy),
        .mem_address_o       (core_mem_address_o),
        .mem_data_o          (core_mem_data_o),
        .mem_master_rdy      (core_mem_master_rdy),
        .mem_we_o            (core_mem_we_o),
        // These ports are not in any interface
        .clk_i               (core_clk_i),
        .rst_i               (core_rst_i));

    // IP-XACT VLNV: tut.fi:peripheral.logic:wb_external_mem:1.0
    wb_memory #(
        .ADDR_WIDTH          (10),
        .DATA_WIDTH          (16),
        .MEMORY_SIZE         (128),
        .BASE_ADDRESS        (160))
    external_mem_hash(
        // Interface: wb_slave
        .adr_i               (external_mem_hash_adr_i),
        .cyc_i               (external_mem_hash_cyc_i),
        .dat_i               (external_mem_hash_dat_i),
        .stb_i               (external_mem_hash_stb_i),
        .we_i                (external_mem_hash_we_i),
        .ack_o               (external_mem_hash_ack_o),
        .dat_o               (external_mem_hash_dat_o),
        .err_o               (external_mem_hash_err_o),
        // Interface: wb_system
        .clk_i               (external_mem_hash_clk_i),
        .rst_i               (external_mem_hash_rst_i),
        // These ports are not in any interface
        .store_hash_i        (external_mem_hash_store_hash_i));

    // IP-XACT VLNV: tut.fi:peripheral.logic:wb_external_mem:1.0
    wb_memory #(
        .ADDR_WIDTH          (10),
        .DATA_WIDTH          (16),
        .MEMORY_SIZE         (128),
        .BASE_ADDRESS        (32))
    external_mem_large(
        // Interface: wb_slave
        .adr_i               (external_mem_large_adr_i),
        .cyc_i               (external_mem_large_cyc_i),
        .dat_i               (external_mem_large_dat_i),
        .stb_i               (external_mem_large_stb_i),
        .we_i                (external_mem_large_we_i),
        .ack_o               (external_mem_large_ack_o),
        .dat_o               (external_mem_large_dat_o),
        .err_o               (external_mem_large_err_o),
        // Interface: wb_system
        .clk_i               (external_mem_large_clk_i),
        .rst_i               (external_mem_large_rst_i),
        // These ports are not in any interface
        .store_hash_i        (external_mem_large_store_hash_i));

    // IP-XACT VLNV: tut.fi:peripheral.logic:sum_buffer:1.0
    wb_sum_buffer #(
        .ADDR_WIDTH          (10),
        .DATA_WIDTH          (16),
        .BASE_ADDRESS        (288))
    sum_buffer(
        // Interface: wb_slave
        .adr_i               (sum_buffer_adr_i),
        .cyc_i               (sum_buffer_cyc_i),
        .dat_i               (sum_buffer_dat_i),
        .stb_i               (sum_buffer_stb_i),
        .we_i                (sum_buffer_we_i),
        .ack_o               (sum_buffer_ack_o),
        .dat_o               (sum_buffer_dat_o),
        .err_o               (sum_buffer_err_o),
        // Interface: wb_system
        .clk_i               (sum_buffer_clk_i),
        .rst_i               (sum_buffer_rst_i));

    // IP-XACT VLNV: tut.fi:communication.bridge:wb_slave_spi_master:1.0
    wb_slave_spi_master #(
        .ADDR_WIDTH          (10),
        .DATA_WIDTH          (16),
        .BASE_ADDRESS        (416),
        .BUFFER_INDEX_WIDTH  (4))
    wb_slave_spi_master(
        // Interface: spi_master
        .data_in             (wb_slave_spi_master_data_in),
        .clk_out             (wb_slave_spi_master_clk_out),
        .data_out            (wb_slave_spi_master_data_out),
        .slave_select_out    (wb_slave_spi_master_slave_select_out),
        // Interface: wb_slave
        .adr_i               (wb_slave_spi_master_adr_i),
        .cyc_i               (wb_slave_spi_master_cyc_i),
        .dat_i               (wb_slave_spi_master_dat_i),
        .stb_i               (wb_slave_spi_master_stb_i),
        .we_i                (wb_slave_spi_master_we_i),
        .ack_o               (wb_slave_spi_master_ack_o),
        .dat_o               (wb_slave_spi_master_dat_o),
        .err_o               (wb_slave_spi_master_err_o),
        // Interface: wb_system
        .clk_i               (wb_slave_spi_master_clk_i),
        .rst_i               (wb_slave_spi_master_rst_i));

    // IP-XACT VLNV: tut.fi:communication.bridge:wb_master_cpu_slave:1.0
    wb_master #(
        .ADDR_WIDTH          (10),
        .DATA_WIDTH          (16),
        .BASE_ADDRESS        (256),
        .RANGE               (768))
    wishbone_bridge(
        // Interface: contoller
        .mem_address_in      (wishbone_bridge_mem_address_in),
        .mem_data_in         (wishbone_bridge_mem_data_in),
        .mem_master_rdy      (wishbone_bridge_mem_master_rdy),
        .mem_we_in           (wishbone_bridge_mem_we_in),
        .mem_data_out        (wishbone_bridge_mem_data_out),
        .mem_slave_rdy       (wishbone_bridge_mem_slave_rdy),
        // Interface: wb_master
        .wb_ack_i            (wishbone_bridge_wb_ack_i),
        .wb_dat_i            (wishbone_bridge_wb_dat_i),
        .wb_err_i            (wishbone_bridge_wb_err_i),
        .wb_adr_o            (wishbone_bridge_wb_adr_o),
        .wb_cyc_o            (wishbone_bridge_wb_cyc_o),
        .wb_dat_o            (wishbone_bridge_wb_dat_o),
        .wb_stb_o            (wishbone_bridge_wb_stb_o),
        .wb_we_o             (wishbone_bridge_wb_we_o),
        // Interface: wb_system
        .clk_i               (wishbone_bridge_clk_i),
        .rst_i               (wishbone_bridge_rst_i));

    // IP-XACT VLNV: tut.fi:communication.bus:wishbone:1.0
    wishbone_bus #(
        .ADDR_WIDTH          (10),
        .DATA_WIDTH          (16),
        .SLAVE_0_BASE        (32),
        .SLAVE_1_BASE        (160),
        .SLAVE_2_BASE        (288),
        .SLAVE_3_BASE        (416),
        .SLAVE_RANGE         (128))
    wishbone_bus(
        // Interface: one_to_many_master
        .adr_master          (wishbone_bus_adr_master),
        .cyc_master          (wishbone_bus_cyc_master),
        .dat_ms_master       (wishbone_bus_dat_ms_master),
        .stb_master          (wishbone_bus_stb_master),
        .we_master           (wishbone_bus_we_master),
        .ack_master          (wishbone_bus_ack_master),
        .dat_sm_master       (wishbone_bus_dat_sm_master),
        .err_master          (wishbone_bus_err_master),
        // Interface: slave_0
        .ack_slave_0         (wishbone_bus_ack_slave_0),
        .dat_sm_slave_0      (wishbone_bus_dat_sm_slave_0),
        .err_slave_0         (wishbone_bus_err_slave_0),
        .adr_slave_0         (wishbone_bus_adr_slave_0),
        .cyc_slave_0         (wishbone_bus_cyc_slave_0),
        .dat_ms_slave_0      (wishbone_bus_dat_ms_slave_0),
        .stb_slave_0         (wishbone_bus_stb_slave_0),
        .we_slave_0          (wishbone_bus_we_slave_0),
        // Interface: slave_1
        .ack_slave_1         (wishbone_bus_ack_slave_1),
        .dat_sm_slave_1      (wishbone_bus_dat_sm_slave_1),
        .err_slave_1         (wishbone_bus_err_slave_1),
        .adr_slave_1         (wishbone_bus_adr_slave_1),
        .cyc_slave_1         (wishbone_bus_cyc_slave_1),
        .dat_ms_slave_1      (wishbone_bus_dat_ms_slave_1),
        .stb_slave_1         (wishbone_bus_stb_slave_1),
        .we_slave_1          (wishbone_bus_we_slave_1),
        // Interface: slave_2
        .ack_slave_2         (wishbone_bus_ack_slave_2),
        .dat_sm_slave_2      (wishbone_bus_dat_sm_slave_2),
        .err_slave_2         (wishbone_bus_err_slave_2),
        .adr_slave_2         (wishbone_bus_adr_slave_2),
        .cyc_slave_2         (wishbone_bus_cyc_slave_2),
        .dat_ms_slave_2      (wishbone_bus_dat_ms_slave_2),
        .stb_slave_2         (wishbone_bus_stb_slave_2),
        .we_slave_2          (wishbone_bus_we_slave_2),
        // Interface: slave_3
        .ack_slave_3         (wishbone_bus_ack_slave_3),
        .dat_sm_slave_3      (wishbone_bus_dat_sm_slave_3),
        .err_slave_3         (wishbone_bus_err_slave_3),
        .adr_slave_3         (wishbone_bus_adr_slave_3),
        .cyc_slave_3         (wishbone_bus_cyc_slave_3),
        .dat_ms_slave_3      (wishbone_bus_dat_ms_slave_3),
        .stb_slave_3         (wishbone_bus_stb_slave_3),
        .we_slave_3          (wishbone_bus_we_slave_3));


endmodule
