#!/bin/bash

# pixelize
  #  ffplay -probesize 500000 -fflags nobuffer -flags low_delay -framedrop -protocol_whitelist "file,udp,rtp" -vf "pixelize=w=20:h=20:mode=max" udp://127.0.0.1:5000


ffplay \
     udp://127.0.0.1:5000 \
    -probesize 5000000 \
    -fflags nobuffer \
    -flags low_delay \
    -framedrop \
    -protocol_whitelist "file,udp,rtp" \
    -vf "shuffleframes= 0 2 1,stereo3d=in=sbs2r:out=chl,amplify=radius=10:factor=8:threshold=200,blockdetect=period_min=3:period_max=10:planes=1" 

#    -vf "libplacebo=w=iw*2:h=ih*2:extra_opts='upscaler=custom\:upscaler_preset=ewa_lanczos\:upscaler_blur=0.9812505644269356'"


