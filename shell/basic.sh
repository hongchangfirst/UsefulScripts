# Add below to improve your scripts.
set -euxo pipefail

# set -e, exit immediately when a command fails (non zero return value). Except in a conditional statement or "| true" suffix.

# set -o pipefail, non_existing_command | echo "will execute this but the whole pipeline command will fail"

# set -u, treat unset variables as an error, unset variables are a common cause of bugs in shell. Except default value assigment, ${a:-b}, Assign b to variable a if a is empty or undefined.

# set -x, print command before executing it. Arguments get expanded before printing it it's helpful to debug.

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/


