///////////////////////////////////////////////////
//////RED SOUNDS
//////////////////////////////////////////////////


(
Ndef(\r0,{
	arg f1=50,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\r1,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\r2,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\r3,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\r4,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\r5,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\r6,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\r7,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\r8,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\r9,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

)


///////////////////////////////////////////////////
//////GREEN SOUNDS
//////////////////////////////////////////////////


~n=5; //esta se puede meter en el synthdef
////// g0 es el bueno

Ndef(\g0).set(\harmDist,2)
Ndef(\g0).fadeTime=0.2


(
Ndef(\g0,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;


Ndef(\g1,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\g2,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\g3,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;
Ndef(\g4,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\g5,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\g6,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\g7,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\g8,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\g9,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;



)
///////////////////////////////////////////////////
//////BLUE SOUNDS
//////////////////////////////////////////////////
(
Ndef(\b0,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\b1,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\b2,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\b3,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\b4,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\b5,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\b6,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\b7,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\b8,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;

Ndef(\b9,{
	arg f1=0,a1=1, revTime=0.1,revRange=0.4,ampg=0.6,harmonics=5,harmDist=5,pan=0;
	var sig;

	var n=20;

	sig = Mix.fill(n,{|i|
			var mult= ((-1)**i)*(0.5/((i+1)));
			SinOsc.ar(f1*(i+1)/harmDist)*mult   //hacer aqui la trapinada para que no suenen mas harmonicos de los que quiero con un argumento
		})*0.25;
	sig=Pan2.ar(sig,pan);
	sig=FreeVerb.ar(sig,SinOsc.kr([revTime,revTime+1.2]).range(revRange));
	sig=sig*ampg;
}).playN;




)