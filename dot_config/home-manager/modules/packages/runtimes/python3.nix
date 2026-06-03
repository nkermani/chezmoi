{ pkgs, ... }: {
  home.packages = [
    (pkgs.python3.withPackages (ps: [ ps.tkinter ]))
  ];
}
