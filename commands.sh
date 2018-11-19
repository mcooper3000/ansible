ansible 192.168.1.201 -i inventory -u root -m ping -k -vvv

ansible all -i inventory -u root -a "/sbin/reboot" -k

ansible webservers -i inventory_prod -m user -a "name={{username}} password=12345" --sudo


[root@ansible exercise4]# tree
.
├── prod
│   ├── group_vars
│   │   ├── all
│   │   ├── db
│   │   └── webservers
│   ├── host_vars
│   │   └── web1
│   └── inventory_prod
└── test
    ├── group_vars
    └── host_vars

Order of Operation 1st - last
	$ANSIBLE_CONFIG
	./ansible.cfg
	~/ansible.cfg
	/etc/ansible.cfg

cat ~/.ssh/known_hosts

ansible webservers -i inventory_prod -m yum -a "name=httpd state=present" --sudo

ansible-doc services
ansible webservers -i inventory_prod -m service -a "name=httpd enabled=yes state=started" --sudo

ansible dbservers -i inventory_prod -m yum -a "name=mariadb-server state=present" --sudo
ansible dbservers -i inventory_prod -m service -a "name=mariadb enabled=yes state=started" --sudo

systemctl | grep firewall
ansible webservers:dbservers -i inventory_prod -m service -a "name=firewalld state=stopped" --sudo
: is all
! is NOT
* web*.testing.com 
~web[0-9]+ regex
& AND (resides in both groups not all) ie only web and prod 
webservers:&prod:!python3

ansible web1 -i inventory_prod -m setup

#return network info
ansible web1 -i inventory_prod -m setup -a "filter=ansible_eth*"
#Disk mounts
ansible web1 -i inventory_prod -m setup -a "filter=ansible_mounts"

reformating JSON file
yum install yajl
cat web1 | json_reformat

#execut playbook (inventory file included playbook)
ansible-playbook playbook.yml
--limit used to only retry on failed servers

