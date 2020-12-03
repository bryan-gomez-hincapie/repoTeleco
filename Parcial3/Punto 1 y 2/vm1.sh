#VM1
#Actualizar paquetes

sudo yum install vim -y

sudo service NetworkManager stop
sudo chkconfig NetworkManager off
sudo cp /vagrant/vm1/sysctl.conf /etc/sysctl.conf
sudo cp /vagrant/vm1/config /etc/selinux/config

sudo service firewalld start
#chkconfig firewalld on

sudo firewall-cmd --zone=public --add-interface=eth2 --permanent
sudo firewall-cmd --zone=internal --add-interface=eth1 --permanent

sudo firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth1 -o eth2 -j ACCEPT
sudo firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth2 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT

sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --zone=public --add-port=80/udp --permanent
sudo firewall-cmd --zone=internal --add-port=80/tcp --permanent
sudo firewall-cmd --zone=internal --add-port=80/udp --permanent

sudo firewall-cmd --zone=public --add-masquerade --permanent
sudo firewall-cmd --zone=internal --add-masquerade --permanent
sudo firewall-cmd --zone="public" --add-forward-port=port=80:proto=tcp:toport=8080:toaddr=192.168.50.20 --permanent

sudo service firewalld restart
sudo firewall-cmd --reload


