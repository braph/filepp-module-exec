#!/usr/bin/env bash

unset CDPATH
set -u +o histexpand -e

if [[ -e '../exec.pm' ]]; then
   echo "Using include-dir .."
   FPP_MODULES='-I..'
else
   FPP_MODULES=''
fi

fpp() {
   filepp $FPP_MODULES "$@"
}

failed() {
   echo 'FAILED'
   echo "$@"
   exit 1
}

echo -n 'Testing module load ... '
echo 'OK' | fpp -m exec.pm -c

echo 'Testing exec() ... '
OUT=$(echo 'exec(echo, $$)' | fpp -m exec.pm -c)
[[ "$OUT" == '$$' ]] || failed "$OUT"

echo 'Testing exec() with unkonwn command ... '
OUT=$(echo 'exec(unknown_command123)' | fpp -m exec.pm -c)

echo 'Testing EXEC_MACRO_NAME #1 ... '
OUT=$(echo 'exec(echo test)' |\
   fpp -DEXEC_MACRO_NAME=filepp_exec -m exec.pm -c)
[[ "$OUT" == 'exec(echo test)' ]] || failed "$OUT"

echo 'Testing EXEC_MACRO_NAME #2 ... '
OUT=$(echo 'filepp_exec(echo, test)' |\
   fpp -DEXEC_MACRO_NAME=filepp_exec -m exec.pm -c)
[[ "$OUT" == 'test' ]] || failed "$OUT"

echo 'Testing shell() ... '
OUT=$(echo 'shell(echo $$)' | fpp -m exec.pm -c)
echo "$OUT" | grep -qE '^[0-9]+$' || failed "$OUT"

echo 'Testing shell() with unknown command ... '
OUT=$(echo 'shell(unknown_command123)' | fpp -m exec.pm -c)

echo 'Testing SHELL_MACRO_NAME #1 ... '
OUT=$(echo 'shell(echo test)' |\
   fpp -DSHELL_MACRO_NAME=filepp_shell -m exec.pm -c)
[[ "$OUT" == 'shell(echo test)' ]] || failed "$OUT"

echo 'Testing SHELL_MACRO_NAME #2 ... '
OUT=$(echo 'filepp_shell(echo test)' |\
   fpp -DSHELL_MACRO_NAME=filepp_shell -m exec.pm -c)
[[ "$OUT" == 'test' ]] || failed "$OUT"

