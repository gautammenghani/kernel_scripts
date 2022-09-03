#!/usr/bin/env python3 

'''
This script makes it easy to write the format-patch command that can involve multiple maintainers and mailing list

Usage:
    getmaintainers.py <commit_id> <file>
'''
import sys
import subprocess as sp

maintainers=""
kernel_path="/opt/linux-stable/"
if len(sys.argv)!=3:
    print("Usage : getmaintainers.py <commit_id> <file_name>")
    exit(0)

commit_id, file_name = sys.argv[1],sys.argv[2]
output = sp.run(["scripts/get_maintainer.pl", file_name], capture_output=True)
maintainers = output.stdout.decode("utf-8")
print(maintainers)

res=""
maintainers = maintainers.split("\n")
for maintainer in maintainers:
    if maintainer=="":
        continue
    row=maintainer.split("(")
    if "supporter" in row[1].lower():
        res+=f" --to={row[0].strip().split()[-1].lstrip('<').rstrip('>')}"
    elif "maintainer" in row[1].lower():
        res+=f" --to={row[0].strip().split()[-1].lstrip('<').rstrip('>')}"
    else:
        res+=f" --cc={row[0].strip().split()[-1].lstrip('<').rstrip('>')}"

initial_str = f"git format-patch -1 {commit_id}"
print(initial_str + res)

