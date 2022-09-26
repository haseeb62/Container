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
cd ~
cd /tmp
dot -Tsvg -o ~/Container/CVE_14271/14271_1.svg 14271_1.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_2.svg 14271_2.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_3.svg 14271_3.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_4.svg 14271_4.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_5.svg 14271_5.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_6.svg 14271_6.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_7.svg 14271_7.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_8.svg 14271_8.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_9.svg 14271_9.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_10.svg 14271_10.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_11.svg 14271_11.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_12.svg 14271_12.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_13.svg 14271_13.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_14.svg 14271_14.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_15.svg 14271_15.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_16.svg 14271_16.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_17.svg 14271_17.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_18.svg 14271_18.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_19.svg 14271_19.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_20.svg 14271_20.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_21.svg 14271_21.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_22.svg 14271_22.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_23.svg 14271_23.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_24.svg 14271_24.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_25.svg 14271_25.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_26.svg 14271_26.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_27.svg 14271_27.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_28.svg 14271_28.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_29.svg 14271_29.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_30.svg 14271_30.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_31.svg 14271_31.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_32.svg 14271_32.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_33.svg 14271_33.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_34.svg 14271_34.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_35.svg 14271_35.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_36.svg 14271_36.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_37.svg 14271_37.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_38.svg 14271_38.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_39.svg 14271_39.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_40.svg 14271_40.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_41.svg 14271_41.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_42.svg 14271_42.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_43.svg 14271_43.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_44.svg 14271_44.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_45.svg 14271_45.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_46.svg 14271_46.dot
dot -Tsvg -o ~/Container/CVE_14271/14271_47.svg 14271_47.dot
rm 14271_*