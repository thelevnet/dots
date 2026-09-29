{ pkgs, lib, ... }:

let
  rawLoaderSrc = pkgs.writeText "raw-loader.c" ''
    #include <stdio.h>
    #include <stdlib.h>
    #include <sys/mman.h>
    #include <sys/stat.h>
    #include <fcntl.h>
    #include <unistd.h>

    int main(int argc, char *argv[]) {
      if (argc < 2) {
        fprintf(stderr, "raw-loader: no file given\n");
        return 1;
      }

      int fd = open(argv[1], O_RDONLY);
      if (fd < 0) { perror("raw-loader: open"); return 1; }

      struct stat st;
      if (fstat(fd, &st) < 0) { perror("raw-loader: fstat"); return 1; }

      size_t len = (size_t)st.st_size;
      if (len == 0) {
        fprintf(stderr, "raw-loader: empty file\n");
        return 1;
      }

      void *mem = mmap(NULL, len,
                       PROT_READ | PROT_WRITE | PROT_EXEC,
                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
      if (mem == MAP_FAILED) { perror("raw-loader: mmap"); return 1; }

      ssize_t n = read(fd, mem, len);
      close(fd);
      if (n != (ssize_t)len) {
        fprintf(stderr, "raw-loader: short read\n");
        return 1;
      }

      mprotect(mem, len, PROT_READ | PROT_EXEC);

      ((void (*)(void))mem)();

      return 0;
    }
  '';

  rawLoader = pkgs.runCommand "raw-loader" { } ''
    mkdir -p $out/bin
    ${pkgs.stdenv.cc}/bin/cc -O2 -o $out/bin/raw-loader ${rawLoaderSrc}
  '';
in
{
  boot.binfmt.registrations."raw-shellcode" = {
    recognitionType = "extension";
    magicOrExtension = "raw";
    interpreter = "${rawLoader}/bin/raw-loader";
    wrapInterpreterInShell = false;
  };
}
