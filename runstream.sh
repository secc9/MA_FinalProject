

#!/bin/bash


rpicam-vid --inline -o "tee:udp://127.0.0.1:5000|udp://192.168.1.133:5000" -n --width 1024 --height 600 --timeout 3600000 --vflip 1
