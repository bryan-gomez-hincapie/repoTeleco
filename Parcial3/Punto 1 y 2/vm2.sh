#VM2
#Actualizar paquetes
sudo yum -y install wget
sudo yum install vim -y
sudo yum -y update

#Instalar Oracle Java
sudo wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm"

# instalar archivo Red Hat Package Manager (se utiliza para almacenar paquetes de instalación en SO Linux)
sudo yum -y localinstall jdk-8u131-linux-x64.rpm

#Descargar paquete Streama War
sudo wget https://github.com/dularion/streama/releases/download/v1.1/streama-1.1.war

#Cambiar nombre y reubicar el archivo
sudo mkdir /opt/streama
sudo mv streama-1.1.war /opt/streama/streama.war

#Carpeta para almacenar los archivos y el permiso
sudo mkdir /opt/streama/media
sudo chmod 664 /opt/streama/media

#Archivo de configuracion
sudo cp /vagrant/vm2/stream/streama.service /etc/systemd/system/

#Mover archivos de stream 
sudo mv streama.mv.db /opt/streama/streama.mv.db
sudo mv streama.trace.db /opt/streama/streama.trace.db
sudo systemctl daemon-reload

#Activar, inicio automatico, estado
systemctl start streama
systemctl enable streama
systemctl status streama

#java -version -- Ver la version de java
#java -jar /opt/streama/streama.war -- Iniciar app




