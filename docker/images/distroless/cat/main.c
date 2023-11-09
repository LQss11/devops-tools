#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {

    FILE *f;
    char c;
    char* path = argv[1];
    f=fopen(path,"rt");

    while((c=fgetc(f))!=EOF){
        printf("%c",c);
    }

    fclose(f);
    return 0;
}