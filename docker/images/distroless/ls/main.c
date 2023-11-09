#include <dirent.h> 
#include <stdio.h> 

int main(int argc, char* argv[]) {
  DIR *d;
  struct dirent *dir;
  if(argc==2){
    char* path = argv[1];
    d = opendir(path);
    if (d) {
      while ((dir = readdir(d)) != NULL) {
        printf("%s\n", dir->d_name);
      }
      closedir(d);
    }
    return(0);
  }else{
      printf("Wrong number of arguments");
      return 1;
  }
  
}