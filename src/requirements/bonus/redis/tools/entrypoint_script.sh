#!/bin/sh

BLUE='\033[94m'
RESET='\033[0m'

echo "${BLUE}Change protected-mode to no ... ${RESET}"
redis-server --protected-mode no

exec "$@"