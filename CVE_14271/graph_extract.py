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
    flow_count = 1
    with open(output_file, "w") as outfile:
        outfile.write("#!/bin/bash\n")
        outfile.write("cd ~\n")
        outfile.write("cd SPADE/bin\n")
        outfile.write("./spade start\n")
        outfile.write("sleep 1\n")
        outfile.write('echo -e "add analyzer CommandLine\nadd storage PostgreSQL\nadd reporter Audit inputLog='+inputLog_path+'\n\nremove reporter Audit\nremove storage PostgreSQL\nadd storage PostgreSQL\nset storage PostgreSQL\nexit" | ./spade control\n')
        #Loops
        with open(input_file) as inputfile:
            
            for line in inputfile:
                flow = json.loads(line)
                with open(query_file + str(flow_count), "w") as qfile:
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
                outfile.write("/home/vagrant/SPADE/bin/spade query < /home/vagrant/Container/CVE_14271/inputs" + str(flow_count) + "\n")
                flow_count += 1
        #End loop
        outfile.write("./spade stop\n")
        outfile.write("truncate -s 0 ../cfg/spade.client.Control.config\n")
        outfile.write("./manage-postgres.sh clear\n")
        outfile.write("cd ~/Container/CVE_14271\n")
        outfile.write("rm output.json\n")
        outfile.write("rm filtered.json\n")
        outfile.write("rm input*\n")
        outfile.write("rm SPADE-q*\n")
        outfile.write("cd ~\n")
        outfile.write("cd /tmp\n")
        #Loop
        count = 1
        while count < flow_count:
            outfile.write("dot -Tsvg -o ~/Container/CVE_14271/14271_" + str(count) + ".svg 14271_"+ str(count) +".dot\n")
            with open("inputs" + str(count), "w") as inputs:
                inputs.write("load /home/vagrant/Container/CVE_14271/" + query_file + str(count) + '\n')
                inputs.write("list\n")
                inputs.write("exit\n")
            count += 1
        outfile.write("rm 14271_*")

      

if __name__ == '__main__':
    privilegeFlowFile = "output.json"
    extractedFile = "filtered.json"
    crossNamespaceFile = "cross-namespaces.json"
    hostNamespace = "4026531836"
    containerNamespace = "4026532196"


    getPrivilegedFlows(crossNamespaceFile, hostNamespace, containerNamespace, privilegeFlowFile)
    extractFeatures(privilegeFlowFile, extractedFile)
    generateBinary(extractedFile, "cve.sh", "SPADE-queries", "/home/vagrant/Container/CVE_14271/cve_14271.log")
