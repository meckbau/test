.. _ad7616_sdz:

AD7616-SDZ HDL project
===============================================================================

Overview
-------------------------------------------------------------------------------

The :part:`AD7616 <AD7616>` is a 16-bit, data acquisition system (DAS)
that supports dual simultaneous sampling of 16 channels. The 
:part:`AD7616 <AD7616>` operates from a single 5 V supply and can
accommodate ±10 V, ±5 V, and ±2.5 V true bipolar input signals while
sampling at throughput rates up to 1 MSPS per channel pair with 90 dB
SNR. Higher SNR performance can be achieved with the on-chip
oversampling mode; 92 dB for an oversampling ratio of 2.

The input clamp protection circuitry can tolerate voltages up to ±20 V.
The :part:`AD7616 <AD7616>` has 1 MΩ analog input impedance regardless
of sampling frequency. The single supply operation, on-chip filtering,
and high input impedance eliminate the need for driver op-amps and
external bipolar supplies.

Each device contains analog input clamp protection, a dual, 16-bit
charge redistribution successive approximation analog-to-digital
converter (ADC), a flexible digital filter, a 2.5 V reference and
reference buffer, and high-speed serial and parallel interfaces.


Supported devices
-------------------------------------------------------------------------------

-  :part:`AD7616 <AD7616>`

Evaluation boards
-------------------------------------------------------------------------------

-  :part:`EVAL-AD7616 <EVAL-AD7616>`

Supported carriers
-------------------------------------------------------------------------------

-  :xilinx:`ZedBoard` on FMC slot
-  :xilinx:`ZC706` on FMC LPC slot
   
Other required hardware
-------------------------------------------------------------------------------

-   :part:`SDP-I-FMC <EVAL-SDP-I-FMC>`

Block design
-------------------------------------------------------------------------------

The data path of the HDL design is simple as follows:

-  the parallel interface is controlled by the axi_ad7616 IP core
-  the serial interface is controlled by the SPI Engine Framework
-  data is written into memory by a DMA (axi_dmac core)
-  all the control pins of the device are driven by GPIOs

Configuration modes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The SER_PAR_N configuration parameter defines the interface type (Serial or 
Parallel). By default it is set to 1. Depending on the required interface mode, 
some hardware modifications need to be done on the board and/or make command:

In case of the **PARALLEL** interface:

.. code-block::

   make SER_PAR_N=0

In case of the **SERIAL** interface:

.. code-block::

   make SER_PAR_N=1
   
.. note::

   This switch is a 'hardware' switch. Please rebuild the  design if the 
   variable has been changed.
   
   -   SL5 - unmounted - Parallel interface
   -   SL5 - mounted - Serial interface

Jumper setup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

================== ========= ====================================
Jumper/Solder link Position  Description
================== ========= ====================================
SL1                Unmounted Channel Sequencer Enable
SL2                Unmounted RC Enable Input
SL3                Mounted   Selects 2 MISO mode
SL4                Unmounted Oversampling Ratio Selection OS2
SL5                Mounted   If mounted, selects serial interface
SL6                Unmounted Oversampling Ratio Selection OS1
SL7                Unmounted Oversampling Ratio Selection OS0
LK40               A         Onboard 5v0 power supply selected
LK41               A         Onboard 3v3 power supply selected
================== ========= ====================================   

Block diagram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

AD7616_SDZ serial interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. image:: ../images/ad7616_serial_hdl.svg
   :width: 800
   :align: center
   :alt: AD7616_SDZ using the serial interface block diagram
   
AD7616_SDZ parallell interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. image:: ../images/ad7616_parallel_hdl.svg
   :width: 800
   :align: center
   :alt: AD7616_SDZ using the parallel interface block diagram   

IP list
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  :git-hdl:`AD_EDGE_DETECT <master:library/common/ad_edge_detect.v>`
-  :git-hdl:`AXI_AD7616 <master:library/axi_ad7616>` *
-  :git-hdl:`AXI_CLKGEN <master:library/axi_clkgen>`
-  :git-hdl:`AXI_DMAC <master:library/axi_dmac>`
-  :git-hdl:`AXI_HDMI_TX <master:library/axi_hdmi_tx>`
-  :git-hdl:`AXI_I2S_ADI <master:library/axi_i2s_adi>`
-  :git-hdl:`AXI_PWM_GEN <master:library/axi_pwm_gen>`
-  :git-hdl:`AXI_SPDIF_TX <master:library/axi_spdif_tx>`
-  :git-hdl:`AXI_SPI_ENGINE <master:library/spi_engine/axi_spi_engine>` **
-  :git-hdl:`AXI_SYSID <master:library/axi_sysid>`
-  :git-hdl:`SPI_ENGINE_EXECUTION <master:library/spi_engine/spi_engine_execution>` **
-  :git-hdl:`SPI_ENGINE_INTERCONNECT <master:library/spi_engine/spi_engine_interconnect>` **
-  :git-hdl:`SPI_ENGINE_OFFLOAD <master:library/spi_engine/spi_engine_offload>` **
-  :git-hdl:`SYNC_BITS <master:library/util_cdc/sync_bits.v>`
-  :git-hdl:`SYSID_ROM <master:library/sysid_rom>`

.. note::

   Legend
     
   -   ``*`` instantiated only for SER_PAR_N=0 (parallel interface)
   -   ``**`` instantiated only for SER_PAR_N=1 (serial interface)

