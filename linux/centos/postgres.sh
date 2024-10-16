# enabled=1 update extra and base on /etc/yum.repos.d/CentOS-Vault.repo
# enable=0 on all from /etc/yum.repos.d/CentOS-Base.repo
sudo yum install -y https://download.postgresql.org/pub/repos/yum/12/redhat/rhel-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum install -y postgresql-12 postgresql12-server
sudo /usr/pgsql-12/bin/postgresql-12-setup initdb


sudo yum list installed postgresql*-contrib
sudo yum list available postgresql*-contrib
sudo yum remove postgresql*-contrib
sudo yum install -y postgresql12-contrib 
# sudo yum install -y postgresql-contrib 

# LIBDIR SHAREDIR
pg_config | less


sudo vi /var/lib/pgsql/12/data/postgresql.conf
systemctl restart postgresql-12.service
journalctl -xe -u postgresql-12.service


# Troubleshooting
find /usr -name  *.control
ls -l /usr/pgsql-12/share/extension/pg_stat_statements.control
ls -l /usr/share/pgsql/extension/pg_stat_statements.control

# https://download.postgresql.org/pub/repos/yum/12/redhat/rhel-7-x86_64/

# ERROR:  could not open extension control file "/usr/pgsql-12/share/extension/pg_stat_statements


# https://gis.stackexchange.com/a/298881

sudo yum install -y postgresql12-contrib-12.9-1PGDG.rhel7.rpm


# # Install the repository RPM: 
sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm 

# https://www.pg-forum.de/t/pg-stat-statements-error-extension-pg-stat-statements-has-no-installation-script-nor-update-path-for-version-1-7/12188/10

 /opt/postgres/12.5/lib