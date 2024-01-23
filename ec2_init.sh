#!/bin/bash

#install aws cli

sudo apt -y update

sudo apt -y install zip

sudo apt -y install cron

sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo unzip awscliv2.zip

sudo ./aws/install

sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

sudo aws --version

sudo apt-get update -y 
sudo apt install apache2 -y
sudo systemctl status apache2

sudo cat << 'EOF' > /home/ubuntu/metrics.sh
#!/usr/bin/env bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

load_avg_5min=$( cat /proc/loadavg | awk '{print $2;}' )

id=`cat /var/lib/cloud/data/instance-id`

percentage_5min=$(echo "scale=2; ($load_avg_5min) * 100" | bc)

aws cloudwatch put-metric-data --namespace "AWS/AutoScaling" --metric-name "LoadAverage5min" --unit Percent --value "$percentage_5min" --region "us-east-1"

echo "successfully done"
EOF

sudo chmod +x /home/ubuntu/metrics.sh

sudo service cron start

#sudo echo "$(echo '*/2 * * * * /home/ubuntu/metrics.sh' ; crontab -l 2>/dev/null)" | crontab

command="bash /home/ubuntu/metrics.sh"

job="*/2 * * * * $command"

cat <(fgrep -i -v "$command" <(crontab -l)) <(echo "$job") | sudo crontab -