#!/bin/bash
# a simple script to run my rpicam



# run rpicam-vid for 1hr
# basic setup for internal streaming in the same pi
rpicam-vid --inline -o udp://127.0.0.1:5000  -n --width 1024 --height 600  --timeout 3600000 --vflip 1

#capture frames
#rpicam-still --encoding png  --timeout 3600000 --vflip 1  -o /home/ashleysagar/MA_FinalProject/capturedImages/image%00009.png &



# rpicam-vid -t 10000 -n --codec libav --libav-format mpegts --libav-audio -o "udp://192.168.1.133:5000 listen=1" 





# run basic rpicam-vid from pi4 to rpi5-1 -> this works 
#rpicam-vid --inline -o udp://192.168.1.133:5000  --width 1024 height 600 --timeout 360000 --vflip 1 

# run basic rpicam-vid from pi4 to rpi5-1 -> this works 
#rpicam-vid --inline -o udp://192.168.1.137:5000 -n --width 1024 height 600 --timeout 360000 --vflip



#rpicam-vid --timeout 60000 --vflip 1 -o - | tee >(ffmpeg -re -i - -f mpegts udp://192.168.1.133:5000) | ffmpeg -re -i - -f mpegts udp://192.168.1.137:5000 







# chatgpt code for duplicating the stream and sending it to 2 streams
#rpicam-vid --inline --timeout 10000 -o - | tee >(ffmpeg -re -i - -f mpegts udp://127.0.0.1:5000) | ffmpeg -re -i - -f mpegts udp://192.168.1.133:1234





#pose estimation
#rpicam-vid --inline -o udp://127.0.0.1:5000 -n --width 1024 --height 600  --post-process-file /home/ashleysagar/rpicam-apps/assets/pose_estimation_tf.json --timeout 30000 --lores-width 258 --lores-height 258 --vflip 1




#ffplay udp://192.168.1.137:5000 -fflags nobuffer -flags low_delay -framedrop -vf "hue=s=0"
