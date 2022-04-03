#!/bin/bash
RETURN_VALUE=0
PROGRAM_COMMAND=sorter


# Only for formatting purpose
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

for f in ../input/*.in; do
	./$PROGRAM_COMMAND $f > /dev/null
	RETURN_VALUE=$(echo $?)
	if [[ $RETURN_VALUE -gt 0 ]]
	then
		echo -e "testing $f ${RED}failed${RESET}"
	else
		echo -e "testing $f ${GREEN}pass${RESET}"
	fi
done
