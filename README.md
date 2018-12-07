OS Lab Project
Deadline: 97/9/21

Create a simple shell that can do the following:

First if user has to press L for loging in or R for registering
After loging in user is directed to a directry named after themselves and they can only work there

Commands user can give:
1. maked [DIRECTORYNAME]
	Create a directory
2. makef [FILENAME]
	create a file
3. writef [FILENAME]
	Append to the given file
	Appending stops when user enters the "endwriting" command
4. open [FILENAME]
	Show the contents of the given file
	If the given file is a compressed file (.zip, .tar and etc) it's contents should be extracted and listed
5. list
	Similar to ls command in bash
	Should be implemented using for loop instead of ls command
6. math [OPERATOR] [OPERAND1] [OPERAND2]
	Obvious, isn't it?!
7. retrieve [WORD]
	Find all files containing the given word
8. exit
	Exit! :)

