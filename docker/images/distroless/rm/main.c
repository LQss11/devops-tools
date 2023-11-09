#include <stdio.h>
 
int main(int argc, char* argv[]) {
  char* path = argv[1];
    if (remove(path) == 0) {
        printf("File deleted.");
    } else {
        printf("File doesn't exist");
    }
    return 0;
}