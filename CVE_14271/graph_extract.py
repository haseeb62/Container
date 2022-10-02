import os
import sys

import json

def getPrivilegedFlows(crossNamespaceFile, hostNamespace, containerNamespace, outputFile):
    with open(outputFile, "w") as outfile:  
        with open(crossNamespaceFile) as f:
            for line in f:
                check = False
                temp = json.loads(line)
                if temp["reader"]["pid namespace"] == hostNamespace:
                    for i in temp["writers"]:
                        if i["pid namespace"] == containerNamespace:
                            check = True
                        if i["pid namespace"] == "-1":
                            temp["writers"].remove(i)
                if check == True:
                    outfile.write(json.dumps(temp)+'\n')

def makeArtifactConstraint(input):
    constraint = '%artifact = '
    count = 0
    for key, value in input.items():
        if count == 0:
            constraint += '"{k}" == \'{v}\' '.format(k = key, v = value)
        else:
            constraint += 'and "{k}" == \'{v}\' '.format(k = key, v = value)
        count += 1
    return constraint + '\n'

def makeProcessConstraint(input, type):
    constraint = '%{type} = '.format(type=type)
    constraint += '"seen time" == \'{seenTime}\' '.format(seenTime=input['seen time']) if 'seen time' in input else '"start time" == \'{startTime}\' '.format(startTime=input['start time'])
    constraint += 'and "pid"= \'{pid}\''.format(pid=input['pid'])
    return constraint + '\n'


def generateBinary(input_file, output_file, query_file, inputLog_path, currentDirectory):
    flow_count = 1
    with open(output_file, "w") as outfile:
        outfile.write("#!/bin/bash\n")
        outfile.write("cd ~\n")
        outfile.write("cd SPADE/bin\n")
        outfile.write("./spade start\n")
        outfile.write("sleep 1\n")
        outfile.write('echo -e "add analyzer CommandLine\nadd storage PostgreSQL\nadd reporter Audit inputLog='+inputLog_path+'\nremove reporter Audit\nremove storage PostgreSQL\nadd storage PostgreSQL\nset storage PostgreSQL\nexit" | ./spade control\n')
        #Loops
        with open(input_file) as inputfile:
            
            for line in inputfile:
                flow = json.loads(line)
                with open(query_file + str(flow_count), "w") as qfile:
                    qfile.write(makeArtifactConstraint(flow["artifact"]))
                    qfile.write('$artifact = $base.getVertex(%artifact)' + '\n')
                    qfile.write(makeProcessConstraint(flow["reader"], 'reader'))
                    qfile.write('$reader = $base.getVertex(%reader)\n')
                    writer_count = 1
                    final_query = '$path = $base.getPath($reader, $artifact, 1)'
                    for writer in flow["writers"]:
                        qfile.write(makeProcessConstraint(writer, 'writer{num}'.format(num = str(writer_count))))
                        qfile.write('$writer{num} = $base.getVertex(%writer{num})\n'.format(num = str(writer_count)))
                        final_query += ' + $base.getPath($artifact, $writer{num}, 1)'.format(num = str(writer_count))
                        writer_count += 1
                    qfile.write(final_query + '\n')
                    qfile.write('export > /tmp/{f_count}.dot\n'.format(f_count = flow_count))
                    qfile.write('dump all $path\n')
                outfile.write("/home/vagrant/SPADE/bin/spade query < {currentDir}/inputs{f_count}\n".format(f_count = flow_count, currentDir=currentDirectory))
                flow_count += 1
        #End loop
        outfile.write("./spade stop\n")
        outfile.write("truncate -s 0 ../cfg/spade.client.Control.config\n")
        outfile.write("./manage-postgres.sh clear\n")
        outfile.write("cd ~{currentDir}\n".format(currentDir=currentDirectory.split('/')[2:].join('/')))
        outfile.write("mkdir graphs")
        outfile.write("rm output.json\n")
        outfile.write("rm filtered.json\n")
        outfile.write("rm input*\n")
        outfile.write("rm SPADE-q*\n")
        outfile.write("cd ~\n")
        outfile.write("cd /tmp\n")
        #Loop
        count = 1
        while count < flow_count:
            outfile.write("dot -Tsvg -o ~{currentDir}/graphs/{count}.svg {count}.dot\n".format(count=str(count), currentDir=currentDirectory))
            with open("inputs" + str(count), "w") as inputs:
                inputs.write("load {currentDir}/{queryFile}{count}\n".format(queryFile=query_file, currentDir=currentDirectory, count=str(count)))
                inputs.write("list\n")
                inputs.write("exit\n")
            count += 1
        outfile.write("rm *.dot")

      

if __name__ == '__main__':
    if len(sys.argv) == 1:
        print('Execute command python3 graph_extract.py [inputLogPath] [hostNamespace] [containerNamespace]')
        sys.exit()

    privilegeFlowFile = "output.json"
    extractedFile = "filtered.json"
    crossNamespaceFile = "cross-namespaces.json"
    hostNamespace = sys.argv[2]
    containerNamespace = sys.argv[3]
    currentDirectory = os.getcwd()
    inputLogPath = sys.argv[1]


    getPrivilegedFlows(crossNamespaceFile, hostNamespace, containerNamespace, privilegeFlowFile)
    generateBinary(privilegeFlowFile, "cve.sh", "SPADE-queries", inputLogPath, currentDirectory)
