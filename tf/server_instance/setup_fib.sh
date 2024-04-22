#! /bin/bash
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker


sudo tee /etc/systemd/system/docker.fib.service <<'EOF'
[Unit]
Description=Fib Service
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStartPre=-/usr/bin/docker exec %n stop
ExecStartPre=-/usr/bin/docker rm %n
ExecStartPre=/usr/bin/docker pull twunde764/fib:dev
ExecStart=/usr/bin/docker run --rm --name %n \
    -p 80:80 \
    twunde764/fib:dev

[Install]
WantedBy=default.target
EOF


sudo systemctl enable docker.fib
sudo systemctl start docker.fib

# Add pebblepost ssh key to ec2-user's authorized keys.
# This would be replaced in a full setup with AWS' Session Manager for the rare times that an admin needs to log in
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOp3/gxWAiMMVbOHNGnIGW0BIswmPZ6t4VNOyQ1YsLqy takehome@pebblepost.com" | sudo tee --append /home/ec2-user/.ssh/authorized_keys

