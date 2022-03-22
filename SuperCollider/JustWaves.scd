s.boot
s.meter
 Server.killAll
().play
' '.postln;
Server.default.options.outDevice_("Built-in Output");
ServerOptions.outDevices; // output devices

OSCFunc.trace(false)

OK EMPECEMOS


(
//n = NetAddr.new("127.0.0.1", 57120);
t=TempoClock.new;
t.tempo=120/60;

~freqR=[0,0,0,0,0,0,0,0,0,0];
~freqG=[0,0,0,0,0,0,0,0,0,0];
~freqB=[0,0,0,0,0,0,0,0,0,0];

~ampR=[0,0,0,0,0,0,0,0,0,0];
~ampB=[0,0,0,0,0,0,0,0,0,0];
~ampG=[0,0,0,0,0,0,0,0,0,0];

~areaR=[0,0,0,0,0,0,0,0,0,0];
~areaB=[0,0,0,0,0,0,0,0,0,0];
~areaG=[0,0,0,0,0,0,0,0,0,0];


~notasRed=[50,59.46,74.916,79,37,0,0,0,0,0,0];
~notasGreen=[200,237.84,299.664,599.328,0,0,0,0,0,0];

~notasBlue=[400,475.69,599.328,634.96,0,0,0,0,0,0];

)
~notasRed=[200,237.84,299.664,599.328,0,0,0,0,0,0];
~notasRed=[800,951.36,1198.656,1269.92,0,0,0,0,0,0];
~notasBlue=[200,237.84,299.664,599.328,0,0,0,0,0,0];


~notasBlue=[200,400,800,1800,0,0,0,0,0,0];


~notasRed=[100,118.92,149.832,158.74,0,0,0,0,0,0];

=[47.194,94.388,188.776,377.552,0,0,0,0,0,0];
=[37.458,74.916,149.832,299.664,0,0,0,0,0,0];




