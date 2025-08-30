expected_args=2

usage() {
    echo "Usage: $0 <path/to/asm_file> <arch>"
    echo "\tExample: $0 test.S 64 which outputs test executable file in ELF x86_64"
    echo "\tExample: $0 test.S 32 which outputs test executable file in ELF x86"
    echo "\tarch: Supported values are 64 and 32."
}

if [[ $expected_args != $# ]]; then
    echo "Expected $expected_args arguments but found $#."
    usage
    exit 1
fi


build_obj() {
    # $1 source_file 
    # $2 architecture
    # $3 output
    
    src=$1
    arch=$2
    output=$3

    echo "[INFO]: Buliding object file..."
    case $arch in
        "64")
            nasm -f elf64 -o $output $src
            ;;
        "32")
            nasm -f elf32 -o $output $src
            ;;
        *)
            echo "[ERROR]: Building object file. Expected architecture 64 or 32. Received $arch"
            usage
            exit 1
    esac
}


build_ld () {
    # $1 object_file 
    # $2 architecture
    # $3 output
    
    obj=$1
    arch=$2
    output=$3

    echo "[INFO]: Linking to executable..."
    case $arch in
        "64")
            ld -m elf_x86_64 -o $output $obj
            ;;
        "32")
            ld -m elf_i386 -o $output $obj
            ;;
        *)
            echo "[ERROR]: Building object file. Expected architecture 64 or 32. Received $arch"
            usage
            exit 1
    esac
}

main() {
    # $1 source file
    # $2 architecture

    src=$1
    arch=$2

    base="${src##*/}"
    file="${base%.*}"

    obj="$file.o"
    exe="${file}_${arch}"

    if [[ -e "$pwd/$src" ]]; then
        echo "[ERROR] File $src not found."
        usage
        exit 1
    fi
    
    if [[ $arch != "64" && $arch != "32" ]]; then
        echo "[ERROR] Expected architecture 64 or 32. Received $arch"
        usage
        exit 1
    fi

    build_obj $src $arch $obj
    build_ld $obj $arch $exe

    rm $obj
}

main $1 $2

exit 0
