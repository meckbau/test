.. _ad9265_fmc:

AD9265-FMC HDL project
================================================================================

Overview
-------------------------------------------------------------------------------

The :adi:`AD9265` is a 16-bit, 125 MSPS analog-to-digital converter (ADC). The 
:adi:`AD9265` is designed to support communications applications where high 
performance combined with low cost, small size, and versatility is desired. The 
ADC core features a multistage, differential pipelined architecture with 
integrated output error correction logic to provide 16-bit accuracy at 125 MSPS 
data rates and guarantees no missing codes over the full operating temperature 
range. The ADC output data format is either parallel 1.8 V CMOS or LVDS (DDR). 
A data output clock is provided to ensure proper latch timing with receiving 
logic. The board also provides other options to drive the clock and analog 
inputs of the ADC.

Supported boards
-------------------------------------------------------------------------------

-  :adi:`EVAL-AD9265 <EVAL-AD9265>`

Supported devices
-------------------------------------------------------------------------------

-  :adi:`AD9265`

Supported carriers
-------------------------------------------------------------------------------

.. list-table::
   :widths: 35 35 30
   :header-rows: 1

   * - Evaluation board
     - Carrier
     - FMC slot
   * - :adi:`EVAL-AD9434-FMC-500EBZ <EVAL-AD9434>`
     - :xilinx:`ZC706`
     - FMC LPC
   * -
     - :xilinx:`ZedBoard <products/boards-and-kits/1-8dyf-11.html>`
     - FMC LPC

Block design
-------------------------------------------------------------------------------

Block diagram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. image:: ad9265_fmc_block_diagram.svg
   :width: 800
   :align: center
   :alt: AD9265/ZedBoard block diagram

Clock scheme
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are 3 ways to configure the clock source for :adi:`AD9265` (some 
modification maybe necessary).

- External passive clock (default)
- Optional active clock path using the :adi:`AD9517`
- Optional oscillator

For more details, check :adi:`AD9265` schematic.


CPU/Memory interconnects addresses
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The addresses are dependent on the architecture of the FPGA, having an offset
added to the base address from HDL (see more at :ref:`architecture`).

Depending on the values of parameters $INTF_CFG, $ADI_PHY_SEL and $TDD_SUPPORT,
some IPs are instatiated and some are not.

Check-out the table below to find out the conditions.

==================== =============== 
Instance             Zynq/Microblaze
==================== =============== 
axi_ad9265           0x44A00000         
axi_ad9265_dma       0x44A30000     
==================== =============== 

SPI connections
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

THESE ARE JUST EXAMPLES!!!
USE WHICHEVER FITS BEST YOUR CASE

.. list-table::
   :widths: 25 25 25 25
   :header-rows: 1

   * - SPI type
     - SPI manager instance
     - SPI subordinate
     - CS
   * - PS
     - SPI 0
     - AD9517
     - 1
   * - PS
     - SPI 1
     - AD0000
     - 0

Interrupts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Below are the Programmable Logic interrupts used in this project.

You have many ways of writing this table: as a list-table or really to draw
it. Take a look in the .rst of this page to see how they're written and
which suits best your case.

.. list-table::
   :widths: 30 10 15 15
   :header-rows: 1

   * - Instance name
     - HDL
     - Linux Zynq
     - Actual Zynq
   * - axi_ad9265_dma
     - 13
     - 57
     - 89

Building the HDL project
-------------------------------------------------------------------------------

The design is built upon ADI's generic HDL reference design framework.
ADI does not distribute the bit/elf files of these projects so they
must be built from the sources available :git-hdl:`here <>`. To get
the source you must
`clone <https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository>`__
the HDL repository.

