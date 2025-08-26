#!/bin/bash
# Update system
sudo apt update -y
sudo apt install mysql-server -y

# Configure MySQL to listen on all interfaces
sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

# Root password & remote access
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root123'; FLUSH PRIVILEGES;"
sudo mysql -e "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root123'; FLUSH PRIVILEGES;"

# Replication user
sudo mysql -uroot -proot123 -e "CREATE USER IF NOT EXISTS 'replica'@'%' IDENTIFIED BY 'replica123';"
sudo mysql -uroot -proot123 -e "GRANT REPLICATION SLAVE ON *.* TO 'replica'@'%'; FLUSH PRIVILEGES;"

# Database & table
sudo mysql -uroot -proot123 -e "CREATE DATABASE IF NOT EXISTS students_db;"
sudo mysql -uroot -proot123 students_db -e "CREATE TABLE IF NOT EXISTS students (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(20), grade VARCHAR(5));"
sudo mysql -uroot -proot123 students_db -e "INSERT INTO students (name, grade) VALUES ('Disha','A'),('Anusha','B'),('Vishakha','A'),('Anaya','B+'),('Shanvi','A+');"
