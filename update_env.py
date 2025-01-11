import gdb

class UpdateEnv(gdb.Command):
    """
    Command to update the environment variable of a running process.
    Usage: update_env VAR_NAME=VALUE
    Example: update_env ABC_DEBUG_LEVEL=5
    """

    def __init__(self):
        super(UpdateEnv, self).__init__('update_env', gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        # Parse the argument for the variable name and value
        if '=' not in arg:
            gdb.write('Usage: update_env VAR_NAME=VALUE\n', gdb.STDERR)
            return

        var_name, value = arg.split('=', 1)
        if not var_name or not value:
            gdb.write('Error: Invalid format. Use VAR_NAME=VALUE.\n', gdb.STDERR)
            return

        # Inject the putenv call
        gdb.write(f'Updating environment: {var_name}={value}\n')
        putenv_call = f'((int)putenv("{var_name}={value}"))'
        gdb.execute(f'call {putenv_call}')

# Register the command with gdb
UpdateEnv()
