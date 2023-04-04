function space_greeting {
  print -r "                                         "
  print -r "        |         $(welcome_message)     "
  print -r "       / \                               "
  print -r "      / _ \       $(show_date_info)      "
  print -r "     |.o '.|                             "
  print -r "     |'._.'|      Space vessel computer: "
  print -r "     |     |      $(show_os_info)        "
  print -r "   .'|  |  |'.    $(show_cpu_info)       "
  print -r "  /  |  |  |  \   $(show_mem_info)       "
  print -r "  |.-'--|--'-.|   $(show_net_info)       "
  print -r "                                         "
  print -P "%F{#acacac}Have a nice trip%f            "
  print -r "                                         "
}

function welcome_message {
  print -n "Welcome aboard captain "
  print -P "%F{yellow}$(whoami)!%f"
}

function show_date_info {
  local up_time=$(uptime | cut -d "," -f1 | cut -d "p" -f2 | sed 's/^ *//g')
  local time=$(echo $up_time | cut -d " " -f2)
  local formatted_uptime=$time
  
  case $time in
    days|day)
      formatted_uptime=$up_time
      ;;
    min)
      formatted_uptime=$up_time"utes"
      ;;
    *)
      formatted_uptime="$formatted_uptime hours"
      ;;
  esac

  print -n "Today is "
  print -Pn "%F{cyan}$(date +%Y.%m.%d)%F{reset}"
  print -n ", we are up and running for "
  print -Pn "%F{cyan}$formatted_uptime%F{reset}"
  print -n "."
}

function show_os_info {
  print -Pn "%F{yellow}    OS: "
  print -Pn "%F{cyan}$(uname -sm)%F{reset}"
}

function show_cpu_info {
  local os_type=$(uname -s)
  local cpu_info=""

  if [[ "$os_type" == "Linux" ]]; then
    local procs_n=$(grep -c "^processor" /proc/cpuinfo)
    local cores_n=$(grep "cpu cores" /proc/cpuinfo | head -1 | cut -d ":"  -f2 | tr -d " ")
    local cpu_type=$(grep "model name" /proc/cpuinfo | head -1 | cut -d ":" -f2)
    cpu_info="$procs_n processors, $cores_n cores, $cpu_type"
  elif [[ "$os_type" == "Darwin" ]]; then
    local procs_n=$(system_profiler SPHardwareDataType | grep "Number of Processors" | cut -d ":" -f2 | tr -d " ")
    local cores_n=$(system_profiler SPHardwareDataType | grep "Cores" | cut -d ":" -f2 | tr -d " ")
    local cpu_type=$(system_profiler SPHardwareDataType | grep "Processor Name" | cut -d ":" -f2 | tr -d " ")
    cpu_info="$procs_n processors, $cores_n cores, $cpu_type"
  fi

  print -Pn "%F{yellow}    CPU: "
  print -Pn "%F{cyan}$cpu_info%F{reset}"
}

function show_mem_info () {
  local os_type=$(uname -s)
  local total_memory=""

  if [[ "$os_type" == "Linux" ]]; then
    total_memory=$(free -h | grep "Mem" | awk '{print $2}')

  elif [[ "$os_type" == "Darwin" ]]; then
    total_memory=$(system_profiler SPHardwareDataType | awk '/Memory:/ {print $2}')

  fi
  
  print -Pn "%F{yellow}    Memory: "
  print -Pn "%F{cyan}$total_memory%F{reset}"
}

function show_net_info {
  local os_type="$(uname -s)"
  local ip=""
  local gw=""

  if [[ "$os_type" == "Linux" ]]; then
      ip="$(ip address show | grep "inet .* brd .*" | cut -d " " -f6)"
      gw="$(ip route | grep default | awk '{print $3}')"

  elif [[ "$os_type" == "Darwin" ]]; then
      ip="$(ifconfig | grep -v "127.0.0.1" | grep "inet " | head -1 | awk '{print $2}')"
      gw="$(netstat -nr | grep -E "default.*UGSc" | awk '{print $2}')"
  fi
    
  print -Pn "%F{yellow}    Net: "
  print -Pn "%F{cyan}Ip address $ip, default gateway $gw%f"
}

space_greeting
