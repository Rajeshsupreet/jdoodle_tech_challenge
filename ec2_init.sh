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


sudo cat << 'EOF' > /home/ubuntu/metrics.sh
#!/bin/bash
load_avg_5min=$(uptime | awk -F'load average: ' '{print $2}' | cut -d ',' -f2 | tr -d ' ')
percentage_5min=$(echo "scale=2; ($load_avg_5min) * 100" | bc)

aws cloudwatch put-metric-data --namespace "AWS/EC2" --metric-name "LoadAverage5min" --value "$percentage_5min" --region "us-east-1"
echo "successfully done"
EOF

sudo chmod +x /home/ubuntu/metrics.sh

sudo service cron start

sudo echo "$(echo '*/2 * * * * /home/ubuntu/metrics.sh' ; crontab -l 2>/dev/null)" | crontab