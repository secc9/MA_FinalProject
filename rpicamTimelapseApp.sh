

#!/bin/bash


# I want this script to capture a short video from the camera and then process the video in ffmpeg and then show that video and I want the script to loop and do this every n seconds≥

# capture a 4 second video
#rpicam-vid -t 4000 --width 640 --height 480 --vflip 1  -o /home/ashleysagar/MA_FinalProject/vidCapture/test01.h264

# process the video
#ffmpeg -i /home/ashleysagar/MA_FinalProject/vidCapture/test01.h264 -vf "minterpolate=fps=20:mi_mode=dup" -o test01_1.mp4

#this script was generated in chatgpt with the following prompt
# https://chatgpt.com/share/6983a33b-d494-44ad-9b18-6afe7eb686ea
#can you help me with a command line script that make these lines of code run in sequence
#!/bin/bash
# I want this script to capture a short video from the camera and then process the video in ffmpeg and
#then show that video and I want the script to loop and do this every n seconds≥
# capture a 4 second video
#rpicam-vid -t 4000 --width 640 --height 480 --vflip 1  -o
#/home/ashleysagar/MA_FinalProject/vidCapture/test01.h264
# process the video
#ffmpeg -i /home/ashleysagar/MA_FinalProject/vidCapture/test01.h264 -vf "minterpolate=fps=20:mi_mode=dup"
#-o test01_1.mp4



# I have edited the fx and timings myself

#!/bin/bash

# Set the delay interval in seconds
n=1

# Directory to save the captured video
output_dir="/home/ashleysagar/MA_FinalProject/vidCapture"
# Capture duration in milliseconds
capture_duration=10000


#UDP address to send processed video
udp_address="udp://192.168.1.133:5000"

# Loop to capture, process, and display the video
while true; do
    # Generate a timestamp to use in file names
    timestamp=$(date +"%Y%m%d%H%M%S")
    
    # Capture a 5-second video
    rpicam-vid -t $capture_duration --width 640 --height 480 --vflip 1 -o ${output_dir}/test_${timestamp}.h264


    
    # Process the video with ffmpeg
    ffmpeg -i ${output_dir}/test_${timestamp}.h264 -vf "pixelize=width=10:height=10:mode=max,random=frames=130:seed=5,amplify=radius=20:factor=64:threshold=1000:tolerance=0:low=0:high=65535:planes=2" -y ${output_dir}/test_${timestamp}_processed.mp4
    
    # Show the processed video (replace 'mpv' with your preferred video player)
    ffplay -vf "stereo3d=in=sbs2r:out=icl,amplify=radius=10:factor=16:thr\
eshold=1,blockdetect=period_min=6:period_max=10:planes=1" -fs  -autoexit ${output_dir}/test_${timestamp}_processed.mp4

    #send the processed video to RPI5-1
    ffmpeg -re -i ${output_dir}/test_${timestamp}_processed.mp4 -f mpegts ${udp_address}


    
     # Delete the processed video after playback
    rm ${output_dir}/test_${timestamp}_processed.mp4
    
    # Optionally, delete the original h264 file as well
    rm ${output_dir}/test_${timestamp}.h264

   
    # Wait for 'n' seconds before repeating
    sleep $n
done
