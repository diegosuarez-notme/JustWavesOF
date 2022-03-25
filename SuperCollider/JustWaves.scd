s.boot
s.meter
 Server.killAll
().play
' '.postln;
Server.default.options.outDevice_("Built-in Output");
ServerOptions.outDevices; // output devices

OSCFunc.trace(false)



(
//n = NetAddr.new("127.0.0.1", 57120);
t=TempoClock.new;
t.tempo=120/60;

//n = NetAddr.new("127.0.0.1", 7002);    // create the NetAddr
b = NetAddr.new("127.0.0.1", 7001);    // create the NetAddr
b.sendMsg("/composition/tempocontroller/tempo", LinLin.ar(120, 20, 500, dstlo: 0, dsthi: 1));
b.sendMsg("/composition/tempocontroller/resync", 1);
b.sendMsg("/composition/tempocontroller/resync", 0);



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
~notasGreen=[100,118.92,149.832,158.74,0,0,0,0,0,0];

~notasBlue=[400,475.69,599.328,634.96,0,0,0,0,0,0];

)
~notasRed=[200,237.84,299.664,599.328,0,0,0,0,0,0];
~notasRed=[800,951.36,1198.656,1269.92,0,0,0,0,0,0];
~notasBlue=[200,237.84,299.664,599.328,0,0,0,0,0,0];


~notasBlue=[200,400,800,1800,2000,0,0,0,0,0];

~notasGreen=[200,237.84,299.664,599.328,0,0,0,0,0,0];

~notasRed=[100,118.92,149.832,158.74,0,0,0,0,0,0];

=[47.194,94.388,188.776,377.552,0,0,0,0,0,0];
=[37.458,74.916,149.832,299.664,0,0,0,0,0,0];




