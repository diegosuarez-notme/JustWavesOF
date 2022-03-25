//OTHER SYNTHS

(
Ndef(\noiseWave).fadeTime=15;
Ndef(\noiseWave,{
	arg ampg=0.2,freqC=1000,pan=0;
	var sig,sig2;
	sig=WhiteNoise.ar(ampg,0);
	sig=LPF.ar(sig,freqC);
	sig=Pan2.ar(sig,pan);
	//sig=Pan2.ar(LPF.ar(WhiteNoise.ar(0.1)), pan);
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*SinOsc.kr(0.1,0.6)*SinOsc.kr(0.073,0.4);
	//sig= FreeVerb.ar(sig,SinOsc.kr(1).range(0.6,0.7));
	//sig= DelayC.ar(sig,0.1,0.1,0.7,0);

}).playN
)
Ndef(\noiseWave).set(\gate,0);


//???????????????
//?????  ALL

//KICK

(
SynthDef(\kick,{
	arg freqA=800,freqB=40,freqC=140,freqDur1=0.006,freqDur2=0.3,freqC1=9,freqC2=(-1),atk=0.01,rel=1,c1=4,c2=(-12),amp=1,pan=(0),out=0;
	var sig,env,freqSweep;
	//freqSweep=EnvGen.ar(Env.new([freqA,freqB,freqC],[freqDur1,freqDur2],[freqC1,freqC2]),doneAction:2);
	freqSweep=Env([freqA,freqB,freqC],[freqDur1,freqDur2],[freqC1,freqC2]).ar;
	//env=Env([0,1,0],[atk,rel],[c1,c2],doneAction:2).kr(2);
	env=EnvGen.kr(Env.new([0,1,0],[atk,rel],[c1,c2]),doneAction:2);
	sig=Pan2.ar(Mix(SinOsc.ar(freqSweep,pi/2)),pan);
	sig=sig*env;

	//sig= FreeVerb.ar(sig,SinOsc.kr(1).range(0.6,0.7));
	//sig= DelayC.kr(sig,2,0.25,0.5,sig);
				Out.ar(out,sig);
			}).add;


k=Synth(\kick);



//CAJA


SynthDef(\caja,{
	arg freqA=2200,freqB=180,freqC=80,freqDur1=0.06,freqDur2=0.6,freqC1=9,freqC2=(-1),atk=0.001,rel=1.5,c1=4,c2=(-12),amp=0.5,pan=(0),out=0;
		var sig,env,freqSweep;
				freqSweep=Env([freqA,freqB,freqC],[freqDur1,freqDur2],[freqC1,freqC2]).ar;
				env=EnvGen.kr(Env.new([0,1,0],[atk,rel],[c1,c2]),doneAction:2);
	            sig=LPF.ar(WhiteNoise.ar(0.3),freqA);
				//sig=sig+SinOsc.ar(freqSweep,pi,0.2);
				sig=sig*env;
	           // sig= FreeVerb.ar(sig,SinOsc.kr(1).range(0.3,0.4));

				sig=Pan2.ar(sig, pan,amp);
	//sig= DelayC.ar(sig,2,0.9,0.1,sig);
				Out.ar(out,sig);
			}).add;


///CLAP

SynthDef(\clap,{
	arg freqA=4200,freqB=180,freqC=30,freqDur1=0.09,freqDur2=0.6,freqC1=9,freqC2=(-1),atk=0.001,rel=2,c1=4,c2=(-12),amp=0.5,pan=(0),out=0;
	var sig,env,freqSweep;
	freqSweep=Env([freqA,freqB,freqC],[freqDur1,freqDur2],[freqC1,freqC2]).ar;
	env=EnvGen.kr(Env([0,1,0],[atk,rel],[c1,c2]),doneAction:2);
	sig=LPF.ar(WhiteNoise.ar(0.3),freqA);
	// sig=sig+SinOsc.ar(freqSweep,pi/2);
	sig=sig*env;
	//sig= FreeVerb.ar(sig,SinOsc.kr(1).range(0.6,0.8));

	 sig=Pan2.ar(sig, pan,amp);
	sig= DelayC.ar(sig,2,0.07,0.8,sig);
				Out.ar(out,sig);
			}).add;




//BASS
SynthDef(\bass,{
	|note=30,amp=0.8,cutoff=500,decay=1 |
	var env,audio;
	env= EnvGen.kr(Env.new([0,1,0],[0,001,2],[3,-50]),doneAction:2);
	audio=RLPF.ar(Saw.ar(note.midicps,amp),cutoff)*env;
	audio=CombC.ar(audio,1,0.125,decay);
	Out.ar([0,1],audio);
	}
	).add;





//GRAIN

SynthDef(\grain, { |out=(1), freq=50, amp=0.2|
    OffsetOut.ar(out, Saw.ar(XLine.kr(freq, 100)) * EnvGen.kr(Env.perc, doneAction: Done.freeSelf) * amp)
}).add;


// ORGAN    este para el centro 2 hacerlo ndef
// Original code by nicolaariutti, tweaked by !ME

SynthDef(\organ, {
	| midinote=300, gate=1, amp=0.19,dur=1 |
	//var env = EnvGen.kr(Env.asr(0.1, 1, 0.1), gate, doneAction:2);
	var env = EnvGen.kr(Env.triangle(dur), gate, doneAction:2);
	var sig = VarSaw.ar(
		midinote,
		width:LFNoise2.kr(1).range(0.2, 0.8)*SinOsc.kr(5, Rand(0.0, 1.0)).range(0.7,0.8))*0.25;
	sig = sig * env * amp;
	Out.ar(0, sig!2);
}).add;

//violin


// AURORA space
// Original code by nicolaariutti, tweaked by !ME

SynthDef(\space, {
			|
			freq=556, findex=0, frate=2,
			dur=1, pos=0,
			amp=0.35,
			out=0
			|
			var sigA, sigB, sigC, sig, env, fmod;
			env = EnvGen.ar(Env.triangle(dur), doneAction:2);
			fmod = findex * SinOsc.kr(frate, mul:0.5, add:0.5) * Line.kr(0, 1, 7);
			sigA = Pulse.ar(freq + fmod, LFNoise2.kr(1).range(0.2, 0.8) );
			sigB = VarSaw.ar(freq + fmod);
			sigC = WhiteNoise.ar() * 0.125;
			sig = SelectX.ar(LFNoise2.kr(2).range(0, 2), [sigA, sigB, sigC]);
			sig = LPF.ar(sig, freq*4 );
sig= FreeVerb.ar(sig,SinOsc.kr(5).range(0.6,0.8));
			sig = sig * env * amp;
			Out.ar(out, Pan2.ar(sig, pos));
		}).add;


//AURORA SPACE


//MADERA

SynthDef(\madera, {
	|fs=30, t60=9, pitchy=2, amp=0.25, gate=1|    //fs 1 madera,   20 bambu, 60 xilofono  (t60 9 es una campana)
	var sig, exciter;
	//exciter = Impulse.ar(0);
	exciter = WhiteNoise.ar() * EnvGen.ar(Env.perc(0.001, 0.05), gate) * 0.25;
	sig = Klank.ar(
		`[
			[1, 2, 2.803, 3.871, 5.074, 7.81, 10.948, 14.421],   // freqs
			[1, 0.044, 0.891, 0.0891, 0.794, 0.1, 0.281, 0.079], // amplitudes
			[1, 0.205, 1, 0.196, 0.339, 0.047, 0.058, 0.047]*t60     // ring times
		],
		exciter,
		freqscale:fs*pitchy);
	sig = FreeVerb.ar(sig) * amp;
	DetectSilence.ar(sig, 0.001, 0.5, doneAction:2);
	Out.ar(0, sig!2);
}).add;


//MADERA



SynthDef(\nada, {
	| midinote=0, gate=0.1, amp=0.00,dur=1 |
	//var env = EnvGen.kr(Env.asr(0.1, 1, 0.1), gate, doneAction:2);
	var env = EnvGen.kr(Env.triangle(dur), gate, doneAction:2);
	var sig = VarSaw.ar(
		midinote,
		width:LFNoise2.kr(1).range(0.2, 0.8)*SinOsc.kr(5, Rand(0.0, 1.0)).range(0.7,0.8))*0.25;
	sig = sig * env * amp;
	Out.ar(0, sig!2);
}).add;
)


////////////////////////////////

////////////////////
///BINDS


(
SynthDef(\message,{ //ossDEF
		b.sendMsg("/composition/layers/3/clips/1/connect", 1);
			}).add;
)
s=Synth(\message);

/////KICK
(
			Pdef(\oscK,Pbind(
				\amp,0.5,
				\instrument,\kick,
	           \finish, Pfunc { |e| b.sendMsg("/composition/layers/3/clips/1/connect", 1)},
				\dur,Pseq([1],inf);
			   )
            )

)
Pdef(\oscK).play(t)
Pdef(\oscK).stop(t)

////////CAJA
(
			Pdef(\oscC,Pbind(
				\amp,0.5,
				\instrument,\caja,
	           \finish, Pfunc { |e| b.sendMsg("/composition/layers/4/clips/1/connect", 1)},
				\dur,Pseq([2],inf);
			   )
            )

)
Pdef(\oscC).play(t)
Pdef(\oscC).stop(t)


/////GONG

(
			Pdef(\oscG,Pbind(
				\amp,0.5,
				\instrument,\madera,
	           \finish, Pfunc { |e| b.sendMsg("/composition/layers/16/clips/1/connect", 1)},
				\dur,Pseq([16],inf);
			   )
            )

)
Pdef(\oscG).play(t)
Pdef(\oscG).stop(t)

/////CLAP
(
			Pdef(\crash,Pbind(
				\amp,0.3,
				\instrument,\clap,
	          // \finish, Pfunc { |e| b.sendMsg("/composition/layers/3/clips/1/connect", 1)},
				\dur,Pseq([2,1],inf);
			   )
            )

)
Pdef(\crash).play(t)
Pdef(\crash).stop(t)


//////MANUAL

//Kick Bind
(
			Pdef(\kk,Pbind(
				\amp,0.9,
				\instrument,\kick,
	            \dur,Pseq([1],inf);

			)
)

)
Pdef(\kk).play(t)
Pdef(\kk).stop(t)

//Bass
(
Pdef(\bass1,
Pbind(*[
	\instrument: \bass,
	\note: Pseq(
		[
			//Pseq([35,47,51,41,41,36,42,41,44],inf)
				Pseq([31,23,43,32,0,0,35,50],inf)

		],1),
	\dur:Pseq([0.5],inf),
	\amp: 0.8,
	//\cutoff: Pseq([450,300,550],inf),
	//\decay: Pseq([2,1,0.75,0.75],inf)
])
)

)
Pdef(\bass1).play(t)
Pdef(\bass1).stop(t)

/////////////////////////////
/////////////////////////////
/////////////////////////////
/////////////////////////////
/////////////////////////////
b.sendMsg("/composition/layers/3/clips/1/connect", 1);    // send the application the message "hello" with the parameter "there"

s.set(\cutoff,35);
s=Synth(\bass).set(\cutoff,500,\decay,1,\note,rrand(35,45).asInteger); // decay from 0.6 to 1.1 (depende del numero de blobs note de 35 a 45, depende de su posicion alejado del centro

c=Synth(\organ).set(\midinote,300,\dur,1.5)
// play a chord (farfisa-like sound)
(

[rrand(150,300), rrand(150,350), rrand(100,350)].do ({
	| note |
	Synth(\organ, [\midinote, note]);
})
)

(
Pbind(
	\instrument, \organ,
	\midinote, Pseq( [100,300,200], inf),
	//\t60, 1,
	//\pitchy, 4,
	\dur, 1.25
).play(t);
)

i=Synth(\space).set(\freq,100,\frate,2,\dur,0.35)

(
Pbind(
	\instrument, \space,
	\freq, Pseq( (60..70).midicps, inf),
	//\t60, 1,
	//\pitchy, 4,
	\dur, 0.25
).play(t);
)


(
Pbind(
	\instrument, \madera,
	\fs, Pseq( (60..72), 1).midicps,
	\t60, 9,
	\pitchy, 2,
	\dur, 0.25
).play;
)




/////////////////////////

