# Ansible Role to Install and Configure using given tool (MySql) 
## Description:
This project provides an Ansible role to install, configure, and secure a specific version of MySQL on both Ubuntu and CentOS systems. It sets the root password, configures authentication with the mysql_native_password plugin, and uses a Jinja2 template for custom MySQL configuration.

# Project Structure SS
<img width="1868" height="660" alt="image" src="https://github.com/user-attachments/assets/4b143b5f-d5d7-4fb3-931b-94d12f06c38d" />

# Features:
OS-independent installation (Ubuntu & CentOS)

Installs MySQL using version variable (mysql_version)

Sets MySQL root password securely

Uses mysql_native_password plugin for root authentication

Custom configuration using Jinja2 template (conf.j2)

Service enabled and restarted using handlers

Supports Python-MySQL connector (python3-pymysql / python3-PyMySQL)

* SS shows that playbook ran successfully
<img width="1505" height="664" alt="image" src="https://github.com/user-attachments/assets/0da49bba-ac10-4379-a93e-871ef8a3aba8" />
