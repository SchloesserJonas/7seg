# 7seg

Implementation of a binary to decimal input converter with 7seg display for the 8051 microcontroller. 

I used the [MCU8015 IDE](https://sourceforge.net/projects/mcu8051ide/files/mcu8051ide/1.4.9/) for this project and the virtual hardware feature. 

Used virtual Hardware:
- Multiplexed 7seg display
- Simple keypad

You can find the configuration files for the virtual hardware in the repo (`7seg.vhc` for 7seg display, `input.vhc` for keypad) 

> Note: Because I was a bit lost I implemented the modulo myself instead of using the already existing instruction (it's a feature not a bug 😉) -> see [here](https://developer.arm.com/documentation/101655/0961/Ax51-User-s-Guide/Writing-Assembly-Programs/Expressions-and-Operators/Operators/MOD-Assembler-Operator)