//RED OSC
(
~oscArray=OSCdef(\redStatic,{|msg|
		var tam=msg[1];

	var x1,y,modificaX,ar;
	//msg.postln;
	//tam.postln;
		if(tam>0){
			msg.do{arg x,i;
			if( (i>1) && (i<(tam+2))){var area,aY,aX;
				#aX,aY,area=x.asString.split($, );

					y=aY.asFloat;
				x1=LinLin.kr(aX.asFloat,0,1,-1,1);
				ar=LinLin.kr(area.asFloat,0.004,0.12,0.6,1.5);   //revisar esto en OF

				modificaX=1;

				//if((x1>0)&&(x1<0.33)){modificaX=0.75;};
				//if((x1>0.33)&&(x1<0.66)){modificaX=1;};
				//if(x1>0.66){modificaX=1.25;};

				if((y>0)&&(y<0.2)){~freqR[i-2]=~notasRed[4]*modificaX;};
				if((y>0.2)&&(y<0.4)){~freqR[i-2]=~notasRed[3]*modificaX;};
				if((y>0.4)&&(y<0.6)){~freqR[i-2]=~notasRed[2]*modificaX;};
				if((y>0.6)&&(y<0.8)){~freqR[i-2]=~notasRed[1]*modificaX;};
				if(y>0.8){~freqR[i-2]=~notasRed[0]*modificaX};
			};
		};

		Ndef(\r0).set(\f1,(~freqR[0]),\a1,1,\pan,x1,\harmDist,ar);//,\revTime,~areaR[0]);
		Ndef(\r1).set(\f1,(~freqR[1]),\a1,1,\pan,x1,\harmDist,ar);//,\revTime,~areaR[1]);
		Ndef(\r2).set(\f1,(~freqR[2]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\r3).set(\f1,(~freqR[3]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\r4).set(\f1,(~freqR[4]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\r5).set(\f1,(~freqR[5]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\r6).set(\f1,(~freqR[6]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\r7).set(\f1,(~freqR[7]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\r8).set(\f1,(~freqR[8]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\r9).set(\f1,(~freqR[9]),\a1,1,\pan,x1,\harmDist,ar);
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

	var x1,y,modificaX,ar;
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
				x1=LinLin.kr(aX.asFloat,0,1,-1,1);
				ar=LinLin.kr(area.asFloat,0.004,0.12,0.6,1.8);   //revisar esto en OF

				modificaX=1;

				//if((x1>0)&&(x1<=0.33)){modificaX=0.75;};
				//if((x1>0.33)&&(x1<=0.66)){modificaX=1;};
				//if(x1>0.66){modificaX=1.25;};

				if((y>0)&&(y<0.2)){~freqG[i-2]=~notasGreen[4]*modificaX;};
				if((y>0.2)&&(y<0.4)){~freqG[i-2]=~notasGreen[3]*modificaX;};
				if((y>0.4)&&(y<0.6)){~freqG[i-2]=~notasGreen[2]*modificaX;};
				if((y>0.6)&&(y<0.8)){~freqG[i-2]=~notasGreen[1]*modificaX;};
				if(y>0.8){~freqG[i-2]=~notasGreen[0]*modificaX;};
			};
		};

		Ndef(\g0).set(\f1,(~freqG[0]),\a1,1,\pan,x1);//,\harmDist,ar);//,\revTime,~areaR[0]);
		Ndef(\g1).set(\f1,(~freqG[1]),\a1,1,\pan,x1);//,\harmDist,ar);//,\revTime,~areaR[1]);
		Ndef(\g2).set(\f1,(~freqG[2]),\a1,1,\pan,x1);//,\harmDist,ar);
		Ndef(\g3).set(\f1,(~freqG[3]),\a1,1,\pan,x1);//,\harmDist,ar);
		Ndef(\g4).set(\f1,(~freqG[4]),\a1,1,\pan,x1);//,\harmDist,ar);
		Ndef(\g5).set(\f1,(~freqG[5]),\a1,1,\pan,x1);//,\harmDist,ar);
		Ndef(\g6).set(\f1,(~freqG[6]),\a1,1,\pan,x1);//,\harmDist,ar);
		Ndef(\g7).set(\f1,(~freqG[7]),\a1,1,\pan,x1);//,\harmDist,ar);
		Ndef(\g8).set(\f1,(~freqG[8]),\a1,1,\pan,x1);//,\harmDist,ar);
		Ndef(\g9).set(\f1,(~freqG[9]),\a1,1,\pan,x1);//,\harmDist,ar);
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

	var x1,y,modificaX,ar;
	//msg.postln;
	//tam.postln;
		if(tam>0){
		//tam.postln;
			msg.do{arg x,i;
			if( (i>1) && (i<(tam+2))){var area,aY,aX;
				#aX,aY,area=x.asString.split($, );

					y=aY.asFloat;
				x1=LinLin.kr(aX.asFloat,0,1,-1,1);
				ar=LinLin.kr(area.asFloat,0.004,0.12,0.6,2);   //revisar esto en OF

				modificaX=1;

				//if((x1>0)&&(x1<0.33)){modificaX=0.75;};
				//if((x1>0.33)&&(x1<0.66)){modificaX=1;};
				//if(x1>0.66){modificaX=1.25;};

				if((y>0)&&(y<0.2)){~freqB[i-2]=~notasBlue[4]*modificaX};
				if((y>0.2)&&(y<0.5)){~freqB[i-2]=~notasBlue[3]*modificaX};
				if((y>0.4)&&(y<0.6)){~freqB[i-2]=~notasBlue[2]*modificaX};
				if((y>0.6)&&(y<0.8)){~freqB[i-2]=~notasBlue[1]*modificaX};
				if(y>0.8){~freqB[i-2]=~notasBlue[0]*modificaX};
			};
		};

		Ndef(\b0).set(\f1,(~freqB[0]),\a1,1,\pan,x1,\harmDist,ar);//,\revTime,~areaR[0]);
		Ndef(\b1).set(\f1,(~freqB[1]),\a1,1,\pan,x1,\harmDist,ar);//,\revTime,~areaR[1]);
		Ndef(\b2).set(\f1,(~freqB[2]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\b3).set(\f1,(~freqB[3]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\b4).set(\f1,(~freqB[4]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\b5).set(\f1,(~freqB[5]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\b6).set(\f1,(~freqB[6]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\b7).set(\f1,(~freqB[7]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\b8).set(\f1,(~freqB[8]),\a1,1,\pan,x1,\harmDist,ar);
		Ndef(\b9).set(\f1,(~freqB[9]),\a1,1,\pan,x1,\harmDist,ar);
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


///////////////////////////////////////////LIGHT OSC KICK


~oscArray=OSCdef(\lightOSC,{|msg|
		var tam=msg[1];

	var x1,y;
	//msg.postln;
	//tam.postln;
		if(tam>0){
			//k=Synth(\kick);
		//s=Synth(\grain).playN(-1);
		//s=Synth(\caja);


		msg.postln;
		}{
	      //  msg.postln;
		}
	},'/light',n);


//////////////////////////////////////////////////CAJA OSC

~oscArray=OSCdef(\lightSmallOSC,{|msg|
		var tam=msg[1];

	var x1,y;
	var area,aY,aX;
	//msg.postln;
	//tam.postln;
		if(tam>0){
		#aX,aY,area=msg[2].asString.split($, );
		//k=Synth(\caja).set(\pan,aX);
		//k=Synth(\caja);
		//k=Synth(\kick);


		msg.postln;
		}{
	       // msg.postln;
		}
	},'/lightSmallNO',n);


///////////////////////////////////////////////NOISE OSC

~oscArray=OSCdef(\noiseOSC,{|msg|
		var tam=msg[1];

	var x1,y;
	//msg.postln;
	//tam.postln;
		if(tam>0){
		k=Ndef(\noiseWave).set(\pan,msg[2],\freqC,msg[3]*1000+30);
		k=Ndef(\noiseWave).playN();

		//k=Synth(\kick);


		msg.postln;
		}{
	       // msg.postln;
		}
	},'/noise',n);


///////////////////////////////////////////BASS OSC
//IZQDA

~oscArray=OSCdef(\bassOSC,{|msg|
		var tam=msg[1];

	var x1,y;
	//msg.postln;
	//tam.postln;
		if(tam>0){
		k=Synth(\bass).set(\note,rrand(40,50));


		msg.postln;
		}{
	      // msg.postln;
		}
	},'/circleLeft',n);


///////////////////////////////////////////SPACE OSC
//CENTRO

~oscArray=OSCdef(\spaceOSC,{|msg|
		var tam=msg[1];

	var d,ar;
	//msg.postln;
	//tam.postln;
		if(tam>0){
		msg.do{arg x,i;
			if( (i>1) && (i<(tam+2))){var area,dist;
				#dist,area=x.asString.split($, );

				d=LinLin.kr(dist.asFloat,0,1,100,210);
				ar=LinLin.kr(area.asFloat,0,1,0.25,1);   //revisar esto en OF

				s=Synth(\space).set(\freq,d,\dur,ar);
				//s=Synth(\space);

			};
		};
			msg.postln;
		}{
	      // msg.postln;
		}
	},'/circleCenter',n);


///////////////////////////////////////////ORGAN OSC
//DCHA

~oscArray=OSCdef(\organOSC,{|msg|
		var tam=msg[1];

	var d,ar;
	//msg.postln;
	//tam.postln;
		if(tam>0){
		msg.do{arg x,i;
			if( (i>1) && (i<(tam+2))){var area,dist;
				#dist,area=x.asString.split($, );

				d=LinLin.kr(dist.asFloat,0,1,200,350);
				ar=LinLin.kr(area.asFloat,0,1,0.1,0.25);   //revisar esto en OF

				o=Synth(\organ).set(\midinote,d,\dur,ar);

			};
		};
		msg.postln;
		}{
	      // msg.postln;
		}
	},'/circleRight',n);
)

//////////////////////////////////////////////////////////////////

d = NdefMixer(s);
d.parent.alwaysOnTop_(true);

s.scope
s.meter







		