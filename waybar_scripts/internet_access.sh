#!/bin/sh

CHECK_CONNECTION=$( ping -c 1 www.google.com 2>&1 )
RESULT=$?

[ $RESULT -eq 0 ] && echo "{\"text\": \"    CONN \", \"class\": \"connected\"}" || echo "{\"text\": \" NO_CONN \", \"class\": \"disconnected\"}"
