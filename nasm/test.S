section .data
    msg db 'Hello world!', 0xA
    len equ $ - msg
section .bss
    bytes_written resd 1

section .text

global _start

_start: 
    mov ecx, msg
    mov edx, len
    call print
    mov eax, 1
    mov ebx, 0
    int 80h

print:
    mov eax, 4
    mov ebx, 1
    int 80h
    ret

