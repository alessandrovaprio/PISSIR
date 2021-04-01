#!/bin/sh

VERSION=12.0.4

DOWNLOAD_URL=https://github.com/keycloak/keycloak/releases/download/${VERSION}/keycloak-${VERSION}.tar.gz

apt-get update
apt-get install openjdk-8-jre-headless -y

# Install Keycloak
if [ -f "/vagrant/downloads/keycloak-${VERSION}.tar.gz" ];
then
    echo "Installing Keycloak from /vagrant/downloads/keycloak-${VERSION} ..."
else
    echo "Downloading Keycloak ${VERSION} ..."
    mkdir -p /vagrant/downloads
    wget -q -O /vagrant/downloads/keycloak-${VERSION}.tar.gz "${DOWNLOAD_URL}"
    if [ $? != 0 ];
    then
        echo "FATAL: Failed to download Keycloak from ${DOWNLOAD_URL}"	
        exit 1
    fi

    echo "Installing Keycloak ..."
fi

tar xfz /vagrant/downloads/keycloak-${VERSION}.tar.gz -C /opt
rm -f /opt/keycloak
ln -s /opt/keycloak-${VERSION} /opt/keycloak

sed -i 's=/opt/wildfly/bin/launch.sh=/opt/keycloak/bin/launch.sh=g' /opt/keycloak/docs/contrib/scripts/systemd/wildfly.service

useradd -r -s /bin/false wildfly

mkdir -p /etc/wildfly
ln -s /vagrant/wildfly.conf /etc/wildfly/wildfly.conf
ln -s /opt/keycloak/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/wildfly.service
ln -s /opt/keycloak/docs/contrib/scripts/systemd/launch.sh /opt/keycloak/bin/launch.sh
rm /opt/keycloak/standalone/configuration/standalone.xml
ln -s /vagrant/standalone.xml /opt/keycloak/standalone/configuration/

# Install MariaDB JDBC driver & restore dump
MARIADB_DEST_DIR=/opt/keycloak/modules/system/layers/keycloak/org/mariadb/main
MARIADB_VERSION=2.7.2
mkdir -p "$MARIADB_DEST_DIR"
wget -q -O "$MARIADB_DEST_DIR/mariadb-java-client-$MARIADB_VERSION.jar" \
	"https://repo1.maven.org/maven2/org/mariadb/jdbc/mariadb-java-client/$MARIADB_VERSION/mariadb-java-client-$MARIADB_VERSION.jar"
cp /vagrant/mariadb-module.xml "$MARIADB_DEST_DIR/module.xml"
sed -i "s=mariadb-java-client-VERSION.jar=mariadb-java-client-$MARIADB_VERSION.jar=g" "$MARIADB_DEST_DIR/module.xml"

mariadb -e "CREATE DATABASE keycloak;"
mariadb -e "GRANT ALL PRIVILEGES ON keycloak.* TO 'keycloak'@'localhost' IDENTIFIED BY 'keycloak' WITH GRANT OPTION; FLUSH PRIVILEGES;"
cat /vagrant/keycloak.sql | mariadb keycloak

# Permissions
chown -R wildfly /opt/keycloak-${VERSION}

# Start
systemctl daemon-reload
systemctl enable wildfly --now

