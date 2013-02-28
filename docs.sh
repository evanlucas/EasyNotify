#!/bin/bash

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
GRAY=$(tput setaf 8)
BOLD=$(tput bold)
RESET=$(tput sgr0)

printError() {
	echo -e "${RED}[ERROR] - $1"
	echo -ne "${RESET}"
}

printInfo() {
	echo -e "${MAGENTA}[INFO] - $1"
	echo -ne "${RESET}"
}

printInfo "Checking for appledoc"
doccer=$(which appledoc)

if [[ $? == 1 ]]; then
	printError "Unable to find appledoc...is it installed?"
	printError "Make sure it is installed and in your path and then try again."
	exit 1
fi

printInfo "appledoc found"

printInfo "Generating documentation"

appledoc --project-name EasyNotifier --project-company "curapps" --company-id com.curapps --output ./docs --no-install-docset .

printInfo "Done generating documentation"

open docs/docset/Contents/Resources/Documents/index.html