Then go to the project location(**projects/ad9265_fmc/carrier**) and run the make command by
typing in your command prompt(this example :adi:`ZC706``):

**Linux/Cygwin/WSL**

.. code-block::

   user@analog:~$ cd hdl/projects/ad9265_fmc/zc706
   user@analog:~/hdl/projects/ad9265_fmc/zc706$ make

A more comprehensive build guide can be found in the :ref:`build_hdl` user guide.

Software considerations
-------------------------------------------------------------------------------

\**\* MENTION THESE \**\*

ADC - crossbar config \**\* THIS IS JUST AN EXAMPLE \**\*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Due to physical constraints, Rx lanes are reordered as described in the
following table.

e.g physical lane 2 from ADC connects to logical lane 7
from the FPGA. Therefore the crossbar from the device must be set
accordingly.

============ ===========================
ADC phy Lane FPGA Rx lane / Logical Lane
============ ===========================
0            2
1            0
2            7
3            6
4            5
5            4
6            3
7            1
============ ===========================

DAC - crossbar config \**\* THIS IS JUST AN EXAMPLE \**\*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Due to physical constraints, Tx lanes are reordered as described in the
following table:

e.g physical lane 2 from DAC connects to logical lane 7
from the FPGA. Therefore the crossbar from the device must be set
accordingly.

============ ===========================
DAC phy Lane FPGA Tx lane / Logical Lane
============ ===========================
0            0
1            2
2            7
3            6
4            1
5            5
6            4
7            3
============ ===========================

Resources
-------------------------------------------------------------------------------

Systems related
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Links to the Quick start guides, to the pages where the hardware changes are
   specified in detail, etc. in the form of a table as the one below

**THIS IS JUST AN EXAMPLE**

-  :dokuwiki:`[Wiki] AD9081 & AD9082 & AD9988 & AD9986 Prototyping Platform User Guide <resources/eval/user-guides/ad9081_fmca_ebz>`
-  Here you can find all the quick start guides on wiki documentation:dokuwiki:`[Wiki] AD9081 Quick Start Guides <resources/eval/user-guides/ad9081_fmca_ebz/quickstart>`

Here you can find the quick start guides available for these evaluation boards:

.. list-table::
   :widths: 20 10 20 20 20 10
   :header-rows: 1

   * - Evaluation board
     - Zynq-7000
     - Zynq UltraScale+ MP
     - Microblaze
     - Versal
     - Arria 10
   * - AD9081/AD9082-FMCA-EBZ
     - :dokuwiki:`ZC706 <resources/eval/user-guides/ad9081_fmca_ebz/quickstart/zynq>`
     - :dokuwiki:`ZCU102 <resources/eval/user-guides/ad9081_fmca_ebz/quickstart/zynqmp>`
     - :dokuwiki:`VCU118 <resources/eval/user-guides/ad9081_fmca_ebz/quickstart/microblaze>`
     - :dokuwiki:`VCK190/VMK180 <resources/eval/user-guides/ad9081_fmca_ebz/quickstart/versal>`
     - :dokuwiki:`A10SoC <resources/eval/user-guides/ad9081/quickstart/a10soc>`

-  Other relevant information

Hardware related
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Product datasheets:

   -  :adi:`AD9081`
   -  :adi:`AD9082`
   -  :adi:`AD9988`
   -  :adi:`AD9986`
-  `UG-1578, Device User Guide <https://www.analog.com/media/en/technical-documentation/user-guides/ad9081-ad9082-ug-1578.pdf>`__
-  `UG-1829, Evaluation Board User Guide <https://www.analog.com/media/en/technical-documentation/user-guides/ad9081-fmca-ebz-9082-fmca-ebz-ug-1829.pdf>`__

HDL related
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Link to the project source code
-  Table like the one below. Must have as first IP (if it exists) the IP that
   was created with this project (i.e., axi_ad9783). If there isn't, then to
   be taken in the order they are written in the Makefile of the project,
   stating the source code link in a column and the documentation link in
   another column
-  Other relevant information

**THIS IS JUST AN EXAMPLE**

-  :git-hdl:`AD9081_FMCA_EBZ HDL project source code <projects/ad9081_fmca_ebz>`
-  :git-hdl:`AD9082_FMCA_EBZ HDL project source code <projects/ad9082_fmca_ebz>`

.. list-table::
   :widths: 30 35 35
   :header-rows: 1

   * - IP name
     - Source code link
     - Documentation link
   * - AXI_DMAC
     - :git-hdl:`library/axi_dmac`
     - :ref:`here <axi_dmac>`
   * - AXI_SYSID
     - :git-hdl:`library/axi_sysid`
     - :dokuwiki:`[Wiki] <resources/fpga/docs/axi_sysid>`
   * - SYSID_ROM
     - :git-hdl:`library/sysid_rom`
     - :dokuwiki:`[Wiki] <resources/fpga/docs/axi_sysid>`
   * - UTIL_CPACK2
     - :git-hdl:`library/util_pack/util_cpack2`
     - :dokuwiki:`[Wiki] <resources/fpga/docs/util_cpack>`
   * - UTIL_UPACK2
     - :git-hdl:`library/util_pack/util_upack2`
     - :dokuwiki:`[Wiki] <resources/fpga/docs/util_upack>`
   * - UTIL_ADXCVR for AMD
     - :git-hdl:`library/xilinx/util_adxcvr`
     - :dokuwiki:`[Wiki] <resources/fpga/docs/util_xcvr>`
   * - AXI_ADXCVR for Intel
     - :git-hdl:`library/intel/axi_adxcvr`
     - :dokuwiki:`[Wiki] <resources/fpga/docs/axi_adxcvr>`
   * - AXI_ADXCVR for AMD
     - :git-hdl:`library/xilinx/axi_adxcvr`
     - :dokuwiki:`[Wiki] <resources/fpga/docs/axi_adxcvr>`
   * - AXI_JESD204_RX
     - :git-hdl:`library/jesd204/axi_jesd204_rx`
     - :dokuwiki:`[Wiki] <resources/fpga/peripherals/jesd204/axi_jesd204_rx>`
   * - AXI_JESD204_TX
     - :git-hdl:`library/jesd204/axi_jesd204_tx`
     - :dokuwiki:`[Wiki] <resources/fpga/peripherals/jesd204/axi_jesd204_tx>`
   * - JESD204_TPL_ADC
     - :git-hdl:`library/jesd204/ad_ip_jesd204_tpl_adc`
     - :dokuwiki:`[Wiki] <resources/fpga/peripherals/jesd204/jesd204_tpl_adc>`
   * - JESD204_TPL_DAC
     - :git-hdl:`library/jesd204/ad_ip_jesd204_tpl_dac`
     - :dokuwiki:`[Wiki] <resources/fpga/peripherals/jesd204/jesd204_tpl_dac>`

\**\* MENTION THESE for JESD reference designs \**\*

-  :dokuwiki:`[Wiki] Generic JESD204B block designs <resources/fpga/docs/hdl/generic_jesd_bds>`
-  :dokuwiki:`[Wiki] JESD204B High-Speed Serial Interface Support <resources/fpga/peripherals/jesd204>`

\**\* MENTION THIS for SPI Engine reference designs \**\*

-  :ref:`SPI Engine Framework documentation <spi_engine>`

Software related
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**THIS IS JUST AN EXAMPLE**

-  :dokuwiki:`[Wiki] AD9081-FMCA-EBZ Linux driver wiki page <resources/tools-software/linux-drivers/iio-mxfe/ad9081>`

If there is no Linux driver page, then insert a link to the code of the driver
and of the device tree.

-  Python support (THIS IS JUST AN EXAMPLE):

   -  `AD9081 class documentation <https://analogdevicesinc.github.io/pyadi-iio/devices/adi.ad9081.html>`__
   -  `PyADI-IIO documentation <https://analogdevicesinc.github.io/pyadi-iio/>`__

.. include:: ../common/more_information.rst

.. include:: ../common/support.rst

.. _A10SoC: https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/arria/10-sx.html
