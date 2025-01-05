# { username, ... }:
# {
#   home-manager.users.${username} = {
#     home.file = {
#       # Configuration for 1password SSH Agent.
#       ".ssh/config".text = ''
#        Host *
#          IdentityAgent ~/.1password/agent.sock

#       #	Host git.swaphb.dev
#       #	  HostName swaphb.dev
#       #	  Port 23231
#       #     '';

#       # Configure 1password to handle SSH commit signing
#       ".gitconfig".text = ''
#         [user]
#           name = "Stephen Bryant"
#           email = s@swaphb.com	
#           signingkey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJx0WMlfx+AwcROXFO+/all/WkLvBKpEkjwRY15tjSiB

#         [gpg]
#           format = ssh

#         [gpg "ssh"]
#           program = "/run/current-system/sw/bin/op-ssh-sign"

#         [commit]
#           gpgsign = true
#       '';
#     };
#   };

#   # Enable 1password plugins on interactive shell init
#   programs.bash.interactiveShellInit = ''
#     source /home/${username}/.config/op/plugins.sh
#   '';

#   # Enable 1password and the CLI
#   programs = {
#     _1password.enable = true;
#     _1password-gui = {
#       enable = true;
#       polkitPolicyOwners = [ "${username}" ];
#     };
#   };

#   # Enable 1password to open with gnomekeyring
#   security.pam.services."1password".enableGnomeKeyring = true;
# }