#this is my supercool filter of fun


# first up take video from the internal cam
# make 2 directories called vid_frames and outputs
mkdir s06

# get imagesnap to take 100 images at 30fps
rpicam-vid -t 10s  --width 1280 --height 720 --vflip --brightness 0.3 -o s06/vid1.mp4

## next up lets add some filter
ffmpeg -i s06/vid1.mp4 -vf "hue=h=54:s=10:b=-4,pixelize=w=60:h=60:m=max:p=2" s06/vid2.mp4

# now do the grid layout
# gridded image
ffmpeg -i  s06/vid2.mp4 -vf "crop=iw/2:ih/2:0:0" s06/crop-0.mp4      #top-left
ffmpeg -i  s06/vid2.mp4 -vf "crop=iw/2:ih/2:iw/2:0" s06/crop-1.mp4  #top-right
ffmpeg -i  s06/vid2.mp4 -vf "crop=iw/2:ih/2:0:ih/2" s06/crop-2.mp4     #bottom-left
ffmpeg -i  s06/vid2.mp4 -vf "crop=iw/2:ih/2:iw/2:ih/2" s06/crop-3.mp4     #bottom-right

#rotate mp4
ffmpeg  -i s06/crop-0.mp4 -vf "transpose=1, transpose=1" s06/crop-0-rotate.mp4 -y
ffmpeg  -i s06/crop-1.mp4 -vf "transpose=0, transpose=1" s06/crop-1-rotate.mp4 -y
ffmpeg  -i s06/crop-2.mp4 -vf "transpose=1, transpose=0" s06/crop-2-rotate.mp4 -y


#build gridded image
ffmpeg -i s06/crop-0-rotate.mp4 -i s06/crop-1-rotate.mp4 -i s06/crop-2-rotate.mp4 -i s06/crop-3.mp4 \
       -filter_complex \
       "[2:v][0:v]hstack=inputs=2[top];\
	[3:v][1:v]hstack=inputs=2[bottom];\
	[top][bottom]vstack=inputs=2[v]"\
       -map "[v]" \
      s06/grid-2x2.mp4




#play the file

ffplay -i s06/grid-2x2.mp4 -fs -autoexit

# remove the unused mmp4's

rm -rf s06

