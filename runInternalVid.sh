#!/bin/bash

# pixelize
  #  ffplay -probesize 500000 -fflags nobuffer -flags low_delay -framedrop -protocol_whitelist "file,udp,rtp" -vf "pixelize=w=20:h=20:mode=max" udp://127.0.0.1:5000


ffplay \
    udp://127.0.0.1:5000 \
    -fs \
    -probesize 5000000 \
    -fflags nobuffer \
    -flags low_delay \
    -framedrop \
    -protocol_whitelist "file,udp,rtp" \
    -vf "shuffleframes=11 0 0 0 0 0 0 0 0 0 0 0,stereo3d=in=sbs2r:out=icl,amplify=radius=10:factor=16:threshold=1,blockdetect=period_min=6:period_max=10:planes=1" \
    
   
    
