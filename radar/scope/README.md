# Oscilloscope Phase Experiment Documentation
## SeASAR Project (_Arba Shkreli_)
Objective: To detect motion of an interface via signal phase shift encountered by transmitted 
RF signals via one transmitter antenna and subsequently whose reflections are picked up by 
one receiver antenna.
The experiment utilizes benchtop equipment to transmit and capture single-tone signals (or 
at least primarily single tone signals, as there could be additional harmonics in the transmitted 
signal and noise in the received signal).

Our project necessitates picking up data collected over 30 seconds from which the signal processing
software will make a determination that an interface within the purview of the sensor has changed
position over time. The indication of relative motion is given by a change in phase between the
transmitted and received signals. 

Equipment: 
- 1 Tektronix MSO 3014 Oscilloscope
- 2 BNC to SMA adapters
- 2 SMA cables
- 1 EVAL-ADF4351 Frequency Synthesizer Board (for Analog Devices)
- 2 UWB antennas

Software Prerequisites:
- Windows 10/11
- NI VISA 18.5
- MATLAB R2023b (with Instrument Control Toolbox)

Using the button interface to the scope, the following setup was determined:
- 50 Ohm impedance at channels 1 and 2
- Autoset (gives reliable tracking)
- Attenuation factor (?)
- Set phase measurement between waveforms 1 and 2

These will be translated into SCPI commands to be sent to the scope via PC.

## Oscilloscope Data Streaming Setup
To capture the necessary data, there needs to be continuous streaming of data
from the scope to a PC to visualize, store, and post-process it for testing and 
extracting statistical results.

To facilitate such a connection, Tektronix scopes utilize VISA (Virtual Instrument
Software Architecture), an API for communication which includes specifications for
communication over I/O interfaces such as GPIB, LAN, USB, VXI, PXI, and others.
MATLAB, through its Instrument Control Toolbox, implements VISA over most of these
interfaces utilizing VISA driver versions such as NI-VISA, TekVISA, and Rohde & Schwarz VISA.

For this setup, NI-VISA Version 18.5 over USB with MATLAB was used to perform
connection, control, and data reception of the scope from a Windows 11 PC.

## Notes

Setting up the data streaming was not easy. Even for experienced professionals
who deal with data acquisition systems, there are a host of problems that one
can come across.

Here are some things that we learned and we hope that will be a good reference
for those starting out:

1. _Have only one implementation of `VISA` installed on your machine._
It may be the case that software for controlling other instruments
such as Keysight/Agilent may have resulted in a `VISA` installation
already present in the system. Multiple `VISA` implementations can
conflict and cause problems. Therefore, either use an existing one or
ensure that only one is present. There is an option typically in
software that comes with a particular `VISA` flavor such as `NI_VISA`'s 
`NI_MAX` (Conflict Manager option) which allows the user to enable only 
one `VISA` implementation to be enabled at a time. It is recommended to
only have one `VISA` installed, but if multiple must remain on the machine,
be sure to utilize this option.

2. `PyVISA`, the open source Python version, is best used with newer devices
that explicitly support this functionality.

3. _`NI_VISA` over `TekVISA`_
For MATLAB use in particular, even if our device was Tektronix, we found it 
best to use NI's implementation as that has more support, especially for
the newer `VISA` MATLAB functions known as `visadev`, which is preferred over
`visa` as that will be deprecated.
