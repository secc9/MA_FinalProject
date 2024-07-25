#!/bin/bash

# pixelize
  #  ffplay -probesize 500000 -fflags nobuffer -flags low_delay -framedrop -protocol_whitelist "file,udp,rtp" -vf "pixelize=w=20:h=20:mode=max" udp://127.0.0.1:5000


  ffplay -probesize 500000 -fflags nobuffer -flags low_delay -framedrop -protocol_whitelist "file,udp,rtp" -vf "pixelize=w=20:h=20:mode=max" udp://127.0.0.1:5000
