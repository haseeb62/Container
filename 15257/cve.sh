#!/bin/bash
cd ~
cd SPADE/bin
./spade start
sleep 1
echo -e "add analyzer CommandLine
add storage PostgreSQL
add reporter Audit inputLog=/home/vagrant/15257/15257_audit.log
remove reporter Audit
remove storage PostgreSQL
add storage PostgreSQL
set storage PostgreSQL
exit" | ./spade control
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs1
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs2
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs3
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs4
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs5
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs6
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs7
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs8
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs9
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs10
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs11
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs12
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs13
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs14
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs15
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs16
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs17
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs18
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs19
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs20
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs21
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs22
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs23
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs24
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs25
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs26
./spade stop
truncate -s 0 ../cfg/spade.client.Control.config
./manage-postgres.sh clear
cd ~/Container/15257
rm output.json
rm filtered.json
rm input*
rm SPADE-q*
cd ~
cd /tmp
dot -Tsvg -o ~/Container/15257/15257_1.svg 15257_1.dot
dot -Tsvg -o ~/Container/15257/15257_2.svg 15257_2.dot
dot -Tsvg -o ~/Container/15257/15257_3.svg 15257_3.dot
dot -Tsvg -o ~/Container/15257/15257_4.svg 15257_4.dot
dot -Tsvg -o ~/Container/15257/15257_5.svg 15257_5.dot
dot -Tsvg -o ~/Container/15257/15257_6.svg 15257_6.dot
dot -Tsvg -o ~/Container/15257/15257_7.svg 15257_7.dot
dot -Tsvg -o ~/Container/15257/15257_8.svg 15257_8.dot
dot -Tsvg -o ~/Container/15257/15257_9.svg 15257_9.dot
dot -Tsvg -o ~/Container/15257/15257_10.svg 15257_10.dot
dot -Tsvg -o ~/Container/15257/15257_11.svg 15257_11.dot
dot -Tsvg -o ~/Container/15257/15257_12.svg 15257_12.dot
dot -Tsvg -o ~/Container/15257/15257_13.svg 15257_13.dot
dot -Tsvg -o ~/Container/15257/15257_14.svg 15257_14.dot
dot -Tsvg -o ~/Container/15257/15257_15.svg 15257_15.dot
dot -Tsvg -o ~/Container/15257/15257_16.svg 15257_16.dot
dot -Tsvg -o ~/Container/15257/15257_17.svg 15257_17.dot
dot -Tsvg -o ~/Container/15257/15257_18.svg 15257_18.dot
dot -Tsvg -o ~/Container/15257/15257_19.svg 15257_19.dot
dot -Tsvg -o ~/Container/15257/15257_20.svg 15257_20.dot
dot -Tsvg -o ~/Container/15257/15257_21.svg 15257_21.dot
dot -Tsvg -o ~/Container/15257/15257_22.svg 15257_22.dot
dot -Tsvg -o ~/Container/15257/15257_23.svg 15257_23.dot
dot -Tsvg -o ~/Container/15257/15257_24.svg 15257_24.dot
dot -Tsvg -o ~/Container/15257/15257_25.svg 15257_25.dot
dot -Tsvg -o ~/Container/15257/15257_26.svg 15257_26.dot
rm 15257_*