#/bin/bash


ffplay \
    udp://192.168.1.174:5000 \
    -fs \
    -probesize 5000000 \
    -fflags nobuffer \
    -flags low_delay \
    -framedrop \
    -protocol_whitelist "file,udp,rtp" \
