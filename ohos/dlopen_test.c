#include <stdio.h>
#include <dlfcn.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <path-to-shared-object>\n", argv[0]);
        return 1;
    }

    printf("Attempting to dlopen: %s\n", argv[1]);

    void *handle = dlopen(argv[1], RTLD_NOW | RTLD_GLOBAL);
    if (!handle) {
        fprintf(stderr, "dlopen failed: %s\n", dlerror());
        return 1;
    }

    printf("dlopen succeeded!\n");

    /* Try to find Py_Version as a simple test */
    int *py_version = (int *)dlsym(handle, "Py_Version");
    if (py_version) {
        printf("Py_Version = %d\n", *py_version);
    } else {
        printf("Py_Version not found (expected for non-Python libs)\n");
    }

    dlclose(handle);
    printf("Test passed!\n");
    return 0;
}
