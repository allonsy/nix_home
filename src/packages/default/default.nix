{
  home,
  nyx,
  vars,
  ...
}:
if vars.hostname == "nyx" then nyx else home
