# For Cygwin on Windows only: run on every worker node to set up
# SSH server
# Run Cygwin as Administrator
$ ssh-host-config -y -c "tty ntsec"
$ chmod 400 /etc/ssh_*_key
$ cygrunsrv -S sshd

# For all platforms: run on the master node
# Remember to disable firewalls, or add a rule to allow incoming
# TCP connections on port 22
# Generate an RSA key pair without password
$ ssh-keygen -t rsa
$ chmod 400 .ssh/id_rsa
# Copy public key to worker node (run for every worker)
$ ssh-copy-id -i .ssh/id_rsa.pub worker_username@worker_address
# Test connection (run for every worker)
$ ssh woker_username@worker_address
# You should be able to log in without entering a password
