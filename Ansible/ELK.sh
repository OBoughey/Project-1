#!/bin/bash

#Ask user for ELK_server ip

echo "What's the ELK Server's IP address?"

read elk_ip

#Ask user how many web servers are being configured

echo "How many Web servers are we configuring?"

read server_num

#determine number of web servers and take ip addresses

if [[ $server_num -eq 1 ]]
then
  echo 'whats the Web server'
read web_ip
fi

if [[ $server_num -eq 2 ]]
then
  echo "whats the first Web server's ip?"
read web_ip
  echo "what's the second Web server's ip?"
read web_ip_2
fi

if [[ $server_num -eq 3 ]]
then
  echo "whats the first Web server's ip?"
read web_ip
  echo "what's the second Web server's ip?"
read web_ip_2
  echo "what's the third Web server's ip?"
read web_ip_3
fi

if [[ $server_num -eq 4 ]]
then
  echo "whats the first Web server's ip?"
read web_ip
  echo "what's the second Web server's ip?"
read web_ip_2
  echo "what's the third Web server's ip?"
read web_ip_3
  echo "what's the fourth Web server's ip?"
read web_ip_4
fi

#take IP address arguments and ammend the configurations to include these machines
sed -i '/#192.168.1.110/a [elk]\n'$elk_ip' ansible_python\_interpreter=/usr/bin/python3' hosts.txt
sed -i '/#beta.example.org/a '$web_ip' ansible_python_interpreter=/usr/bin/python3' hosts.txt
sed -i 's/10.0.0.4/'$elk_ip'/g' filebeat-config.yml
sed -i 's/10.0.0.4/'$elk_ip'/g' metricbeat-config.yml

if [[ $server_num == [2-4] ]]
then
sed -i '/'$web_ip'/a '$web_ip_2' ansible_python_interpreter=/usr/bin/python3' hosts.txt
fi

if [[ $server_num == [3-4] ]]
then
sed -i '/'$web_ip_2'/a '$web_ip_3' ansible_python_interpreter=/usr/bin/python3' hosts.txt
fi

if [[ $server_num -eq 4 ]]
then
sed -i '/'$web_ip_3'/a '$web_ip_4' ansible_python_interpreter=/usr/bin/python3' hosts.txt
fi
