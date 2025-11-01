Attck-defence simulation in Docker.
Capable of detecting DDOS attacks, nmap port scanning and os-probing, and sql-injection done against the password field of web-server.

Consists of:
    - attacker (name: kali) (located on the external network at 10.100.10.3)
    - vulnerable machine (name: juice_shop) (located at 192.168.70.4 and listening at port 3000)
    - internal machine (name: internal_host) (unused)
    - router (name: router) (connects internal and external networks with ip addresses 192.168.70.27 and 10.100.10.27)

To start Snort:
    Open router container by executing:
        sudo docker exec -it router /bin/bash
    Inside router run:
        snort -Q --daq nfq --daq-var queue=0 -c /etc/snort/snort.conf -A console -q

All Snort rules created for this simulation are within router at /etc/snort/rules/local.rules

###########
#IMPORTANT:
#External host (kali) will not be able to access the internal network unless the snort command mentioned above is running (since snort is set to work in inline mode here)
###########

To start attack:
    Open kali container by executing:
        sudo docker exec -it kali /bin/bash
    Run one of the corresponding commands:
        DDOS:
            slowloris 192.168.70.4 -p 3000
        port scanning:
            nmap 192.168.70.4
        os-probing:
            nmap 192.168.70.4 -O
        SQL-injection:
            sqlmap -u "http://192.168.70.4:3000/rest/user/login" --data "email=123@123&&password=12345" --ignore-code=401

