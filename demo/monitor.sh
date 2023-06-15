while true
	do 
		watch -g  "ls -lR src/ ../src/ | sha256sum" && sauer make && notify-send --hint int:transient:1 "sauer make" Success
		sleep 1
	done

