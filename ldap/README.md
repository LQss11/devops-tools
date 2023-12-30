# LDAP
You can use ldap to create groups and user and manage identities.

In this example we are using **osixia/openldap** server with the user interface **osixia/phpldapadmin**.

In order to login we as admin we can use the following parameters:
1. **DN**: cn=admin,dc=example,dc=myorg,dc=com
2. **Password**: mypw

# Linux 
If you want to test ldap using linux commands we first need to install ldapsearch cli tool and then runn few commands here is how to do it:
```sh
## Install ldapsearch
# Alpine: apk add openldap-clients
# Ubuntu: apt-get install -y ldap-utils libpam-ldap libnss-ldap

# -W to get asked for password (to not put in plain text)
ldapsearch -x -b "dc=example,dc=myorg,dc=com" -H ldap://host.docker.internal -D "cn=admin,dc=example,dc=myorg,dc=com" -w mypw
```
This command will list all details about the ldap server.

here I used **host.docker.internal** since I am testing this command from inside a docker container, if you are testing it from the host machine and the ldap port is exposed you can replace the domain with **localhost** or use ldap service name if both containers are in the same network.

## Create objects with script
```sh
export LDAP_DOMAIN=dc=example,dc=myorg,dc=com

cat > ldap-object.ldif <<EOF
dn: ou=groups,${LDAP_DOMAIN}
objectClass: organizationalunit
objectClass: top
ou: groups
description: groups of users

dn: ou=users,${LDAP_DOMAIN}
objectClass: organizationalunit
objectClass: top
ou: users
description: users

dn: cn=devops,ou=groups,${LDAP_DOMAIN}
objectClass: posixGroup
objectClass: top
cn: devops
gidNumber: 1001

# Password mypw
dn: cn=Salem Affes,ou=users,${LDAP_DOMAIN}
cn: Salem Affes
gidnumber: 1001
givenname: Salem
homedirectory: /home/users/saffes
loginshell: /bin/bash
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: Affes
uid: saffes
uidnumber: 1000
userpassword: mypw

# Password mypw
dn: cn=Another User,ou=users,${LDAP_DOMAIN}
cn: Another User
gidnumber: 1001
givenname: Another
homedirectory: /home/users/auser
loginshell: /bin/bash
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: User
uid: auser
uidnumber: 1001
userpassword: {MD5}GkuBc+pCHEBktBp7uVK2tA==
EOF
# Run the creation of ldap objects
ldapadd -cxD "cn=admin,${LDAP_DOMAIN}" -H ldap://host.docker.internal -w mypw -f ldap-object.ldif
ldapsearch -x -b "ou=users,dc=example,dc=myorg,dc=com" -H ldap://host.docker.internal -D "cn=admin,dc=example,dc=myorg,dc=com" -w mypw "(uid=saffes)"
```

# Docs
- [link](https://scytalelabs.com/2023/01/10/setup-and-configure-openldap-using-docker-image-on-ubuntu-16-04/)