I2C connections
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. list-table::
   :widths: 20 20 20 20 20
   :header-rows: 1

   * - I2C type
     - I2C manager instance
     - Alias
     - Address
     - I2C subordinate
   * - PL
     - iic_fmc
     - axi_iic_fmc
     - 0x4162_0000
     - \-
   * - PL
     - iic_main
     - axi_iic_main
     - 0x4160_0000
     - \-

SPI connections
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. list-table::
   :widths: 10 20 20 20 20 10
   :header-rows: 1

   * - SPI type
     - SPI manager instance
     - Alias
     - Address
     - SPI subordinate
     - CS bit
   * - PL
     - axi_spi_engine
     - spi_ad7616_axi_regmap
     - 0x44A0_0000
     - AXI_AD7616
     - 0

GPIOs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Software GPIO number is calculated as follows:

-  Zynq-7000: if PS7 is used, then offset is 54

============= ============= ================
GPIO signal   HDL GPIO EMIO Software GPIO nb
============= ============= ================
adc_reset_n   43            97
adc_hw_rngsel 42:41         96:95
adc_os **     40:38         94:92
adc_seq_en    37            91
adc_burst **  36            90
adc_chsel     35:33         89:87
adc_crcen **  32            86
============= ============= ================

.. note::

   Legend
     
   -   ``**`` - only for SER_PAR_N=1 (serial interface)
            
CPU/Memory interconnects addresses
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

========================  ==========
Instance                  Address
========================  ==========
axi_ad7616_dma            0x44a30000
ad7616_pwm_gen            0x44b00000
spi_ad7616_axi_regmap **  0x44a00000
axi_ad7616 *              0x44a80000
========================  ==========

.. note::

   Legend
     
   -   ``*`` - instantiated only for SER_PAR_N=0 (parallel interface)
   -   ``**`` - instantiated only for SER_PAR_N=1 (serial interface)

Interrupts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Below are the Programmable Logic interrupts used in this project.

=============== === ========== ===========
Instance name   HDL Linux Zynq Actual Zynq
=============== === ========== ===========
axi_ad7616_dma  13  57         89
spi_ad7616 **   12  56         88
axi_ad7616 *    10  54         87
=============== === ========== ===========

.. note::

   Legend
     
   -   ``*`` - instantiated only for SER_PAR_N=0 (parallel interface)
   -   ``**`` - instantiated only for SER_PAR_N=1 (serial interface)


Building the HDL project
-------------------------------------------------------------------------------

Setup guide
-------------------------------------------------------------------------------

Below is a user guide which help you start with your setup.

-  :dokuwiki:`AD7616_SDZ (AD7616_SDZ) <resources/eval/user-guides/ad7616-sdz>`

Connections and hardware changes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. warning::

   **The following hardware changes are required:**
 
   (**Please note:** Because of the **SDP-I-FMC** the level of the **VADJ** in 
   the carrier board needs to be set to **3.3V**.
     
   Depending on the required interface mode, some hardware modifications need to 
   be done.
   
   -   **SL5** - unmounted - Parallel interface
   -   **SL5** - mounted - Serial interface

Resources
-------------------------------------------------------------------------------

-  :git-hdl:`ad7616_sdz HDL project <master:projects/ad7616_sdz>`
-  :dokuwiki:`AXI_AD7616 (AXI_AD7616) <resources/fpga/docs/axi_ad7616>`
-  :dokuwiki:`AXI_CLKGEN (AXI CLKGEN IP core) <resources/fpga/docs/axi_clkgen>`
-  :ref:`AXI_DMAC <axi_dmac>`
-  :dokuwiki:`AXI_HDMI_TX (AXI_HDMI_TX IP core) <resources/fpga/docs/axi_hdmi_tx>`
-  :dokuwiki:`AXI_PWM_GEN (AXI_PWM_GEN) <resources/fpga/docs/axi_pwm_gen>`
-  :ref:`AXI_SPI_ENGINE <spi_engine axi>`
-  :dokuwiki:`AXI_SYSID (System ID) <resources/fpga/docs/axi_sysid>`
-  :ref:`SPI_ENGINE_EXECUTION <spi_engine execution>`
-  :ref:`SPI_ENGINE_INTERCONNECT <spi_engine interconnect>`
-  :ref:`SPI_ENGINE_OFFLOAD <spi_engine offload>`

More information
-------------------------------------------------------------------------------

Hardware related
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Product datasheets: :part:`AD7616`

-  `UG-1012, Evaluation Board User Guide <https://www.analog.com/media/en/technical-documentation/user-guides/EVAL-AD7616SDZ-7616-PSDZ-UG-1012.pdf>`__

HDL related
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  :ref:`ADI HDL User guide <user_guide>`
-  :ref:`ADI HDL project architecture <architecture>`
-  :ref:`ADI HDL project build guide <build_hdl>`
-  :ref:`SPI_ENGINE <spi_engine>`

Software related
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  :dokuwiki:`No-OS project <https://github.com/analogdevicesinc/no-OS/tree/master/projects/ad7616-sdz>`

Systems related
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  :dokuwiki:`How to build No-OS <resources/no-os/build>` 

Support
-------------------------------------------------------------------------------

Analog Devices will provide **limited** online support for anyone using
the reference design with Analog Devices components via the
:ez:`fpga` FPGA reference designs forum.

It should be noted, that the older the tools' versions and release
branches are, the lower the chances to receive support from ADI
engineers.

