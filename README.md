# Server administration tools
All kinds of tooling to manage your servers (bash-based scripting)

## BASH

We have scripts for multiple purposes:

* Backup managament
* Time management
* SSH management

## Time administration for servers
Check if NTP-configuration is active. If it is active you can check the configuration with `ntpstat`. If it is not configured then you can configure it with the `ntpd`-service.

If you want to determine if the ntpd service is configured and in which state it is running you can run the following command:

```
ntpstat
```

You run the following commands and the service is configured.

```
ntpdate
```

## Setup public key for a user
When you jump to a server you cannot give a remote command to the target server. You have make a proxy to the target server to run scripts.

For example: 

```
Host *.target.host
  ProxyCommand ssh #username#@jump.host -W %h:%p
```

Now you can run scripts on the target hosts.



# VM configuration

All VM's are running on OpenStack

## Restart

* CentOS
  Make sure you restart the following services 
  * sudo service tomcat7 restart
  * sudo service httpd restart

## Cloning VM's

You can clone VM's on OpenStack with virtsh?