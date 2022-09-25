#!/bin/bash


cd ~
cd SPADE/bin
./spade start
sleep 1
echo -e "add analyzer CommandLine\nadd storage PostgreSQL\nadd reporter Audit inputLog=/home/vagrant/Container/CVE_14271/cve_14271.log\nexit" | ./spade control
echo -e "%artifact = \"inode\" == '77498'\n\$artifact = \$base.getVertex(%artifact)\n%reader = \"pid\" == '14332' and \"start time\" == '1663000960.894'\n\$reader = \$base.getVertex(%reader)\n%writer = \"pid\" == '14305' and \"start time\" == '1663000885.250'\n\$writer = \$base.getVertex(%writer)\n\$path = \$base.getPath(\$reader, \$artifact, 1) + \$base.getPath(\$artifact, \$writer, 1)\nlist\nexport > /tmp/14271_1.dot\ndump all \$path\nexit" | ./spade query
./spade stop
sleep 1
truncate -s 0 ../cfg/spade.client.Control.config
./manage-postgres.sh clear
cd ~
cd /tmp
dot -Tsvg -o 14271_1.svg 14271_1.dot
