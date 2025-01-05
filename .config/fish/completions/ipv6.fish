complete -c ipv6 -f
complete -c ipv6 -n "not __fish_seen_subcommand_from $commands" -a "check" -d "Check whether IPv6 is turned on" 
complete -c ipv6 -n "not __fish_seen_subcommand_from $commands" -a "on enable" -d "Turn on IPv6"
complete -c ipv6 -n "not __fish_seen_subcommand_from $commands" -a "off disable" -d "Turn off IPv6"