# PIN Validator in NASM Assembly

A secure 4-digit PIN validator demonstrating:
- System calls for I/O
- Register-based attempt counting
- Conditional branching

## How to Run
'''bash
nasm -f elf64 pin_validator.asm -o pin_validator.o
ld pin_validator.o -o pin_validator
./pin_validator

Features:
- 3-attempt limit
- Immediate access on correct PIN
- System lockdown after failures
