


def newlines():
	with open("\\path\\to\\file", "r+") as f:
		mylist = f.read()
		newlist = mylist.replace(",", "\n")
		print(newlist)
		file = "path\\newfile"
		with open(file, "w") as h:
			h.writelines(newlist)
		
newlines()