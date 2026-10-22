{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          leftalt = "overloadt2(alt, muhenkan, 1000)";
          rightalt = "overloadt2(alt, henkan, 1000)";
          capslock = "noop";
        };
        shift.capslock = "capslock";
      };
    };
  };
}
