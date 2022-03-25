Ndef(\noiseWave).set(\ampg,0.3);
Ndef(\noiseWave).set(\gate,1);



~revTime=0.2;

~harmonics=1;

~fadeTime=1;

~ampli=0.1;
~ampli=0.3;
~ampli=0.4;
~ampli=0.6;

//ROJO
(
Ndef(\r0).set(\harmonics,~harmonics);
Ndef(\r1).set(\harmonics,~harmonics);
Ndef(\r2).set(\harmonics,~harmonics);
Ndef(\r3).set(\harmonics,~harmonics);
Ndef(\r4).set(\harmonics,~harmonics);
Ndef(\r5).set(\harmonics,~harmonics);
Ndef(\r6).set(\harmonics,~harmonics);
Ndef(\r7).set(\harmonics,~harmonics);
Ndef(\r8).set(\harmonics,~harmonics);
Ndef(\r9).set(\harmonics,~harmonics);
)



//VERDE
(
Ndef(\g0).set(\harmonics,~harmonics);
Ndef(\g1).set(\harmonics,~harmonics);
Ndef(\g2).set(\harmonics,~harmonics);
Ndef(\g3).set(\harmonics,~harmonics);
Ndef(\g4).set(\harmonics,~harmonics);
Ndef(\g5).set(\harmonics,~harmonics);
Ndef(\g6).set(\harmonics,~harmonics);
Ndef(\g7).set(\harmonics,~harmonics);
Ndef(\g8).set(\harmonics,~harmonics);
Ndef(\g9).set(\harmonics,~harmonics);
)


//AZUL


(
Ndef(\b0).set(\harmonics,~harmonics);
Ndef(\b1).set(\harmonics,~harmonics);
Ndef(\b2).set(\harmonics,~harmonics);
Ndef(\b3).set(\harmonics,~harmonics);
Ndef(\b4).set(\harmonics,~harmonics);
Ndef(\b5).set(\harmonics,~harmonics);
Ndef(\b6).set(\harmonics,~harmonics);
Ndef(\b7).set(\harmonics,~harmonics);
Ndef(\b8).set(\harmonics,~harmonics);
Ndef(\b9).set(\harmonics,~harmonics);
)

////////////////////////////////////////////


(
Ndef(\r0).fadeTime=~fadeTime;
Ndef(\r1).fadeTime=~fadeTime;
Ndef(\r2).fadeTime=~fadeTime;
Ndef(\r3).fadeTime=~fadeTime;
Ndef(\r4).fadeTime=~fadeTime;
Ndef(\r5).fadeTime=~fadeTime;
Ndef(\r6).fadeTime=~fadeTime;
Ndef(\r7).fadeTime=~fadeTime;
Ndef(\r8).fadeTime=~fadeTime;
Ndef(\r9).fadeTime=~fadeTime;
Ndef(\r0).fadeTime=~fadeTime;

Ndef(\g0).fadeTime=~fadeTime;
Ndef(\g1).fadeTime=~fadeTime;
Ndef(\g2).fadeTime=~fadeTime;
Ndef(\g3).fadeTime=~fadeTime;
Ndef(\g4).fadeTime=~fadeTime;
Ndef(\g5).fadeTime=~fadeTime;
Ndef(\g6).fadeTime=~fadeTime;
Ndef(\g7).fadeTime=~fadeTime;
Ndef(\g8).fadeTime=~fadeTime;
Ndef(\g9).fadeTime=~fadeTime;
Ndef(\g0).fadeTime=~fadeTime;

Ndef(\b0).fadeTime=~fadeTime;
Ndef(\b1).fadeTime=~fadeTime;
Ndef(\b2).fadeTime=~fadeTime;
Ndef(\b3).fadeTime=~fadeTime;
Ndef(\b4).fadeTime=~fadeTime;
Ndef(\b5).fadeTime=~fadeTime;
Ndef(\b6).fadeTime=~fadeTime;
Ndef(\b7).fadeTime=~fadeTime;
Ndef(\b8).fadeTime=~fadeTime;
Ndef(\b9).fadeTime=~fadeTime;
Ndef(\b0).fadeTime=~fadeTime;
)


(
Ndef(\r0).set(\ampg,~ampli);
Ndef(\r1).set(\ampg,~ampli);
Ndef(\r2).set(\ampg,~ampli);
Ndef(\r3).set(\ampg,~ampli);
Ndef(\r4).set(\ampg,~ampli);
Ndef(\r5).set(\ampg,~ampli);
Ndef(\r6).set(\ampg,~ampli);
Ndef(\r7).set(\ampg,~ampli);
Ndef(\r8).set(\ampg,~ampli);
Ndef(\r9).set(\ampg,~ampli);
)

(
Ndef(\g0).set(\ampg,~ampli);
Ndef(\g1).set(\ampg,~ampli);
Ndef(\g2).set(\ampg,~ampli);
Ndef(\g3).set(\ampg,~ampli);
Ndef(\g4).set(\ampg,~ampli);
Ndef(\g5).set(\ampg,~ampli);
Ndef(\g6).set(\ampg,~ampli);
Ndef(\g7).set(\ampg,~ampli);
Ndef(\g8).set(\ampg,~ampli);
Ndef(\g9).set(\ampg,~ampli);
)


(
Ndef(\b0).set(\ampg,~ampli);
Ndef(\b1).set(\ampg,~ampli);
Ndef(\b2).set(\ampg,~ampli);
Ndef(\b3).set(\ampg,~ampli);
Ndef(\b4).set(\ampg,~ampli);
Ndef(\b5).set(\ampg,~ampli);
Ndef(\b6).set(\ampg,~ampli);
Ndef(\b7).set(\ampg,~ampli);
Ndef(\b8).set(\ampg,~ampli);
Ndef(\b9).set(\ampg,~ampli);
)







(
Ndef(\b0,{
	arg f1=0,a1=1, harmonics=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=Saw.ar(f1,  1);
	sig=FreeVerb.ar(sig,SinOsc.kr(harmonics).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).play;

Ndef(\b1,{
	arg f1=0,a1=1, harmonics=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=Saw.ar(f1, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([harmonics,harmonics]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).play;



Ndef(\g2,{
	arg f1=0,a1=1, harmonics=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=Saw.ar([f1,f1], 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([harmonics,harmonics]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).play;

Ndef(\g3,{
	arg f1=0,a1=1, harmonics=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=Pulse.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([harmonics,harmonics]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).play;
Ndef(\g4,{
	arg f1=0,a1=1, harmonics=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=Pulse.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([harmonics,harmonics]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).play;

Ndef(\g5,{
	arg f1=0,a1=1, harmonics=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=Pulse.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([harmonics,harmonics]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).play;

Ndef(\g6,{
	arg f1=0,a1=1, harmonics=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=Pulse.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([harmonics,harmonics]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).play;

Ndef(\g8,{
	arg f1=0,a1=1, harmonics=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=Pulse.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([harmonics,harmonics]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).play;

Ndef(\g7,{
	arg f1=0,a1=1, harmonics=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=Pulse.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([harmonics,harmonics]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).play;

Ndef(\g9,{
	arg f1=0,a1=1, harmonics=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=Pulse.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([harmonics,harmonics]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).play;


)


