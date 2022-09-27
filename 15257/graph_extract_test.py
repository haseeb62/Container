import json

def getPrivilegedFlows(crossNamespaceFile, hostNamespace, containerNamespace, outputFile):
    with open(crossNamespaceFile) as f:
        for line in f:
            temp = json.loads(line)
            if temp["reader"]["pid namespace"] == hostNamespace:
                for i in temp["writers"]:
                    if i["pid namespace"] == containerNamespace:    
                        with open(outputFile, "a") as outfile:
                                outfile.write(json.dumps(temp)+'\n')


# def extractFeatures(input_file, output_file):
#     final_output = []
#     with open(input_file) as f:
#         inode_l = []
#         for line in f:
#             temp = json.loads(line)
#             if(temp["artifact"]["subtype"] == "file"):
#                 output = {}
#                 inode = temp["artifact"]["inode"]
#                 output["inode"] = inode
#                 if inode not in inode_l:
#                     inode_l.append(inode)
#                 reader = {"pid": temp["reader"]["pid"], "start time": temp["reader"]["start time"]}
#                 output["reader"] = reader
#                 writer_l = []
#                 for writer in temp["writers"]:
#                     writer_l.append({"pid": writer["pid"], "start time": writer["start time"]})
#                 output["writers"] = writer_l
#                 final_output.append(output)
#         print(len(inode_l), inode_l)

#     with open(output_file, "w") as outfile:
#         for out in final_output:
#             outfile.write(json.dumps(out)+'\n')

def makeConstraint(input, type):
    constraint = '%{key} = '.format(key = type)
    count = 0
    for key, value in input.items():
        if count == 0:
            constraint += '"{k}" == \'{v}\' '.format(k = key, v = value)
        else:
            constraint += 'and "{k}" == \'{v}\' '.format(k = key, v = value)
        count += 1
    return constraint + '\n'



def generateBinary(input_file, output_file, query_file, inputLog_path):
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
                    qfile.write(makeConstraint(flow["artifact"], 'artifact'))
                    qfile.write('$artifact = $base.getVertex(%artifact)' + '\n')
                    qfile.write(makeConstraint(flow["reader"], 'reader'))
                    qfile.write('$reader = $base.getVertex(%reader)\n')
                    writer_count = 1
                    final_query = '$path = $base.getPath($reader, $artifact, 1)'
                    for writer in flow["writers"]:
                        qfile.write(makeConstraint(writer, 'writer{num}'.format(num = str(writer_count))))
                        qfile.write('$writer{num} = $base.getVertex(%writer{num})\n'.format(num = str(writer_count)))
                        final_query += ' + $base.getPath($artifact, $writer{num}, 1)'.format(num = str(writer_count))
                        writer_count += 1
                    qfile.write(final_query + '\n')
                    qfile.write('export > /tmp/15257_{f_count}.dot\n'.format(f_count = flow_count))
                    qfile.write('dump all $path\n')
                outfile.write("/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/15257/inputs{f_count}\n".format(f_count = flow_count))
                flow_count += 1
        #End loop
        outfile.write("./spade stop\n")
        outfile.write("truncate -s 0 ../cfg/spade.client.Control.config\n")
        outfile.write("./manage-postgres.sh clear\n")
        outfile.write("cd ~/Container/15257\n")
        outfile.write("rm output.json\n")
        outfile.write("rm filtered.json\n")
        outfile.write("rm input*\n")
        outfile.write("rm SPADE-q*\n")
        outfile.write("cd ~\n")
        outfile.write("cd /tmp\n")
        #Loop
        count = 1
        while count < flow_count:
            outfile.write("dot -Tsvg -o ~/Container/15257/15257_" + str(count) + ".svg 15257_"+ str(count) +".dot\n")
            with open("inputs" + str(count), "w") as inputs:
                inputs.write("load /home/vagrant/Container/15257/" + query_file + str(count) + '\n')
                inputs.write("list\n")
                inputs.write("exit\n")
            count += 1
        outfile.write("rm 15257_*")

      

if __name__ == '__main__':
    privilegeFlowFile = "output.json"
    extractedFile = "filtered.json"
    crossNamespaceFile = "cross-namespaces.json"
    hostNamespace = "4026531836"
    containerNamespace = "4026532194"


    getPrivilegedFlows(crossNamespaceFile, hostNamespace, containerNamespace, privilegeFlowFile)
    # extractFeatures(privilegeFlowFile, extractedFile)
    generateBinary(privilegeFlowFile, "cve.sh", "SPADE-queries", "/home/vagrant/15257/15257_audit.log")
