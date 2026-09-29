{ pkgs, lib, ... }:

let
  rawLoaderSrc = pkgs.writeText "runraw.c" ''
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

  rawLoader = pkgs.runCommand "runraw" { } ''
    mkdir -p $out/bin
    ${pkgs.stdenv.cc}/bin/cc -O2 -o $out/bin/runraw ${rawLoaderSrc}
  '';
in
{
  boot.binfmt.registrations."raw-shellcode" = {
    recognitionType = "extension";
    magicOrExtension = "raw";
    interpreter = "${rawLoader}/bin/runraw";
    wrapInterpreterInShell = false;
  };
}
