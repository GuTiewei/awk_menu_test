#awk解析test_cmd文件中的格式命令
#awk -f menu_cmd.awk -v file=test_cmd
BEGIN{
	FS = ":"
	
	if((getline < file) > 0)
		title = $1
	else {
		print "unknown file: " file
		exit
	} 
	size  = 0
	while((getline < file) > 0){
		size ++
		menu[size] = $1
		cmd[size] = $2
	}
	close(file)
	list_menu()
	
}

{
	if($1 >=1 && $1 <= size) {
		system(cmd[$1])
		printf("enter num to execute: ")
		
	} else if($1 == 0) {
		list_menu()	
	} else {
		exit
	}
}

function list_menu() {
	
	system("clear")	

	print title
	printf("%d.\t%-s\n", 0, "帮助")
	for(i = 1; i <= size; i++){
		printf ("%d.\t%-s\n", i, menu[i])
	}
	printf("%d.\t%-s\n", i, "exit.")
	printf("enter num to execute : ")
}
