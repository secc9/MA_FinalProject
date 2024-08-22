


//-------

// detector w recorder taken from redFrik udk 

s.boot

~buffer=Buffer.alloc(s, 44100*3); //make a single 3 second buffer



(
Ndef(\automaticRecorder, {|thresh= 0.09, time= 0.2, amp= 0.05|
    var src= SoundIn.ar*amp;
    //var src= BPF.ar(SoundIn.ar*amp, 150, 1); //variant with bandpass filter
    var off= DetectSilence.ar(src, thresh, time);
    var on= 1-off;		//invert
    on.poll;
    RecordBuf.ar(src, ~buffer, loop:0, trigger: on);
}).play;
)
~buffer.play;  //turn up the volume and trigger manually once in a while
//you should be able to record the recorded sound over and over


~buffer2= Buffer.alloc(s, 44100*3);  //make a single three seconds long buffer

//detector with recorder and playback
(
Ndef(\automaticRecorder2, {|thresh= 0.5, time= 0.2, amp= 1, rate= 1|
    var src= SoundIn.ar*amp;
    //var src= BPF.ar(SoundIn.ar*amp, 150, 1); //variant with bandpass filter
    var off= DetectSilence.ar(src, thresh, time);
    var on= 1-off;      //invert
    on.poll;
    RecordBuf.ar(src, ~buffer2, loop:0, trigger: on);
    PlayBuf.ar(1, ~buffer2, rate, loop: 1).dup;
}).play;

)


```supercollider
~buffer3= Buffer.alloc(s, 44100*3);  //make a single three seconds long buffer

//detector used to fill up a buffer
//only records when there is any should present
(
Ndef(\automaticRecorder3, {|thresh= 0.09, time= 0.2, amp= 0.2|
    var src= SoundIn.ar*amp;
    //var src= BPF.ar(SoundIn.ar*amp, 150, 1); //variant with bandpass filter
    var off= DetectSilence.ar(src, thresh, time);
    var on= 1-off;      //invert
    on.poll;
    RecordBuf.ar(src, ~buffer3, loop:1, run: on);  //here we only record when sound detected
}).play;
)

~buffer3.play;  //trigger multiple times

Ndef(\automaticRecorder3).gui;

Ndef(\automaticRecorder3).stop;
Ndef(\automaticRecorder3).clear;


```supercollider
~buffer4= Buffer.alloc(s, 44100*3);  //make a single three seconds long buffer

//same as v3 but with playback
(
Ndef(\automaticRecorder4, {|thresh= 0.09, time= 0.2, amp= 1, rate= 1|
    var src= SoundIn.ar*amp;
    //var src= BPF.ar(SoundIn.ar*amp, 150, 1); //variant with bandpass filter
    var off= DetectSilence.ar(src, thresh, time);
    var on= 1-off;      //invert
    on.poll;
    RecordBuf.ar(src, ~buffer4, loop:1, run: on);  //here we only record when sound detected
    PlayBuf.ar(1, ~buffer4, rate, loop:1).dup;
}).play;
)


Ndef(\automaticRecorder4).stop;
Ndef(\automaticRecorder4).clear;