//RED OSC
(
~oscArray=OSCdef(\redStatic,{|msg|
		var tam=msg[1];

	var x1,y,modificaX;
	//msg.postln;
	//tam.postln;
		if(tam>0){
			msg.do{arg x,i;
			if( (i>1) && (i<(tam+2))){var area,aY,aX;
				#aX,aY,area=x.asString.split($, );

					y=aY.asFloat;
					x1=aX.asFloat;
				//x1.postln;
					//~areaR[i-2]=(area.asFloat)-0.5;

				if((x1>0)&&(x1<0.33)){modificaX=0.75;};
				if((x1>0.33)&&(x1<0.66)){modificaX=1;};
				if(x1>0.66){modificaX=1.25;};

				if((y>0)&&(y<0.25)){~freqR[i-2]=~notasRed[3]*modificaX;};
				if((y>0.25)&&(y<0.5)){~freqR[i-2]=~notasRed[2]*modificaX;};
				if((y>0.5)&&(y<0.75)){~freqR[i-2]=~notasRed[1]*modificaX;};
				if(y>0.75){~freqR[i-2]=~notasRed[0]*modificaX};
			};
		};

		Ndef(\r0).set(\f1,(~freqR[0]),\a1,1);//,\revTime,~areaR[0]);
		Ndef(\r1).set(\f1,(~freqR[1]),\a1,1);//,\revTime,~areaR[1]);
		Ndef(\r2).set(\f1,(~freqR[2]),\a1,1);
		Ndef(\r3).set(\f1,(~freqR[3]),\a1,1);
		Ndef(\r4).set(\f1,(~freqR[4]),\a1,1);
		Ndef(\r5).set(\f1,(~freqR[5]),\a1,1);
		Ndef(\r6).set(\f1,(~freqR[6]),\a1,1);
		Ndef(\r7).set(\f1,(~freqR[7]),\a1,1);
		Ndef(\r8).set(\f1,(~freqR[8]),\a1,1);
		Ndef(\r9).set(\f1,(~freqR[9]),\a1,1);
			//Ndef(\r0).set(\a1,0.2/tam,\a2,0.2/tam,\a3,0.2/tam);

			msg.postln;
		}{
		Ndef(\r0).set(\f1,0,\a1,0);
		Ndef(\r1).set(\f1,0,\a1,0);
		Ndef(\r2).set(\f1,0,\a1,0);
		Ndef(\r3).set(\f1,0,\a1,0);
		Ndef(\r4).set(\f1,0,\a1,0);
		Ndef(\r5).set(\f1,0,\a1,0);
		Ndef(\r6).set(\f1,0,\a1,0);
		Ndef(\r7).set(\f1,0,\a1,0);
		Ndef(\r8).set(\f1,0,\a1,0);
		Ndef(\r9).set(\f1,0,\a1,0);


		//msg.postln;
		}
	},'/red',n);


//GREEN OSC

~oscArray=OSCdef(\greenStatic,{|msg|
		var tam=msg[1];

	var x1,y,modificaX;
	//msg.postln;
	//tam.postln;
		if(tam>0){
		//tam.postln;
		msg.postln;
		msg.do{arg x,i;
			//i.postln;
			if( (i>1) && (i<(tam+2))){var area,aY,aX;
				#aX,aY,area=x.asString.split($, );

					y=aY.asFloat;
					x1=aX.asFloat;
				//y.postln;

					if((x1>0)&&(x1<=0.33)){modificaX=0.75;};
				if((x1>0.33)&&(x1<=0.66)){modificaX=1;};
				if(x1>0.66){modificaX=1.25;};

				if((y>0)&&(y<0.25)){~freqG[i-2]=~notasGreen[3]*modificaX;};
				if((y>0.25)&&(y<0.5)){~freqG[i-2]=~notasGreen[2]*modificaX;};
				if((y>0.5)&&(y<0.75)){~freqG[i-2]=~notasGreen[1]*modificaX;};
				if(y>0.75){~freqG[i-2]=~notasGreen[0]*modificaX;};
			};
		};

		Ndef(\g0).set(\f1,(~freqG[0]),\a1,1);//,\revTime,~areaR[0]);
		Ndef(\g1).set(\f1,(~freqG[1]),\a1,1);//,\revTime,~areaR[1]);
		Ndef(\g2).set(\f1,(~freqG[2]),\a1,1);
		Ndef(\g3).set(\f1,(~freqG[3]),\a1,1);
		Ndef(\g4).set(\f1,(~freqG[4]),\a1,1);
		Ndef(\g5).set(\f1,(~freqG[5]),\a1,1);
		Ndef(\g6).set(\f1,(~freqG[6]),\a1,1);
		Ndef(\g7).set(\f1,(~freqG[7]),\a1,1);
		Ndef(\g8).set(\f1,(~freqG[8]),\a1,1);
		Ndef(\g9).set(\f1,(~freqG[9]),\a1,1);
			//Ndef(\r0).set(\a1,0.2/tam,\a2,0.2/tam,\a3,0.2/tam);

			msg.postln;
		}{
		Ndef(\g0).set(\f1,0,\a1,0);
		Ndef(\g1).set(\f1,0,\a1,0);
		Ndef(\g2).set(\f1,0,\a1,0);
		Ndef(\g3).set(\f1,0,\a1,0);
		Ndef(\g4).set(\f1,0,\a1,0);
		Ndef(\g5).set(\f1,0,\a1,0);
		Ndef(\g6).set(\f1,0,\a1,0);
		Ndef(\g7).set(\f1,0,\a1,0);
		Ndef(\g8).set(\f1,0,\a1,0);
		Ndef(\g9).set(\f1,0,\a1,0);


		//msg.postln;
		}
	},'/green',n);



//BLUE OSC

~oscArray=OSCdef(\blueStatic,{|msg|
		var tam=msg[1];

	var x1,y,modificaX;
	//msg.postln;
	//tam.postln;
		if(tam>0){
		//tam.postln;
			msg.do{arg x,i;
			if( (i>1) && (i<(tam+2))){var area,aY,aX;
				#aX,aY,area=x.asString.split($, );

					y=aY.asFloat;
					x1=aX.asFloat;
				//x1.postln;
				//y.postln;
				if((x1>0)&&(x1<0.33)){modificaX=0.75;};
				if((x1>0.33)&&(x1<0.66)){modificaX=1;};
				if(x1>0.66){modificaX=1.25;};

				if((y>0)&&(y<0.25)){~freqB[i-2]=~notasBlue[3]*modificaX};
				if((y>0.25)&&(y<0.5)){~freqB[i-2]=~notasBlue[2]*modificaX};
				if((y>0.5)&&(y<0.75)){~freqB[i-2]=~notasBlue[1]*modificaX};
				if(y>0.75){~freqB[i-2]=~notasBlue[0]*modificaX};
			};
		};

		Ndef(\b0).set(\f1,(~freqB[0]),\a1,1);//,\revTime,~areaR[0]);
		Ndef(\b1).set(\f1,(~freqB[1]),\a1,1);//,\revTime,~areaR[1]);
		Ndef(\b2).set(\f1,(~freqB[2]),\a1,1);
		Ndef(\b3).set(\f1,(~freqB[3]),\a1,1);
		Ndef(\b4).set(\f1,(~freqB[4]),\a1,1);
		Ndef(\b5).set(\f1,(~freqB[5]),\a1,1);
		Ndef(\b6).set(\f1,(~freqB[6]),\a1,1);
		Ndef(\b7).set(\f1,(~freqB[7]),\a1,1);
		Ndef(\b8).set(\f1,(~freqB[8]),\a1,1);
		Ndef(\b9).set(\f1,(~freqB[9]),\a1,1);
			//Ndef(\r0).set(\a1,0.2/tam,\a2,0.2/tam,\a3,0.2/tam);

			msg.postln;

		}{
		Ndef(\b0).set(\f1,0,\a1,0);
		Ndef(\b1).set(\f1,0,\a1,0);
		Ndef(\b2).set(\f1,0,\a1,0);
		Ndef(\b3).set(\f1,0,\a1,0);
		Ndef(\b4).set(\f1,0,\a1,0);
		Ndef(\b5).set(\f1,0,\a1,0);
		Ndef(\b6).set(\f1,0,\a1,0);
		Ndef(\b7).set(\f1,0,\a1,0);
		Ndef(\b8).set(\f1,0,\a1,0);
		Ndef(\b9).set(\f1,0,\a1,0);


		//msg.postln;
		}
	},'/blue',n);
)

