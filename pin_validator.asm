section .data
    correct_pin     db '1234', 0
    msg_prompt      db 'Enter 4-digit PIN: ', 0
    msg_success     db 'Access Granted!', 10, 0
    msg_fail        db 'Incorrect PIN. Try again.', 10, 0
    msg_lock        db 'Access Denied. System Locked.', 10, 0
    max_attempts    equ 3

section .bss
    user_input      resb 5

section .text
    global _start

_start:
    mov r15, max_attempts   ; Using R15 (preserved across syscalls)

main_loop:
    ; Check attempts remaining
    cmp r15, 0
    jle pin_locked

    ; Prompt message
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_prompt
    mov rdx, 19
    syscall

    ; Read input
    mov rax, 0
    mov rdi, 0
    mov rsi, user_input
    mov rdx, 5
    syscall

    ; Compare PIN
    mov rsi, user_input
    mov rdi, correct_pin
    mov rcx, 4
compare_loop:
    mov al, [rsi]
    cmp al, [rdi]
    jne handle_wrong
    inc rsi
    inc rdi
    loop compare_loop

    ; Correct PIN
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_success
    mov rdx, 16
    syscall
    jmp exit

handle_wrong:
    ; Decrement attempt counter
    dec r15
    
    ; Print fail message
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_fail
    mov rdx, 26
    syscall
    
    jmp main_loop

pin_locked:
    ; Print locked message
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_lock
    mov rdx, 31
    syscall

exit:
    mov rax, 60
    xor rdi, rdi
    syscall