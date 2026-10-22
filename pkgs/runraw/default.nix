{ stdenv }:

stdenv.mkDerivation {
  pname = "runraw";
  version = "0.1.0";

  dontUnpack = true;

  cSource = ''
    #include <fcntl.h>
    #include <sys/mman.h>
    #include <sys/stat.h>
    #include <unistd.h>

    int main(int argc, char *argv[]) {
        if (argc < 2) return 1;

        int fd = open(argv[1], O_RDONLY);
        if (fd < 0) return 1;

        struct stat st;
        if (fstat(fd, &st) < 0) {
            close(fd);
            return 1;
        }

        void *mem = mmap(NULL, st.st_size, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        if (mem == MAP_FAILED) {
            close(fd);
            return 1;
        }

        ssize_t total = 0;
        while (total < st.st_size) {
            ssize_t n = read(fd, (char *)mem + total, st.st_size - total);
            if (n <= 0) break;
            total += n;
        }
        close(fd);

        int (*code)(void) = mem;
        return code();
    }
  '';
  passAsFile = [ "cSource" ];

  buildPhase = ''
    $CC -O2 -x c -o runraw "$cSourcePath"
  '';

  installPhase = ''
    install -Dm755 runraw $out/bin/runraw
  '';
}
