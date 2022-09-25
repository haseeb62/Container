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

def extractFeatures(input_file, output_file):
    final_output = []
    with open(input_file) as f:
        inode_l = []
        for line in f:
            temp = json.loads(line)
            if(temp["artifact"]["subtype"] == "file"):
                output = {}
                inode = temp["artifact"]["inode"]
                output["inode"] = inode
                if inode not in inode_l:
                    inode_l.append(inode)
                reader = {"pid": temp["reader"]["pid"], "start time": temp["reader"]["start time"]}
                output["reader"] = reader
                writer_l = []
                for writer in temp["writers"]:
                    writer_l.append({"pid": writer["pid"], "start time": writer["start time"]})
                output["writers"] = writer_l
                final_output.append(output)
        print(len(inode_l), inode_l)

    with open(output_file, "w") as outfile:
        for out in final_output:
            outfile.write(json.dumps(out)+'\n')


def generateBinary(input_file, output_file, query_file, inputLog_path):
    with open("inputs", "w") as inputs:
        inputs.write("load /home/vagrant/" + query_file + '\n')
        inputs.write("list\n")
        inputs.write("exit\n")

    with open(output_file, "w") as outfile:
        outfile.write("#!/bin/bash\n")
        outfile.write("#cd ~\n")
        outfile.write("cd SPADE/bin\n")
        outfile.write("./spade start\n")
        outfile.write("sleep 1\n")
        outfile.write('echo -e "add analyzer CommandLine\nadd storage PostgreSQL\nadd reporter Audit inputLog='+inputLog_path+'\n\nremove reporter Audit\nremove storage PostgreSQL\nadd storage PostgreSQL\nset storage PostgreSQL\nexit" | ./spade control\n')
        #Loops
        with open(input_file) as inputfile:
            flow_count = 1
            for line in inputfile:
                flow = json.loads(line)
                with open(query_file, "w") as qfile:
                    qfile.write('%artifact = "inode" == \'' + flow["inode"] + '\'\n')
                    qfile.write('$artifact = $base.getVertex(%artifact)' + '\n')
                    qfile.write('%reader = "pid" == \'' + flow["reader"]["pid"] + '\' and "start time" == \'' + flow["reader"]["start time"] + '\'\n')
                    qfile.write('$reader = $base.getVertex(%reader)' + '\n')
                    writer_count = 1
                    final_query = '$path = $base.getPath($reader, $artifact, 1)'
                    for writer in flow["writers"]:
                        qfile.write('%writer'+ str(writer_count) + ' = "pid" == \'' + writer["pid"] + '\' and "start time" == \'' + writer["start time"] + '\'\n')
                        qfile.write('$writer' + str(writer_count) + ' = $base.getVertex(%writer' + str(writer_count) + ')\n')
                        final_query += ' + $base.getPath($artifact, $writer' + str(writer_count) + ', 1)'
                        writer_count += 1
                    qfile.write(final_query + '\n')
                    qfile.write('export > /tmp/14271_' + str(flow_count) + '.dot\n')
                    qfile.write('dump all $path\n')
                outfile.write("/home/vagrant/SPADE/bin/spade query < /home/vagrant/inputs\n")
                flow_count += 1
        #End loop
        outfile.write("./spade stop\n")
        outfile.write("truncate -s 0 ../cfg/spade.client.Control.config\n")
        outfile.write("./manage-postgres.sh clear\n")
        # outfile.write("cd ~")
        # outfile.write("cd /tmp")
        #Loop
        # outfile.write("dot -Tsvg -o 14271_1.svg 14271_1.dot")


      

if __name__ == '__main__':
    privilegeFlowFile = "output.json"
    extractedFile = "filtered.json"
    crossNamespaceFile = ""
    hostNamespace = ""
    containerNamespace = ""


    getPrivilegedFlows(crossNamespaceFile, hostNamespace, containerNamespace, privilegeFlowFile)
    extractFeatures(privilegeFlowFile, extractedFile)
    generateBinary(extractedFile, "cve.sh", "SPADE-queries", "/home/vagrant/Container/CVE_14271/cve_14271.log")
