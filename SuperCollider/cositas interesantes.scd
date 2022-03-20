s.meter
n=NetAddr("127.0.0.1",57120);
n=NetAddr("127.0.0.1",57140);
thisProcess.openUDPPort(8010); // attempt to open 1121
thisProcess.openPorts; // list all open ports
OSCFunc.trace(false);
Server.default.options.outDevice
Server.default.options.inDevice_("Built-in Microph");
Server.default.options.outDevice_("Built-in Output");
ServerOptions.devices; // all devices
ServerOptions.inDevices; // input devices
ServerOptions.outDevices; // output devices

/*
Fundamental
50, 100, 200,400, 800, 1600, 3200
Tercera
59.460, 118.92, 237.84, 475.69, 951.36, 1902.72, 3805.74
Quinta
74.916, 149.832, 299.664, 599.328, 1198.656, 2397.312, 4794.624
Septima
79.37, 158.74, 317.48, 634.96, 1269.92, 2539.84, 5079.68


47.194 (esto seria en la octava mas baja)
37.458 (esto seria en la octava mas baja)

~notasRed=[47.194,0,0,0,0,0,0,0,0];
*/


{ SinOsc.ar(200, 0, 0.5) }.play;

// modulate the frequency with an exponential ramp
{ SinOsc.ar(XLine.kr(200, 50), 0, 0.3) }.play;

// more complex frequency modulation
{ SinOsc.ar(SinOsc.ar(XLine.kr(1, 1000, 9), 0, 50, 100), 0, 0.25) }.play;

// phase modulation (see also PMOsc)
{ SinOsc.ar(800, SinOsc.ar(XLine.kr(1, 1000, 9), 0, 2pi), 0.25) }.play;





(
Ndef(\diegoRed,{
	arg f1=400, f2=1000, f3=200,a1=1,a2=1, a3=1, ampg=0.3;
	var sig;
	//sig=SinOsc.ar([f1,f1+1,f2,f2+3, f3],[a1,a2,a3]);
	sig=SinOsc.ar(XLine.kr(f1, 50), 0, 0.3)
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	//sig=FreeVerb.ar(sig,SinOsc.kr(1).range(1.7));
	sig=sig*ampg;
}).play;
)




Ndef(\diegoGreen,(
	arg f1=0, f2=0, f3=0,a1=0.3,a2=0.2, a3=0.1, ampg=0.2;
	var sig;
	sig=SinOsc.ar([f1,f1+1,f2,f2+3,f3],[a11,a2,a3]);
	sig=FreeVerb.ar(sig,SinOsc.kr(4).range(1.7));
	sig=sig*ampg;
}).play;
}


(
Ndef(\diegoBlue,(
	arg f1=0, f2=0, f3=0,a1=0.3,a2=0.2, a3=0.1, ampg=0.2;
	var sig;
	sig=SinOsc.ar([f1,f1+1,f2,f2+3,f3],[a11,a2,a3]);
	sig=FreeVerb.ar(sig,SinOsc.kr(4).reange(1.7));
	sig=sig*ampg;
}).play;
)

(
Ndef(\diegoWave,{
	arg ampg=0.4, f1=4, f2=2, f3=4, a1=0.1, a2=0.01,a3=0.01;
	var sig;
	sig=SinOsc.ar([f1,f1+1,f2,f2+3,f3],[a1,a2,a3]);
	sig=FreeVerb.ar(sig,SinOsc.kr(2).range(6,7));
	sig+sig*ampg;
}).play;
)




(
SynthDef(\grain, { |out=0, freqA=50,freqB=50, amp=0.2|
    OffsetOut.ar(out, Saw.ar(XLine.kr(freqA, freqB)) * EnvGen.kr(Env.perc, doneAction: Done.freeSelf) * amp)
}).add;
)

s=Synth(\grain);

SynthDef(\grain).set(\gate,0);