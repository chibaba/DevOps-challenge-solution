MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
echo "Running custom user data script"
sudo yum update    
sudo amazon-linux-extras install epel
sudo yum install --enablerepo="epel" ufw -y
sudo ufw enable -y
sudo ufw disable
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 1337
sudo ufw allow 10250
sudo ufw allow 10255  
sudo ufw allow 8081
sudo ufw allow 8080      
sudo ufw allow 30000:32767/tcp
sudo sed -i '/#Port/c\Port 1337' /etc/ssh/sshd_config
sudo sed -i '/#PermitRootLogin/c\PermitRootLogin no' /etc/ssh/sshd_config
sudo yum install policycoreutils-python.x86_64
sudo semanage port -a -t ssh_port_t -p tcp 1337
sudo systemctl restart sshd.service
sudo ufw enable

--==MYBOUNDARY==--