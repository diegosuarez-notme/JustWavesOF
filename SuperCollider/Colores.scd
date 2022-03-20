


///////////////////////////////////////////////////
//////RED SOUNDS
//////////////////////////////////////////////////


(
Ndef(\r0,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.2;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(-1);

Ndef(\r1,{
	arg f1=0,a1=1, revTime=0.2,revRange=0.6,ampg=0.2;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(-1);



Ndef(\r2,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.2;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(-1);

Ndef(\r3,{
	arg f1=0,a1=1, revTime=0.11,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(-1);
Ndef(\r4,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(-1);

Ndef(\r5,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(-1);

Ndef(\r6,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(-1);

Ndef(\r8,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(-1);

Ndef(\r7,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(-1);

Ndef(\r9,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(-1);


)
s.meter

///////////////////////////////////////////////////
//////GREEN SOUNDS
//////////////////////////////////////////////////


~n=5; //esta se puede meter en el synthdef
////// g0 es el bueno

Ndef(\g0).set(\harmDist,2)
Ndef(\g0).fadeTime=0.2


(
Ndef(\g0,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=2,pan=0;
	var sig;

	var n=3;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;




)
(
Ndef(\g1,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	//sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);



Ndef(\g2,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\g3,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);
Ndef(\g4,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\g5,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\g6,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\g8,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\g7,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\g9,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar([f1,f1], 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime]).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);


)
///////////////////////////////////////////////////
//////BLUE SOUNDS
//////////////////////////////////////////////////
(
Ndef(\b0,{
	arg f1=0,a1=1, revTime=2,revRange=0.6,ampg=0.1;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr(revTime).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\b1,{
	arg f1=0,a1=1, revTime=1.3,revRange=0.6,ampg=0.1;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	//sig=FreeVerb.ar(sig,SinOsc.kr(revTime).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);



Ndef(\b2,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.1;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr(revTime).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\b3,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr(revTime).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);
Ndef(\b4,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr(revTime).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\b5,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr(revTime).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\b6,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr(revTime).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\b7,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr(revTime).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\b8,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr(revTime).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);

Ndef(\b9,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.6,ampg=0.3;
	var sig;
	sig=SinOsc.ar(f1, 0, 0.3);
	sig=FreeVerb.ar(sig,SinOsc.kr(revTime).range(revRange));
	//sig= DelayC.ar(sig,0.5,0.6,1,1);
	sig=sig*ampg;
}).playN(1);


)