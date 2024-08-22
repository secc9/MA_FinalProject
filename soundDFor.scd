

s.boot;


a = {Pan2.ar(SinOsc.ar(LFNoise2.kr(1000.32, 0.0123), SinOsc.kr(LFNoise2.kr(0.125, 100,0.0), 0, 100),0.1),SinOsc.kr(0.25), LFPulse.kr(0.75+0.24))}.play

a.free