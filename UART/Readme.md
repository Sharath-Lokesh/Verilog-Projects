### UART
- UART (Universal Asynchronous Receiver/Transmitter) is a serial communication protocol widely used for exchanging data between devices.
- **Asynchronous**: Unlike synchronous protocols that rely on a shared clock signal, UART communication operates asynchronously, meaning both the transmitter and receiver use independent clocks.   
- **Serial Transmission**: Data is transmitted bit-by-bit over a single wire (TX) and received on another wire (RX).   
- **Data Forma**t: UART data is transmitted in a specific format:
  1. ***Start Bit***: Always a logic '0', indicating the beginning of a data frame.
  2. ***Data Bits***: 5 to 8 bits of data, typically 8 bits.
  3. ***Parity Bit (Optional)***: An extra bit used for error checking (even parity or odd parity).
  4. ***Stop Bit***: One or more logic '1' bits to mark the end of the data frame.   

#### UART Communication Process
- Transmission:
  1. The transmitter converts parallel data (e.g., a byte) into a serial stream of bits.
  2. It starts by sending a start bit (logic '0').
  3. Then, it transmits the data bits, least significant bit first.
  4. If a parity bit is used, it's transmitted next.
  5. Finally, one or more stop bits (logic '1') are transmitted.   

- Reception:
  1. The receiver monitors the receive line (RX).
  2. It detects the falling edge of the start bit to synchronize with the incoming data.
  3. It samples the data line at the middle of each bit time to read the data bits.
  4. If a parity bit is used, it checks the parity.
  5. It detects the rising edge of the stop bit to mark the end of the data frame.

#### Simulation waveform

![sim](https://github.com/user-attachments/assets/e2077452-3eea-4bc8-984c-08474afaa501)

