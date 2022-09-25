#!/bin/bash
cd ~
cd SPADE/bin
./spade start
sleep 1
echo -e "add analyzer CommandLine
add storage PostgreSQL
add reporter Audit inputLog=/home/vagrant/Container/CVE_14271/cve_14271.log

remove reporter Audit
remove storage PostgreSQL
add storage PostgreSQL
set storage PostgreSQL
exit" | ./spade control
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs1
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs2
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs3
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs4
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs5
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs6
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs7
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs8
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs9
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs10
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs11
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs12
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs13
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs14
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs15
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs16
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs17
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs18
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs19
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs20
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs21
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs22
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs23
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs24
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs25
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs26
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs27
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs28
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs29
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs30
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs31
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs32
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs33
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs34
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs35
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs36
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs37
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs38
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs39
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs40
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs41
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs42
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs43
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs44
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs45
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs46
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs47
./spade stop
truncate -s 0 ../cfg/spade.client.Control.config
./manage-postgres.sh clear
cd ~/Container/CVE_14271
rm output.json
rm filtered.json
rm input*
rm SPADE-q*