//LIGHT OSC

(
~oscArray=OSCdef(\lightOSC,{|msg|
		var tam=msg[1];

	var x1,y;
	//msg.postln;
	//tam.postln;
		if(tam>0){
			k=Synth(\kick);
		//s=Synth(\grain).playN(-1);
		//s=Synth(\caja);


		msg.postln;
		}{
	      //  msg.postln;
		}
	},'/light',n);
)

(
~oscArray=OSCdef(\lightSmallOSC,{|msg|
		var tam=msg[1];

	var x1,y;
	//msg.postln;
	//tam.postln;
		if(tam>0){
		k=Synth(\caja).playN(-1);
		//k=Synth(\kick);


		msg.postln;
		}{
	       // msg.postln;
		}
	},'/lightSmall',n);
)




s.scope
s.meter

//OTHER SYNTHS

(
Ndef(\noiseWave).fadeTime=1;
Ndef(\noiseWave,{
	arg ampg=0.2,,freqC=1000,pan=0;
	var sig,sig2;
	sig=WhiteNoise.ar(ampg,0);
	sig=LPF.ar(sig,freqC);
	sig=Pan2.ar(sig,0);
	//sig=Pan2.ar(LPF.ar(WhiteNoise.ar(0.1)), pan);
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*SinOsc.kr(0.1,0.6)*SinOsc.kr(0.073,0.4);
	//sig= FreeVerb.ar(sig,SinOsc.kr(1).range(0.6,0.7));
	//sig= DelayC.ar(sig,0.1,0.1,0.7,0);

}).playN
)
Ndef(\noiseWave).set(\gate,1);
Ndef(\noiseWave).fadeTime=5;
{Pan2.ar(LPF.ar(WhiteNoise.ar(0.1)), 0)}.play

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
)

k=Synth(\kick);
g=Synth(\grain);


