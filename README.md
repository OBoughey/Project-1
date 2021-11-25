## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Diagram](https://github.com/wykesco/Project-1/blob/main/Diagrams/Topology.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML file may be used to install only certain pieces of it, such as Filebeat.

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the statistics and system logs.

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.1.0.7   |Ubuntu 20.04.2 LTS|
| Web-1    | DVWA HOST| 10.1.0.5   |Ubuntu 20.04.2 LTS|
| Web-2    | DVWA HOST| 10.1.0.6   |Ubuntu 20.04.2 LTS|
| ELK      | ELK HOST | 10.0.0.4   |Ubuntu 20.04.2 LTS|

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the gateway machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: 

- 110.175.38.229

Machines within the network can only be accessed by Jump-Box-Provisioner@10.1.0.7

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 110.175.38.229       |
| Web-1    | No                  |                      |
| Web-2    | No                  |                      |
| ELK      | Yes                 | 110.175.38.229       |
### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it allows for the implementation of infasructure as code, seemlessly deploying identical architecture, reducing human error and saving time.


The playbook implements the following tasks:
- Install Docker
- Install Python3
- Install Python Docker Module
- Allocate more memory
- Download/Configure ELK image
- Enable Docker

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Docker ps](https://github.com/wykesco/Project-1/blob/main/Diagrams/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.1.0.5
- 10.1.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat monitors the log files, collecting and forwarding information such as when files have changed to Elasticsearch for interpretation.
- Metricbeat collects metrics form the operating system and services such as CPU usage, memory and network statistics


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the ELK-config file to /etc/ansible/files.
- Update the hosts file to include the new ip address
- Run the playbook, and navigate to http://52.147.51.207:5601/app/kibana to check that the installation worked as expected.

#### Commands for redeployment

```sudo curl -O https://(Personal Access Token)@raw.githubusercontent.com/wykesco/Project-1/main/Ansible/Elk.ssh```
```bash ELK.sh```

