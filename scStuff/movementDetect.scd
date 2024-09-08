
//supercollider code for total movement
s.boot;
s.latency= 0.05;
(
Ndef(\snd, {|freq= 500, amp= 0|
    BLowPass4.ar(WhiteNoise.ar(amp), freq.lag, 0.5).dup;
}).play;
OSCdef(\total, {|msg|
    var t= msg[1];
    //msg.postln;  //debug
    Ndef(\snd).set(\amp, (t/1000).clip(0, 1), \freq, t.linexp(0, 125000, 200, 2000));
}, \total);
)