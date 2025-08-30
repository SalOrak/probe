
# Into an executable

First we create an object file, let's say using x86\_64:

```bash
nasm -f elf64 -o test.o test.S
```

Then we link it to create an executable:
```bash
ld -m elf_x86_64 -o test test.o
```

Finally, we can execute it like a normal executable:

```bash
./test
```


