#!/bin/bash

# Colors for better visibility
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print the menu
echo -e "${BLUE}Nix Darwin Configuration Management${NC}"
echo "1) Rebuild configuration"
echo "2) Update flakes and rebuild"
echo "3) Clean nix store"
echo "4) Exit"
echo ""

# Get user choice
read -p "Please select an option (1-4): " choice

case $choice in
    1)
        echo -e "${GREEN}Rebuilding configuration...${NC}"
        read -p "Enter hostname (default: swaphb-mba): " hostname
        hostname=${hostname:-swaphb-mba}
        darwin-rebuild switch --flake .#$hostname
        ;;
    2)
        echo -e "${GREEN}Updating flakes and rebuilding...${NC}"
        read -p "Enter hostname (default: swaphb-mba): " hostname
        hostname=${hostname:-swaphb-mba}
        nix flake update && darwin-rebuild switch --flake .#$hostname
        ;;
    3)
        echo -e "${GREEN}Cleaning nix store...${NC}"
        nix-store --gc
        ;;
    4)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option. Please select 1-4."
        exit 1
        ;;
esac 