#!/bin/bash
#Zahra Yousefi - 9531086
#OS Lab

register() 
{
	usr=$1
	pass=$2
	cd Data
	if [ $(ls | grep Data.txt) = "Data.txt" ] 
	then 
		echo "$usr $pass" >> Data.txt
	else
		touch Data.txt
		echo "$usr $pass" >> Data.txt
	fi	
	mkdir "$usr" 
	cd "$usr"
}

#######################################################################

log() 
{
	usr=$1
	pass=$2
	cd Data
	search=$(cat Data.txt | grep "$usr $pass")
	if [ "$search" = "$usr $pass" ]
	then
		echo "Access granted!"
		cd "$usr"
		while true
		do		
			usrCommands "$usr" "$pass"
		done	
	else
		echo "Wrong username or password!"
	fi		
}

#######################################################################

usrCommands() 
{
	echo "commands user can give:
	> 1. maked [FILENAME] --> make directory
	> 2. makef [FILENAME] --> make file
 	> 3. writef [FILENAME] --> user starts to type in the given file till he enters the endwriting command	
 	> 4. open [FILENAME] --> show the contents of the given file
	> 5. list --> similar to ls
	> 6. math [OPERATOR] [OPERAND1] [OPERAND2] --> obvious isn't it?1
 	> 7. retrieve [WORD] --> find all files conraining the given word 
 	> 8. exit --> again! obvious!"
	
	read cmd
	cmd1=$(echo ${cmd} | cut -d" " -f1)
	cmd2=$(echo ${cmd} | cut -d" " -f2)
	cmd3=$(echo ${cmd} | cut -d" " -f3)
	cmd4=$(echo ${cmd} | cut -d" " -f4)
	#echo $cmd1
	#echo $cmd2
	#echo $cmd3	
	#echo $cmd4

	case $cmd1 in
		maked )
			#make directory
			makeDir "$cmd2"	
			;;
		makef )
			#make file
			makeFile "$cmd2"
			;;
		writef )
			#write to file
			writeFile "$cmd2"
			;;
		open )
			#show contents of a file
			openFile "$cmd2"			
			;;
		list )
			#list files in the walking directory
			list
			;;
		math )
			#MATH!
			math "$cmd2" "$cmd3" "$cmd4"
			;;
		retrieve )
			#search word through files
			grep -Zlr "\<$cmd2\>" * | xargs -0 wc -l			
			;;
		end )
			#exit
			exit
			;;
	esac
}

#######################################################################

math() {
	operator=$1
	operand1=$2
	operand2=$3
	answer=0
	echo $operator
	echo $operand1
	echo $operand2
	
	case $operator in
	+ )
		answer=$(expr "$operand1" + "$operand2")
		;;
	- )
		answer=$(expr "$operand1" - "$operand2")
		;;
	* )
		answer=$(expr "$operand1" * "$operand2")
		;;
	/ )
		answer=$(perl -e "print $operand1/$operand2")
		;;
	esac
	echo $answer
}

#######################################################################

list() {

	for i in * 
	do 
		
		echo $i;
	done
}

#######################################################################

makeDir()
{
	echo "Creating Directory..."	
	dirName=$1
	mkdir "$1"
	echo "Directory created!"	
	ls

}

#######################################################################

makeFile() 
{
	echo "Creating file..."
	fileName=$1
	touch "$1"
	echo "File created!"
	ls

}
	
#######################################################################

writeFile() 
{

	if [ $(ls | grep "$1") = "$1" ]
	then
		#writeToFile
		echo "To stop appending to your file, enter the word *end*"
		read input
		while [ "$input" != "end" ]
		do
			echo "$input" >> $1
			read input
		done
	else
		echo "file does not exist!"
	fi
}

#######################################################################

openFile() 
{
	if [ $(ls | grep "$1") = "$1" ]
	then
		#openFile
		echo "Contents of your file:"		
		cat $1
	else
		echo "file does not exist!"
	fi	
}
#######################################################################

start() 
{
	echo "Welcome!"
	echo "If you're a first-time user press R to register"
	echo "Else if you want to login to your account press L"
	read userCmd
	
	if [ "$userCmd" = "R" ] || [ "$userCmd" = "r" ] 
	then
		echo "Please set up your username:"
		read newUsername
		echo "Now please set up your password:"
		read newPass
		register "$newUsername" "$newPass"

	elif [ "$userCmd" = "L" ] || [ "$userCmd" = "l" ]
	then
		echo "Username:"
		read username
		echo "Password:"
		read pass
		log "$username" "$pass"
	fi
}


start
