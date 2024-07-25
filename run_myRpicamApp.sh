#!/bin/bash
# a simple script to run my rpicam

# run app
rpicam-vid --inline -o udp://127.0.0.1:5000 -n --width 1024 --height 600  --post-process-file /home/ashleysagar/rpicam-apps/assets/pose_estimation_tf.json --timeout 60000 --lores-width 258 --lores-height 258 


#ffplay udp://192.168.1.137:5000 -fflags nobuffer -flags low_delay -framedrop -vf "hue=s=0"
