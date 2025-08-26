#!/bin/bash
sudo apt update -y
sudo apt install mysql-server -y

# Root password
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root123'; FLUSH PRIVILEGES;"

# Allow connections
sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

# Configure as Replica (manual step after terraform apply)
# Run on replica:
# CHANGE MASTER TO MASTER_HOST='<mysql_a_private_ip>', MASTER_USER='replica', MASTER_PASSWORD='replica123', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=  107;
# START SLAVE;
