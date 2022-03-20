s.boot


//SUSTRACTIVE

{LPF.ar(WhiteNoise.ar(0.1),1000)}.scope

Line.kr(10000,1000,10) // take ten seconds to go from 10000 to 1000: inputs to Line are start, end, duration

{LPF.ar(WhiteNoise.ar(0.1),Line.kr(10000,1000,02 ))}.scope //listen for ten seconds at least to hear the full effect

{HPF.ar(WhiteNoise.ar(0.1),Line.kr(10000,1000,0.5 ))}.scope //listen for ten seconds at least to hear the full effect
{HPF.ar(WhiteNoise.ar(0.1),8000)}.scope //listen for ten seconds at least to hear the full effect

{Blip.ar(440,200,1,0)}.scope
{Saw.ar(440,200,1,0)}.scope

{LFNoise0.ar(4000,1,0)}.scope
{ Resonz.ar(WhiteNoise.ar(0.5), 2000, 0.1) }.scope


{Resonz.ar(LFNoise0.ar(400),1000,0.1)}.scope





{Resonz.ar(LFNoise0.ar(400),Line.kr(10000,600,0.7),0.1)}.scope


//ADDITIVE
{SinOsc.ar}.scope //defaults to a concert A (440Hz)


{SinOsc.ar(445,0,0.1) + SinOsc.ar(660,0,0.1)}.scope




{SinOsc.ar([220,400,640],0,0.1)}.scope

// RUIDO  paneado
{LPF.ar(WhiteNoise.ar(0.1),1000)}.scope
{Pan2.ar(LPF.ar(WhiteNoise.ar(0.1),MouseX.kr(1000,1001)), MouseX.kr(-1,1))}.play

{Pan2.ar(LPF.ar(WhiteNoise.ar(0.1),MouseX.kr(1000,100)),0)}.scope
{Pan2.ar(LPF.ar(WhiteNoise.ar(0.1)),0)}.playN


{SinOsc.ar([400,660,870],0,0.1)}.scope //three channel sound - you may only hear two, because you probably have a stereo output on your computer, not a three channel out


One method is to wrap the multichannel sound with a Mix UGen:



{Mix(SinOsc.ar([400,660,870],0,0.1))}.scope //a two channel signal put through Mix turns into mono2

And then, of course, Pan2 allows me to place this in the stereo field:



{Pan2.ar(Mix(SinOsc.ar([437],0,0.1)),MouseX.kr(-1,1))}.scope //a two channel signal put through Mix turns into mono






Sawtooth wave: Add up n harmonics with amplitude falling off as 1/harmonicnumber, sign alternates between +1 and -1

(
{
	var n = 10;
	var wave = Mix.fill(10,{|i|
		var mult= ((-1)**i)*(0.5/((i+1)));

		SinOsc.ar(440*(i+1))*mult
    });

	Pan2.ar(wave/n,0.0); //stereo, panned centre


}.scope;

)

Square wave: Sum of odd harmonics, no even, amplitude falls as off 1/harmonicnumber; closest 'real' waveform is a clarinet tone


(
{
	var n = 10;
	var wave = Mix.fill(10,{|i|
			var harmonicnumber = 2*i+1; //odd harmonics only
			SinOsc.ar(440*harmonicnumber)/harmonicnumber
		})*0.25;

	Pan2.ar(wave,0.0); //stereo, panned centre

}.scope;
)



Triangle wave: also odd harmonics only, falls off as 1 over harmonicnumber squared with alternating sign

(
{
	var n = 10;
	var wave = Mix.fill(10,{|i|

		var harmonicnumber= 2*i+1; //odd harmonics only
    	var mult= ((-1)**((harmonicnumber-1)/2))*(1.0/(harmonicnumber*harmonicnumber));

    SinOsc.ar(440*i)*mult })/n;
	Pan2.ar(wave,0.0); //stereo, panned centre
}.scope;
)



500*[0.5,1,1.19,1.56,2,2.51,2.66,3.01,4.1] //This is a spectral recipe for a minor third bell, at a base frequency of 500- run this line of code to see how the frequencies are calculated from the multipliers





{Mix(SinOsc.ar(440*[0.5,1,1.19,1.56,2,2.51,2.66,3.01,4.1],0,0.1))}.scope //bell spectra, all partials the same volume



I can also give each partial its own amplitude in the mix, rather than defaulting them all to 0.1



{Mix(SinOsc.ar(500*[0.5,1,1.19,1.56,2,2.51,2.66,3.01,4.1],0,0.1*[0.25,1,0.8,0.5,0.9,0.4,0.3,0.6,0.1]))}.scope //bell spectra, different volumes for partials


Here is a generalisable patch that uses the variable n to hold the number of sine tones desired for each run of the code:

(
var n = 25;

{Mix(SinOsc.ar(50*(1..n),0,1/(n*2)*(n..1)))}.scope;

)


If you're unsure what something is in code, investigate it in isolation:

(1..10) //run this line and see what comes up in the post window



/////////////////////////
//OSC
/////////////////
b = NetAddr.new("127.0.0.1", 7001);    // create the NetAddr
b.sendMsg("/hello", "there");    // send the application the message "hello" with the parameter "there"



//////////
///CREAR MUCHOS SYNTHDEFS
(
(2..25).do({ arg nn;

    SynthDef.new('additive'++nn,{
        arg freq;
        var sig, env;
        env = Line.kr(1,0,0.2);
        z = {
            arg index;
            var finalFreq, ff, amp;
            ff = index*freq;
            amp = 0.5/nn;
            finalFreq = freq + ff;
            finalFreq.postln;
            s = SinOsc.ar(finalFreq, 0, amp);
        };

        sig = Mix.fill(nn, z) * env;
        Out.ar(0,sig);
    }).add
});
)
