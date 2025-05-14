#!/bin/bash

# Colors for styling
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ASCII Art Title
clear
echo -e "${CYAN}"
cat << "EOF"
   ____                      ____                      _             
  / ___| __ _ _ __ ___   ___| __ )  ___  ___ ___ _ __ | |_ ___  _ __ 
 | |  _ / _` | '_ ` _ \ / _ \  _ \ / _ \/ __/ _ \ '_ \| __/ _ \| '__|
 | |_| | (_| | | | | | |  __/ |_) |  __/ (_|  __/ |_) | || (_) | |   
  \____|\__,_|_| |_| |_|\___|____/ \___|\___\___| .__/ \__\___/|_|   
                                               |_|                  
         === Game Mode Booster by Lucid Jester ===
EOF
echo -e "${NC}"

# Menu
while true; do
    echo -e "\n${GREEN}Choose an option:${NC}"
    echo "1. Clean APT Cache (sudo apt clean)"
    echo "2. Free RAM (drop_caches)"
    echo "3. Kill background bloat (Discord, Steam, etc.)"
    echo "4. Set CPU Governor to Performance"
    echo "5. Run ALL optimizations"
    echo "6. Exit"

    read -rp ">> " choice

    case $choice in
        1)
            echo -e "${CYAN}Running: sudo apt clean...${NC}"
            sudo apt clean
            ;;
        2)
            echo -e "${YELLOW}WARNING: This clears your memory cache. Continue? (y/n)${NC}"
            read -rp ">> " confirm
            if [[ "$confirm" == "y" ]]; then
                echo -e "${CYAN}Flushing cache and freeing memory...${NC}"
                sync; echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
                echo -e "${GREEN}Cache dropped!${NC}"
            else
                echo -e "${RED}Cancelled.${NC}"
            fi
            ;;
        3)
            echo -e "${YELLOW}Kill background apps? (Discord, Steam, etc) (y/n)${NC}"
            read -rp ">> " confirm
            if [[ "$confirm" == "y" ]]; then
                echo -e "${CYAN}Killing background bloatware...${NC}"
                pkill -f discord
                pkill -f steam
                pkill -f lutris
                pkill -f brave
                echo -e "${GREEN}Processes terminated.${NC}"
            else
                echo -e "${RED}Cancelled.${NC}"
            fi
            ;;
        4)
            echo -e "${CYAN}Setting CPU governor to performance...${NC}"
            sudo cpupower frequency-set -g performance
            echo -e "${GREEN}CPU governor set!${NC}"
            ;;
        5)
            echo -e "${YELLOW}Run full optimization suite? (y/n)${NC}"
            read -rp ">> " confirm
            if [[ "$confirm" == "y" ]]; then
                echo -e "${CYAN}Cleaning APT cache...${NC}"
                sudo apt clean

                echo -e "${CYAN}Dropping caches...${NC}"
                sync; echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null

                echo -e "${CYAN}Killing background processes...${NC}"
                pkill -f discord
                pkill -f steam
                pkill -f lutris
                pkill -f brave

                echo -e "${CYAN}Setting CPU governor to performance...${NC}"
                sudo cpupower frequency-set -g performance

                echo -e "${GREEN}All optimizations done. You’re ready to frag souls.${NC}"
            else
                echo -e "${RED}Cancelled.${NC}"
            fi
            ;;
        6)
            echo -e "${RED}Exiting... See you in the grid, Operator.${NC}"
            break
            ;;
        *)
            echo -e "${RED}Invalid option. Try again.${NC}"
            ;;
    esac
done
