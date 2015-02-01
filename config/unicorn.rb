# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/home/malstrom"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/home/malstrom/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/home/malstrom/log/unicorn.log"
stdout_path "/home/malstrom/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.malstrom.sock"
listen "/tmp/unicorn.myapp.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 75
