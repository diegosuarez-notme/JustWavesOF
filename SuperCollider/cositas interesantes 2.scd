{LPF.ar(WhiteNoise.ar(0.1),Line.kr(10000,1000,5))}.scope //listen for ten seconds at least to hear the full effect


(
Ndef(\noiseWave,{
	arg ampg=0.01,freq=4000;
	var sig;
	// sig=WhiteNoise.ar(ampg);
	sig=Saw.ar(XLine.kr(freq, 0.01,1.1));
	sig=LPF.ar(sig,freq);

	//sig= DelayC.ar(sig,0.5,0.7,1,1);
	sig= FreeVerb.ar(sig,SinOsc.kr(1).range(0.01,0.7));
	//sig=sig*SinOsc.kr(0.1,0.6)*SinOsc.kr(0.073,0.4);
	sig= DelayC.ar(sig,2.5,0.5,1,0);

}).play;
)




(
SynthDef(\grain, { |out=(1), freq=50, amp=0.2|
    OffsetOut.ar(out, Saw.ar(XLine.kr(freq, 30)) * EnvGen.kr(Env.perc, doneAction: Done.freeSelf) * amp)
}).add;
)




//KICK
t=TempoClock.new;
t.tempo=120/60;
(
SynthDef(\kick,{
		arg freqA=800,freqB=40,freqC=40,freqDur1=0.006,freqDur2=0.3,freqC1=9,freqC2=(-1),atk=0.01,rel=1,c1=4,c2=(-12),amp=2,pan=0,out=1;
		var sig,env,freqSweep;
				freqSweep=Env([freqA,freqB,freqC],[freqDur1,freqDur2],[freqC1,freqC2]).ar;
				env=Env([0,1,0],[atk,rel],[c1,c2]).kr(2);
				sig=SinOsc.ar(freqSweep,pi/2);
				sig=sig*env;
				sig= FreeVerb.ar(sig,SinOsc.kr(1).range(0.3,0.4));

				sig=Pan2.ar(sig,pan,amp);
	//sig= DelayC.ar(sig,0.5,0.5,1.7,0.1);
				Out.ar(out,sig);
			}).add;
)
(
SynthDef(\hat1,{
		arg freqA=800,freqB=40,freqC=40,freqDur1=0.006,freqDur2=0.3,freqC1=9,freqC2=(-1),atk=0.01,rel=1,c1=4,c2=(-12),amp=2,pan=0,out=1;
		var sig,env,freqSweep;
				freqSweep=Env([freqA,freqB,freqC],[freqDur1,freqDur2],[freqC1,freqC2]).ar;
				env=Env([0,1,0],[atk,rel],[c1,c2]).kr(2);
				sig=HPF.ar(WhiteNoise.ar(0.1),Line.kr(1000,10000,1 ));//SinOsc.ar(freqSweep,pi/2);
				sig=sig*env;
	//sig= DelayN.ar(sig,0.2,0.2,1,0.3);
				//sig= FreeVerb.ar(sig,SinOsc.kr(1).range(0.3,0.4));

		//		sig=Pan2.ar(sig,pan,amp);
	//sig= DelayC.ar(sig,0.5,0.5,1.7,0.1);
				Out.ar(out,sig);
			}).add;
)

(
SynthDef(\hat2,{
		arg freqA=800,freqB=40,freqC=40,freqDur1=0.006,freqDur2=0.3,freqC1=9,freqC2=(-1),atk=0.01,rel=1,c1=4,c2=(-12),amp=2,pan=0,out=1;
		var sig,env,freqSweep;
				freqSweep=Env([freqA,freqB,freqC],[freqDur1,freqDur2],[freqC1,freqC2]).ar;
				env=Env([0,1,0],[atk,rel],[c1,c2]).kr(2);
				sig=HPF.ar(WhiteNoise.ar(0.1),Line.kr(1000,10000,1 ));//SinOsc.ar(freqSweep,pi/2);
				sig=sig*env;
	//sig= DelayC.ar(sig,0.1,0.1,1,0);
				//sig= FreeVerb.ar(sig,SinOsc.kr(1).range(0.3,0.4));

		//		sig=Pan2.ar(sig,pan,amp);
	//sig= DelayC.ar(sig,0.5,0.5,1.7,0.1);
				Out.ar(out,sig);
			}).add;
)
s.meter

k=Synth(\hat1);

k=Synth(\hat2);



{HPF.ar(WhiteNoise.ar(0.1),Line.kr(10000,1000,0.5 ))}.scope //listen for ten seconds at least to hear the full effect
{HPF.ar(WhiteNoise.ar(0.1),8000)}.scope //listen for ten seconds at least to hear the full effect