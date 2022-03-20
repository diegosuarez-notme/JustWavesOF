s.boot
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

(
~freqR=[100,300,4000,0,0,0,0,0,0,0];
~freqG=[0,0,0,0,0,0,0,0,0,0];
~freqB=[0,0,0,0,0,0,0,0,0,0];

~ampR=[0,0,0,0,0,0,0,0,0,0];
~ampB=[0,0,0,0,0,0,0,0,0,0];
~ampG=[0,0,0,0,0,0,0,0,0,0];

~areaR=[0,0,0,0,0,0,0,0,0,0];
~areaB=[0,0,0,0,0,0,0,0,0,0];
~areaG=[0,0,0,0,0,0,0,0,0,0];


~notasRed=[100,40,100];
~notasGreen=[100,120,140];
~notasBlue=[60,80,100];

)

{Saw.ar(600!2)}.play
().play


//RED OSC
(
~oscArray=OSCdef(\redStatic,{|msg|
		var tam=msg[1];

	var x1,y;
	//msg.postln;
	//tam.postln;
		if(tam>0){
			msg.do{arg x,i;
				if( (i>1) && (i<3)){var area,aY,aX;
				#aX,aY,area=x.asString.split($, );

					y=aY.asFloat;
					x1=aX.asFloat;
					~areaR[i-2]=(area.asFloat)-0.5;
					if(y<0.3){~freqR[i-2]=~notasRed[0]};
				    if((y>0.3)&&(y<0.6)){~freqR[i-2]=~notasRed[1]}{~freqR[i-2]=~notasRed[2]};
					~freqR[i-2]=aY.asFloat;
					~areaR[i-2]=area.asFloat;
			};
		};

			Ndef(\diegoRed).set(\f1,(~freqR[0]+1)*~notasRed[0],\f2,(~freqR[1])*~notasRed[1],\f3,(~freqR[2])*~notasRed[2]);
			Ndef(\diegoRed).set(\a1,0.2/tam,\a2,0.2/tam,\a3,0.2/tam);

			msg.postln;
		}{Ndef(\diegoRed).set(\a1,0,\a2,0,\a3,0);
			Ndef(\diegoRed).set(\f1,0,\f2,0,\f3,0);

		msg.postln;
		}
	},'/red',n);
)








//BLUE OSC
(
~oscArray=OSCdef{\blueStatic,{|msg|
		var tam=msg[1];
		if(tam>0){
			msg.do(arg x,i;
				if( (i>1) && (i<4)){var area,aY,aX;
					$aX,AY,area=x.asString.split{$,};
					~freqB[i-2]=aY.asFloat;
					~areaB[i-2]=area.asFloat;
				   }
			    );
			Ndef(\diegoBlue).set(\f1,(~freqB[0]+1)*~notasBlue[0],\f2,(~freqB[1])*~notasBlue[1],\f3,(~freqB[2])*~notasBlue[2]);
			Ndef(\diegoBlue).set(\a1,0.2/tam,\a2,0.2/tam,\a3,0.2/tam);

			msg.postln;
		}{Ndef(\diegoBlue).set(\a1,0,\a2,0,\a3,0);
			Ndef(\diegoBlue).set(\f1,0,\f2,0,\f3,0);
		}
	},'/blue',n);
)



(
Ndef(\diegoRed,{
	arg f1=400, f2=1000, f3=200,a1=1,a2=1, a3=1, ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1+1,f2,f2+3, f3],[a1,a2,a3]);
	//sig=SinOsc.ar(XLine.kr(f1, f2), 0, a1);
	//sig= DelayC.ar(sig,0.1,0.1,1.1,1);
	sig=FreeVerb.ar(sig,SinOsc.kr(1).range(1.7));
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


//OTHER SYNTHS

Ndef(\diegoWave,{
	arg ampg=0.4, f1=4, f2=2, f3=4, a1=0.1, a2=0.01,a3=0.01;
	var sig;
	sig=SinOsc.ar([f1,f1+1,f2,f2+3,f3],[a1,a2,a3]);
	sig=FreeVerb.ar(sig,SinOsc.kr(2).range(6,7));
	sig+sig*ampg;
}).play;

(
Ndef(\diegoNoise,{
	arg ampg=0.2;
	var sig;
	sig=PinkNoise.ar(ampg,0);
	//sig=LPF.ar(sig,9000,0.1,0.4);
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*SinOsc.kr(0.1,0.6)*SinOsc.kr(0.073,0.4);
	//sig= DelayC.ar(sig,0.1,0.1,0.7,0);

}).play;
)


//KICK
t=TempoClock.new;
t.tempo=120/60;

SynthDef(\kick,{
		arg freqA=800,freqB=40,freqC=40,freqDur1=0.006,freqDur2=0.3,freqC1=9,freqC2=(-1),atk=0.01,rel=1,c1=4,c2=(-12),amp=1,pan=0,out=1;
		var sig,env,freqSweep;
				freqSweep=Env([freqA,freqB,freqC],[freqDur1,freqDur2],[freqC1,freqC2]).ar;
				env=Env([0,1,0],[atk,rel],[c1,c2]).kr(2);
				sig=SinOsc.ar(freqSweep,pi/2);
				sig=sig*env;
				sig= FreeVerb.ar(sig,SinOsc.kr(1).range(0.3,0.4));
				sig=Pan2.ar(sig,pan,amp);
				Out.ar(out,sig);
			}).add;


k=Synth(\kick);

(
			Pdef(\k,Pbind(
				\amp,0.9,
				\instrument,\kick,
				\dur,Pseq([2,1,2,2,1],inf);
			)
			)
)
Pdef(\k).stop(t)


(
		Ndef(\diegoRed).fadeTime=1;
		Ndef(\diegoBlue).fadeTime=1;
		Ndef(\diegoGreen).fadeTime=1;
		Ndef(\diegoNoise).fadeTime=5;
		Ndef(\diegoWave).fadeTime=1;
)

		(
			Ndef(\diegoRed).set(\ampg,0.5);
		Ndef(\diegoBlue).set(\ampg,0.5);
		Ndef(\diegoGreen).set(\ampg,0.5);
		Ndef(\diegoNoise).set(\ampg,0.3);
		Ndef(\diegoWave).set(\ampg,0.5);
)

		Ndef(\diegoRed).set(\gate,1);
		Ndef(\diegoGreen).set(\gate,1);
		Ndef(\diegoBlue).set(\gate,1);
		Ndef(\diegoNoise).set(\gate,0);
		Ndef(\diegoWave).set(\gate,1);
	Ndef(\diegoWave).stop

Ndef.clear(3);






		