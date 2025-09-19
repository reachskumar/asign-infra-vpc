#!/bin/bash

# Bastion host bootstrap script
# Hardens security and installs essential tools for private instance access

set -e

# System updates
yum update -y

# Essential tools for troubleshooting and AWS operations
yum install -y htop vim git curl wget jq awscli tree unzip

# AWS Systems Manager for secure access
yum install -y amazon-ssm-agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# SSH security hardening
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd

# Login banner
cat > /etc/motd << EOF
===============================================
  ${project_name} ${environment} Bastion Host
===============================================

Quick commands:
- list-private-instances    # Show all private instances
- ssh-private <instance-id> # Connect to private instance
- aws ssm start-session --target <instance-id> # SSM access

===============================================
EOF

# Security log retention
cat > /etc/logrotate.d/bastion-security << EOF
/var/log/secure {
    daily
    missingok
    rotate 30
    compress
    delaycompress
    notifempty
    create 644 root root
}
EOF

# Helper: List private instances in current VPC
cat > /usr/local/bin/list-private-instances << 'EOF'
#!/bin/bash
VPC_ID=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ | head -1)/vpc-id)
echo "Private instances in VPC: $VPC_ID"
aws ec2 describe-instances \
  --filters "Name=instance-state-name,Values=running" "Name=vpc-id,Values=$VPC_ID" \
  --query 'Reservations[*].Instances[*].[InstanceId,Tags[?Key==`Name`].Value|[0],PrivateIpAddress,State.Name]' \
  --output table
EOF

# Helper: SSH to private instance by ID
cat > /usr/local/bin/ssh-private << 'EOF'
#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: ssh-private <instance-id> [ssh-options]"
    exit 1
fi

INSTANCE_ID=$1
shift

PRIVATE_IP=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[*].Instances[*].PrivateIpAddress' \
  --output text)

if [ -z "$PRIVATE_IP" ]; then
    echo "Instance $INSTANCE_ID not found or no private IP"
    exit 1
fi

echo "Connecting to $INSTANCE_ID ($PRIVATE_IP)..."
ssh -i ~/.ssh/asign-bastion-key ec2-user@"$PRIVATE_IP" "$@"
EOF

chmod +x /usr/local/bin/list-private-instances /usr/local/bin/ssh-private

# Setup complete
echo "$(date): Bastion setup completed" >> /var/log/bastion-setup.log