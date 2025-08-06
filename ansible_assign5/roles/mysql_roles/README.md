# Ansible Role to Install and Configure using given tool (MySql) 
## Description:
This project provides an Ansible role to install, configure, and secure a specific version of MySQL on both Ubuntu and CentOS systems. It sets the root password, configures authentication with the mysql_native_password plugin, and uses a Jinja2 template for custom MySQL configuration.

# Project Structure
ansible_assign5/
├── roles/
│   └── mysql_roles/
│       ├── defaults/
│       │   └── main.yml
│       ├── handlers/
│       │   └── main.yml
│       ├── meta/
│       │   └── main.yml
│       ├── tasks/
│       │   └── main.yml
│       ├── templates/
│       │   └── conf.j2
│       ├── vars/
│       │   └── main.yml
│       └── README.md
└── sql_playbook.yml

# Features:
OS-independent installation (Ubuntu & CentOS)

Installs MySQL using version variable (mysql_version)

Sets MySQL root password securely

Uses mysql_native_password plugin for root authentication

Custom configuration using Jinja2 template (conf.j2)

Service enabled and restarted using handlers

Supports Python-MySQL connector (python3-pymysql / python3-PyMySQL)

