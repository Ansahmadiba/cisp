/*
(
SynthDef(\sweepFM2,
{
	| duration = 0.02, freq1 = 800, freq2 = 400, ratio = 1.0, index = 1.0, pan = 0.0 |
		var freq = XLine.ar(freq1,freq2,duration,doneAction:2);
		var modFreq = freq * ratio;
		var depth = modFreq * index;
		var mod = SinOsc.ar(modFreq) * depth;
		var sig	= SinOsc.ar( freq:freq + mod );
		Out.ar(0, Pan2.ar( sig  , pan, 0.1) );
}).add;
)
*/

(fun a
	(line (seq -1 1) (ch 0.05 .1 .3 5)))

(fun b 
	(line (seq -1 1) (ch 0.05 .1 .3 5)))

(fun lowF
	(t
		(rf 0 128)
		(fractRandTimer (line (seq 0.001 0.1) (ch 0.001 0.1 1)))))

(fun highF
	(t
		(rf 0 128)
		(fractRandTimer (0.01 0.1 1.0))))

(~ casper
	(seq lowF lowF lowF lowF))

(sci2
	sweepFM2
	(line
	(/ (st 1.0) (t (rf -40 80) (fractRandTimer (0.001 0.1 1.0 2.0))))
	(/ (st 1.0) (t (rf -40 80) (fractRandTimer (0.001 0.1 1.0 2.0)))))
	:duration (/ (st 1.0) (line (rf -28 50) (fractRandTimer (0.001 0.1 1.0 2.0))))
	:freq1 (~ casper)

	:freq2 (~ casper)
	:ratio (t (ch 1.0 2.0 0.0 0.5) (ch 0.001 0.1 1 7 15))
	:index (t (ch 0.0 0.0 1.0 1.5) (ch 0.001 0.1 1 7 15))
	:pan (rv a b)
	:numSamples (t (ch 1 10 20 30 100 1000) (fractRandTimer (0.001 0.2 0.3 1.0 0.01)))
	)