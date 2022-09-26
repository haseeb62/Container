import json
import sys

# Convert JSON into List
with open(sys.argv[3]) as f:
    for line in f:
        temp = json.loads(line)
        if temp["reader"]["pid namespace"] == sys.argv[1]:
            for i in temp["writers"]:
                if i["pid namespace"] == sys.argv[2]:    
                    with open("output.json", "a") as outfile:
                            outfile.write(json.dumps(temp)+'\n')


