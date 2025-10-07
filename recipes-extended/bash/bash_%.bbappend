BUILD_CFLAGS += "-std=gnu17"

# Set the priority to 0 to ensure that bash does not become the default shell.
# Bash shall be used as an interactive shell, but not as the default system
# wide shell, since bash is large.
ALTERNATIVE_PRIORITY[sh] = "0"