//CAJA
t=TempoClock.new;
t.tempo=120/60;
(
SynthDef(\caja,{
	arg freqA=2200,freqB=180,freqC=80,freqDur1=0.06,freqDur2=0.6,freqC1=9,freqC2=(-1),atk=0.001,rel=1.5,c1=4,c2=(-12),amp=1,pan=(0),out=0;
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
)
c=Synth(\caja);

(
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
)
c=Synth(\clap);


(
k=Synth(\kick);
g=Synth(\grain);
)

(
//BASS
SynthDef(\bass,{
	|note=30,amp=1.2,cutoff=500,decay=1 |
	var env,audio;
	env= EnvGen.kr(Env.new([0,1,0],[0,001,2],[3,-50]),doneAction:2);
	audio=RLPF.ar(Saw.ar(note.midicps,amp),cutoff)*env;
audio=CombC.ar(audio,1,0.125,decay);
Out.ar([0,1],audio);

}
).add

)

b=Synth(\bass)

s.set(\cutoff,35);
s=Synth(\bass).set(\cutoff,500,\decay,1,\note,rrand(35,45).asInteger); // decay from 0.6 to 1.1 (depende del numero de blobs note de 35 a 45, depende de su posicion alejado del centro


//GRAIN
(
SynthDef(\grain, { |out=(1), freq=50, amp=0.2|
    OffsetOut.ar(out, Saw.ar(XLine.kr(freq, 100)) * EnvGen.kr(Env.perc, doneAction: Done.freeSelf) * amp)
}).add;
)

// ORGAN    este para el centro 2 hacerlo ndef
// Original code by nicolaariutti, tweaked by !ME
(
SynthDef(\organ, {
	| midinote=300, gate=1, amp=0.05,dur=1 |
	//var env = EnvGen.kr(Env.asr(0.1, 1, 0.1), gate, doneAction:2);
	var env = EnvGen.kr(Env.triangle(dur), gate, doneAction:2);
	var sig = VarSaw.ar(
		midinote,
		width:LFNoise2.kr(1).range(0.2, 0.8)*SinOsc.kr(5, Rand(0.0, 1.0)).range(0.7,0.8))*0.25;
	sig = sig * env * amp;
	Out.ar(0, sig!2);
}).add;
)
c=Synth(\organ).set(\dur,1.5)
// play a chord (farfisa-like sound)
(

[60, 64, 67].do ({
	| note |
	Synth(\organ, [\midinote, note]);
})
)
t=TempoClock.new
t.tempo=120/60
(
Pbind(
	\instrument, \organ,
	\midinote, Pseq( [100,300,200], inf),
	//\t60, 1,
	//\pitchy, 4,
	\dur, 1.25
).play(t);
)

//violin


// AURORA
// Original code by nicolaariutti, tweaked by !ME
(
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
)
b=Synth(\space).set(\freq,150,\frate,1,\dur,0.55)
(
Pbind(
	\instrument, \space,
	\freq, Pseq( (60..70).midicps, inf),
	//\t60, 1,
	//\pitchy, 4,
	\dur, 0.25
).play(t);
)
//AURORA

//MADERA
(
SynthDef(\madera, {
	|fs=20, t60=2, pitchy=2, amp=0.25, gate=1|    //fs 1 madera,   20 bambu, 60 xilofono  (t60 9 es una campana)
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
}).add
)

a=Synth(\madera)

(
Pbind(
	\instrument, \madera,
	\fs, Pseq( (60..72), 1).midicps,
	\t60, 9,
	\pitchy, 2,
	\dur, 0.25
).play;
)
//MADERA



////////////////////
///BINDS
//Bass
(
Pdef(\bass1,
Pbind(*[
	\instrument: \bass,
	\note: Pseq(
		[
			//Pseq([35,47,51,41,41,36,42,41,44],inf)
				Pseq([31,37,49,42,38,33,35,50],inf)

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

b = NetAddr.new("127.0.0.1", 7001);    // create the NetAddr
b.sendMsg("/composition/layers/3/clips/1/connect", 1);    // send the application the message "hello" with the parameter "there"


(
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
(
SynthDef(\message,{ //ossDEF
		b.sendMsg("/composition/layers/3/clips/1/connect", 1);
			}).add;
)
s=Synth(\message);

(
			Pdef(\osc2,Pbind(
				\amp,0.5,
				\instrument,\nada,
	           \finish, Pfunc { |e| b.sendMsg("/composition/layers/3/clips/1/connect", 1)},
				\dur,Pseq([4],inf);
			   )
            )

)
Pdef(\osc2).play(t)
Pdef(\osc2).stop(t)


(
			Pdef(\osc1,Pbind(
				\amp,0.5,
				\instrument,\caja,
	          // \finish, Pfunc { |e| b.sendMsg("/composition/layers/4/clips/1/connect", 1)},
				\dur,Pseq([2],inf);
			   )
            )

)
Pdef(\osc1).play(t)
Pdef(\osc1).stop(t)

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

(

		Ndef(\noiseWave).fadeTime=5;
)

		(

		Ndef(\noiseWave).set(\ampg,0.3);
)

(
		Ndef(\noiseWave).set(\gate,1);
		Ndef(\diegoWave).set(\gate,1);
)

	Ndef(\diegoWave).stop

Ndef.clear(10);

(
Ndef(\r0,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.2;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).play;
)





		