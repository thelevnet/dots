{ ... }:

{
  modules.rnet = {
    enable = true;

    records = {
      "levnet.git" = "100.127.101.226:9418";
      "levnet.mc" = "100.127.101.226:25565";
      "levnet.ssh" = "100.127.101.226:22";
    };
  };
}
