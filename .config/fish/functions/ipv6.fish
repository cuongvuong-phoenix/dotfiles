function ipv6 --description="Quickly turn on/off IPv6 (temporarily until reboot)"
  switch $argv[1]
    case check
      sudo sysctl -a | grep -ie "disable_ipv6"
    case on enable
      sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
      sudo sysctl -w net.ipv6.conf.default.disable_ipv6=0
    case off disable
      sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
      sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
  end
end