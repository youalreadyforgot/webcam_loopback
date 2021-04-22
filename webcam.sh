#!/bin/bash


grab_desktop()
{
	read -p "framerate:" framerate
       	read -p "resolution(ex:1280x720):" resolution
		
	#ffmpeg -f x11grab -framerate $framerate -video_size $resolution -i :0.0+0,0 -f v4l2 /dev/video0
}
cleanup()
{
	kill -s SIGTERM $!
	exit 0
}

run_loop()
{
	
		read -p "Enter the path of the video file:" path
		read -p "Loop video?:y/n" answer

		if [ $answer == "y" ] 
		then
			while [ 1 ]
				do
				ffmpeg -re -i $path -f v4l2 /dev/video0 
				done
		elif [$answer == "n"]
			then ffmpeg -re -i $path -f v4l2 /dev/video0
		fi
}


read  -p"1: Grab desktop `echo $'\n'` 2: Load video file:" choice

trap cleanup SIGINT SIGTERM

case $choice in
	1)
		grab_desktop
		;;
	2)
		run_loop
		;;
esac

