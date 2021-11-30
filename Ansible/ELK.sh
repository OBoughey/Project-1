#!/bin/bash

#download necessary files
echo "What's your Personal Access Token?"

read token

sudo curl -O https://$token@raw.githubusercontent.com/wykesco/Project-1/main/Ansible/config-web-vm.yml

sudo curl -O https://$token@raw.githubusercontent.com/wykesco/Project-1/main/Ansible/ELK-config.yml

sudo curl -O https://$token@raw.githubusercontent.com/wykesco/Project-1/tree/Ansible/filebeat-config.yml

sudo curl -O https://$token@raw.githubusercontent.com/wykesco/Project-1/main/Ansible/filebeat-playbook.yml

sudo curl -O https://$token@raw.githubusercontent.com/wykesco/Project-1/main/Ansible/metricbeat-config.yml

sudo curl -O https://$token@raw.githubusercontent.com/wykesco/Project-1/main/Ansible/metricbeat-playbook.yml

#Ask user for ELK_server ip
echo "What's the ELK Server's IP address?"

read elk_ip

#Ask user how many web servers are being configured
echo "How many Web servers are we configuring?"

read server_num

#determine number of web servers and take ip addresses
if [[ $server_num -eq 1 ]]
then
  echo "Whats the Web server's ip?"
read web_ip
fi

if [[ $server_num == [2-4] ]]
then
  echo "Whats the first Web server's ip?"
read web_ip
  echo "What's the second Web server's ip?"
read web_ip_2
fi

if [[ $server_num == [3-4] ]]
then
  echo "What's the third Web server's ip?"
read web_ip_3
fi

if [[ $server_num -eq 4 ]]
then
  echo "What's the fourth Web server's ip?"
read web_ip_4
fi

if [[ $server_num == [5-99] ]]
then
  echo "That's too many!" && exit 1
fi
#confirm user didnt make a mistake (human error mitigation haha)
printf 'ELK Server ip='$elk_ip'\nWebserver ip='$web_ip
if [[ $server_num == [2-4] ]]
then
printf '\nWebserver ip='$web_ip_2
fi
if [[ $server_num == [3-4] ]]
then
printf '\nWebserver ip='$web_ip_3
fi
if [[ $server_num -eq 4 ]]
then
printf '\nWebserver ip='$web_ip_4
fi

read -p "\nIs that Correct? [Y/N] " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

#take IP address arguments and ammend the configurations to include these machines
sed -i '/[elk]/a '$elk_ip' ansible_python\_interpreter=/usr/bin/python3' hosts
sed -i '/#beta.example.org/a '$web_ip' ansible_python_interpreter=/usr/bin/python3' hosts
sed -i 's/10.0.0.4/'$elk_ip'/g' filebeat-config.yml
sed -i 's/10.0.0.4/'$elk_ip'/g' metricbeat-config.yml

if [[ $server_num == [2-4] ]]
then
sed -i '/'$web_ip'/a '$web_ip_2' ansible_python_interpreter=/usr/bin/python3' hosts
fi

if [[ $server_num == [3-4] ]]
then
sed -i '/'$web_ip_2'/a '$web_ip_3' ansible_python_interpreter=/usr/bin/python3' hosts
fi

if [[ $server_num -eq 4 ]]
then
sed -i '/'$web_ip_3'/a '$web_ip_4' ansible_python_interpreter=/usr/bin/python3' hosts
fi

#run the playbooks 
#ansible-playbook config-web-vm.yml
#ansible-playbook ELK-config.yml
#ansible-playbook metricbeat-config.yml
#ansible-playbook filebeat-config.yml
