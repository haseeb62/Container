#!/bin/bash
cd ~
cd SPADE/bin
./spade start
sleep 1
echo -e "add analyzer CommandLine
add storage PostgreSQL
add reporter Audit inputLog=/home/vagrant/Container/2019-5736/5736_audit.log

remove reporter Audit
remove storage PostgreSQL
add storage PostgreSQL
set storage PostgreSQL
exit" | ./spade control
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs1
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs2
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs3
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs4
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs5
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs6
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs7
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs8
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs9
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs10
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs11
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs12
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs13
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs14
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs15
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs16
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs17
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs18
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs19
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs20
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs21
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs22
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs23
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs24
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs25
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs26
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs27
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs28
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs29
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs30
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs31
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs32
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs33
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs34
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs35
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs36
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs37
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs38
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs39
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs40
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs41
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs42
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs43
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs44
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs45
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs46
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs47
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs48
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs49
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs50
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs51
/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/2019-5736/inputs52
./spade stop
truncate -s 0 ../cfg/spade.client.Control.config
./manage-postgres.sh clear
cd ~/Container/2019-5736
rm output.json
rm filtered.json
rm input*
rm SPADE-q*
cd ~
cd /tmp
dot -Tsvg -o ~/Container/2019-5736/5736_1.svg 5736_1.dot
dot -Tsvg -o ~/Container/2019-5736/5736_2.svg 5736_2.dot
dot -Tsvg -o ~/Container/2019-5736/5736_3.svg 5736_3.dot
dot -Tsvg -o ~/Container/2019-5736/5736_4.svg 5736_4.dot
dot -Tsvg -o ~/Container/2019-5736/5736_5.svg 5736_5.dot
dot -Tsvg -o ~/Container/2019-5736/5736_6.svg 5736_6.dot
dot -Tsvg -o ~/Container/2019-5736/5736_7.svg 5736_7.dot
dot -Tsvg -o ~/Container/2019-5736/5736_8.svg 5736_8.dot
dot -Tsvg -o ~/Container/2019-5736/5736_9.svg 5736_9.dot
dot -Tsvg -o ~/Container/2019-5736/5736_10.svg 5736_10.dot
dot -Tsvg -o ~/Container/2019-5736/5736_11.svg 5736_11.dot
dot -Tsvg -o ~/Container/2019-5736/5736_12.svg 5736_12.dot
dot -Tsvg -o ~/Container/2019-5736/5736_13.svg 5736_13.dot
dot -Tsvg -o ~/Container/2019-5736/5736_14.svg 5736_14.dot
dot -Tsvg -o ~/Container/2019-5736/5736_15.svg 5736_15.dot
dot -Tsvg -o ~/Container/2019-5736/5736_16.svg 5736_16.dot
dot -Tsvg -o ~/Container/2019-5736/5736_17.svg 5736_17.dot
dot -Tsvg -o ~/Container/2019-5736/5736_18.svg 5736_18.dot
dot -Tsvg -o ~/Container/2019-5736/5736_19.svg 5736_19.dot
dot -Tsvg -o ~/Container/2019-5736/5736_20.svg 5736_20.dot
dot -Tsvg -o ~/Container/2019-5736/5736_21.svg 5736_21.dot
dot -Tsvg -o ~/Container/2019-5736/5736_22.svg 5736_22.dot
dot -Tsvg -o ~/Container/2019-5736/5736_23.svg 5736_23.dot
dot -Tsvg -o ~/Container/2019-5736/5736_24.svg 5736_24.dot
dot -Tsvg -o ~/Container/2019-5736/5736_25.svg 5736_25.dot
dot -Tsvg -o ~/Container/2019-5736/5736_26.svg 5736_26.dot
dot -Tsvg -o ~/Container/2019-5736/5736_27.svg 5736_27.dot
dot -Tsvg -o ~/Container/2019-5736/5736_28.svg 5736_28.dot
dot -Tsvg -o ~/Container/2019-5736/5736_29.svg 5736_29.dot
dot -Tsvg -o ~/Container/2019-5736/5736_30.svg 5736_30.dot
dot -Tsvg -o ~/Container/2019-5736/5736_31.svg 5736_31.dot
dot -Tsvg -o ~/Container/2019-5736/5736_32.svg 5736_32.dot
dot -Tsvg -o ~/Container/2019-5736/5736_33.svg 5736_33.dot
dot -Tsvg -o ~/Container/2019-5736/5736_34.svg 5736_34.dot
dot -Tsvg -o ~/Container/2019-5736/5736_35.svg 5736_35.dot
dot -Tsvg -o ~/Container/2019-5736/5736_36.svg 5736_36.dot
dot -Tsvg -o ~/Container/2019-5736/5736_37.svg 5736_37.dot
dot -Tsvg -o ~/Container/2019-5736/5736_38.svg 5736_38.dot
dot -Tsvg -o ~/Container/2019-5736/5736_39.svg 5736_39.dot
dot -Tsvg -o ~/Container/2019-5736/5736_40.svg 5736_40.dot
dot -Tsvg -o ~/Container/2019-5736/5736_41.svg 5736_41.dot
dot -Tsvg -o ~/Container/2019-5736/5736_42.svg 5736_42.dot
dot -Tsvg -o ~/Container/2019-5736/5736_43.svg 5736_43.dot
dot -Tsvg -o ~/Container/2019-5736/5736_44.svg 5736_44.dot
dot -Tsvg -o ~/Container/2019-5736/5736_45.svg 5736_45.dot
dot -Tsvg -o ~/Container/2019-5736/5736_46.svg 5736_46.dot
dot -Tsvg -o ~/Container/2019-5736/5736_47.svg 5736_47.dot
dot -Tsvg -o ~/Container/2019-5736/5736_48.svg 5736_48.dot
dot -Tsvg -o ~/Container/2019-5736/5736_49.svg 5736_49.dot
dot -Tsvg -o ~/Container/2019-5736/5736_50.svg 5736_50.dot
dot -Tsvg -o ~/Container/2019-5736/5736_51.svg 5736_51.dot
dot -Tsvg -o ~/Container/2019-5736/5736_52.svg 5736_52.dot
rm 5736_*