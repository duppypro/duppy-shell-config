awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s s s s s s s s s;
    for (colnum = 0; colnum<128; colnum++) {
        r = 255-(colnum*255/127);
        g = (colnum*510/127);
        b = (colnum*255/127);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
    for (colnum = 0; colnum<128; colnum++) {
        r = 255-(colnum*255/127);
        g = (colnum*510/127);
        b = (colnum*255/127);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", 0,0,0;
        printf "\033[38;2;%d;%d;%dm", r,g,b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
    for (colnum = 0; colnum<128; colnum++) {
        r = 255-(colnum*255/127);
        g = (colnum*510/127);
        b = (colnum*255/127);
        if (g>255) g = 510-g;
        r = r/2;
        g = g/2;
        b = b/2;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 127-r,127-g,127-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
    for (colnum = 0; colnum<128; colnum++) {
        r = 255-(colnum*255/127);
        g = (colnum*510/127);
        b = (colnum*255/127);
        if (g>255) g = 510-g;
        r = r/2;
        g = g/2;
        b = b/2;
        printf "\033[48;2;%d;%d;%dm", 0,0,0;
        printf "\033[38;2;%d;%d;%dm", r,g,b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
    for (colnum = 0; colnum<128; colnum++) {
        r = 255-(colnum*255/127);
        g = (colnum*510/127);
        b = (colnum*255/127);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,r,r;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-r,255-r;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
    for (colnum = 0; colnum<128; colnum++) {
        r = 255-(colnum*255/127);
        g = (colnum*510/127);
        b = (colnum*255/127);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", 0,0,0;
        printf "\033[38;2;%d;%d;%dm", r,r,r;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
    printf "\033[48;2;51;51;51mno-esc-code is normal text. \033[0m This is normal text.\033[0m";
    printf "\n";
    printf "\033[48;2;51;51;51m\033[5m[5m is also normal? text \033[0m \033[5mThis is 5 text.\033[0m";
    printf "\n";
    printf "\033[48;2;51;51;51m\033[1m[1m is bold text \033[0m \033[1mThis is bold text.\033[0m";
    printf "\n";
    printf "\033[48;2;51;51;51m\033[2m[2m is dim text \033[0m \033[2mThis is dim text.\033[0m";
    printf "\n";
    printf "\033[48;2;51;51;51m\033[3m[3m is italic text \033[0m \033[3mThis is italic text.\033[0m";
    printf "\n";
    printf "\033[48;2;51;51;51m\033[4m[4m is underlined text \033[0m \033[4mThis is underlined text.\033[0m";
    printf "\n";
    printf "\033[48;2;51;51;51m\033[6m[6m is 6 text \033[0m \033[6mThis is 6 text.\033[0m";
    printf "\n";
    printf "\033[48;2;51;51;51m\033[7m[7m is HIGHLITED text \033[0m \033[7mThis is 7 text.\033[0m";
    printf "\n";
    printf "\033[48;2;51;51;51m\033[8m[8m is INVISIBLE text \033[0m \033[8mThis is 8 text.\033[0m";
    printf "\n";
    printf "\033[48;2;51;51;51m\033[9m[9m is 9 text \033[0m \033[9mThis is 9 text.\033[0m";
    printf "\n";
    printf "\033[48;2;51;51;51m\033[0m[0m is 0 text \033[0m \033[0mThis is 0 text.\033[0m";
    printf "\n";
    printf "\033[48;2;0;0;0m";
    printf "\n";
}'
