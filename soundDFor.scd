

s.boot;
s.meter
(
a = {Pan2.ar(
	SinOsc.ar(
		LFNoise2.kr(0.32, 0.0123) +
		LFNoise0.kr(SinOsc.kr(0, 100), SinOsc.kr(1, 10000), 1), //sin osc freq
		SinOsc.kr(
			LFNoise2.kr(0.0125, 100,0.0), //sin osc phase
			0,
			100),
		0.1),
	SinOsc.kr(0.025), //pan position
	LFPulse.kr(0.75+0.24) //pan 2 lavel
)}.play
)
a.free
s.scope

(

//USE ME for show

b = {Pan2.ar(
	Mix(SinOsc.ar([SinOsc.kr(0.1234, 0, 100.42213,SinOsc.kr(0.0212, 0, 1, 300)),SinOsc.kr(SinOsc.kr(0.123, 1, 32, 102), 0.43,100.456, SinOsc.kr(10.12, 0, 12, 100))], //freq
		SinOsc.kr( // phase
			SinOsc.kr(SinOsc.kr(0.0124, 0, 0.003), 0, 100),//phase freq
			0,
			SinOsc.kr(SinOsc.kr(0.1234, 0, 10),0,1) //phase add
		),
		0.1)), //sinosc
	SinOsc.kr(LFNoise0.kr(0.125)), //pos
	LFNoise1.kr(SinOsc.kr(0.25, 0, 1, 1)), //level

)}.play;
)
~a = 1000;