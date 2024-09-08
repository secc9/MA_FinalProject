s.boot;

(
//tezt
OSCdef(\flow, {|msg| msg.postln}, \flow);
)

//sound
(
s.waitForBoot{
Ndef(\snd, {|x=0, y=0| SinOsc.ar([x, y].lag(0.05)*999, 0, [x, y].lag(0.1)/3)}).play;
OSCdef(\flow, {|msg| Ndef(\snd).set(\x, msg[1], \y, msg[2])}, \flow);
};
)

//trigger
(
s.waitForBoot{
	var syn = SynthDef(\ping, {|t_trig=0, x=0, y=0|
	var env = EnvGen.ar(Env.perc(0.001, 2), t_trig);
	var snd = SinOsc.ar(x*100+400);
	Out.ar(0, Pan2.ar(snd*env, y.poll));
}).play;
OSCdef(\flow, {|msg|
	      var x = msg[1];
	      var y = msg[2];
	      if(x.abs>1 or:{y.abs>1}, {
	      		 syn.set(\t_trig, 1, \x, x, \y, y);
			 });
		}, \flow);
};
)