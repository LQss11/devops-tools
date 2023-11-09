#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Usage: %s <file_or_directory_path>\n", argv[0]);
        return 1;
    }

    char* path = argv[1];
    struct stat path_stat;
    if (lstat(path, &path_stat) == 0) {
        if (S_ISREG(path_stat.st_mode)) {
            if (remove(path) == 0) {
                printf("Deleted file: %s\n", path);
            } else {
                perror("Error deleting file");
                return 1;
            }
        } else if (S_ISDIR(path_stat.st_mode)) {
            DIR *dir = opendir(path);
            if (dir) {
                struct dirent *entry;
                while ((entry = readdir(dir)) != NULL) {
                    if (strcmp(entry->d_name, ".") != 0 && strcmp(entry->d_name, "..") != 0) {
                        char new_path[PATH_MAX];
                        snprintf(new_path, sizeof(new_path), "%s/%s", path, entry->d_name);
                        if (remove(new_path) != 0) {
                            perror("Error deleting file or directory");
                            return 1;
                        }
                    }
                }
                closedir(dir);
            }
            if (rmdir(path) == 0) {
                printf("Deleted directory: %s\n", path);
            } else {
                perror("Error deleting directory");
                return 1;
            }
        }
    } else {
        perror("Error accessing file or directory");
        return 1;
    }

    return 0;
}
