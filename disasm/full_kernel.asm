00000000  E803000000        call 0x8
00000005  EBFE              jmp short 0x5
00000007  90                nop
00000008  55                push ebp
00000009  89E5              mov ebp,esp
0000000B  83EC28            sub esp,byte +0x28
0000000E  C745F406800B00    mov dword [ebp-0xc],0xb8006
00000015  C744240809000000  mov dword [esp+0x8],0x9
0000001D  C74424040E000000  mov dword [esp+0x4],0xe
00000025  C7042458000000    mov dword [esp],0x58
0000002C  E80B000000        call 0x3c
00000031  8B55F4            mov edx,[ebp-0xc]
00000034  668902            mov [edx],ax
00000037  90                nop
00000038  C9                leave
00000039  C3                ret
0000003A  90                nop
0000003B  90                nop
0000003C  55                push ebp
0000003D  89E5              mov ebp,esp
0000003F  83EC1C            sub esp,byte +0x1c
00000042  8B4D08            mov ecx,[ebp+0x8]
00000045  8B550C            mov edx,[ebp+0xc]
00000048  8B4510            mov eax,[ebp+0x10]
0000004B  884DEC            mov [ebp-0x14],cl
0000004E  8855E8            mov [ebp-0x18],dl
00000051  8845E4            mov [ebp-0x1c],al
00000054  0FBE45E4          movsx eax,byte [ebp-0x1c]
00000058  C1E004            shl eax,byte 0x4
0000005B  668945FE          mov [ebp-0x2],ax
0000005F  660FBE45E8        movsx ax,[ebp-0x18]
00000064  660945FE          or [ebp-0x2],ax
00000068  0FBF45FE          movsx eax,word [ebp-0x2]
0000006C  C1E008            shl eax,byte 0x8
0000006F  668945FE          mov [ebp-0x2],ax
00000073  660FBE45EC        movsx ax,[ebp-0x14]
00000078  660945FE          or [ebp-0x2],ax
0000007C  0FB745FE          movzx eax,word [ebp-0x2]
00000080  C9                leave
00000081  C3                ret
00000082  90                nop
00000083  90                nop
