inline short pixel(char letter,char color,char background){
    short code;
    code = background << 4;
    code |= color;
    code = code << 8;
    code |= letter; 

    return code;
}


extern "C" void _start() {
    short *video_memory = (short*)0xb8006;
    *video_memory = pixel('X',0xe,0x9);    
}

