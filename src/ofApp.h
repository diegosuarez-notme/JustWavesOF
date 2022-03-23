#pragma once

#include "ofMain.h"
#include "ofxSpout.h"
#include "ofxOpenCv.h"
#include "ofxMidi.h"
#include "ofxOSC.h"
#include "imageProjection.h"
#include "linea.h"
#include "math.h"

#define _USE_LIVE_VIDEO		// uncomment this to use a live camera
								// otherwise, we'll use a movie file

class ofApp : public ofBaseApp{

public:

	void setup();
	void update();
	void draw();
	void exit();

	void keyPressed(int key);
	void keyReleased(int key);
	void mouseMoved(int x, int y);
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased(int x, int y, int button);
	void mouseEntered(int x, int y);
	void mouseExited(int x, int y);
	void windowResized(int w, int h);
	void dragEvent(ofDragInfo dragInfo);
	void gotMessage(ofMessage msg);
	void sendOSCMessage(string s, float v);
	

	

	#define HOST "localhost"  //"localhost"
	#define PORT 57120   //7010  //57120
	#define PIEZA "Color"		// Ferro  Bandeja Pecera

	#ifdef _USE_LIVE_VIDEO
		ofVideoGrabber 		vidGrabber;
	#else
		ofVideoPlayer 		vidPlayer;
	#endif

	imageProjection IP;

	ofPixels videoInverted;
	ofTexture videoTexture;
	int camWidth;
	int camHeight;
	int factReduccionImg;
	int camWidthReduced;
	int camHeightReduced;
	int anchoThumb;
	int altoThumb;

	//OPEN CV
	ofImage colorTransparency;
	ofxCvGrayscaleImage imgMaskTrigger;
	ofxCvColorImage imgMaskColor;
	ofxCvColorImage			rgb,hsb,colorImg,colorImgReduced,greyImage;
	ofxCvGrayscaleImage 	hue,sat,bri,filtered, filtered2, filtered3, filtered4;
	ofxCvGrayscaleImage		filtered5, filtered6, filtered7,filtered8;
	ofxCvGrayscaleImage 	grayBg, grayImage;
	ofxCvGrayscaleImage 	grayDiff;
	ofxCvGrayscaleImage 	circleCentreROI,circleLeftROI,circleRightROI;
	ofxCvGrayscaleImage 	cirCB, cirLB, cirRB; 
	ofxCvGrayscaleImage 	circleCentreBROI, circleLeftBROI, circleRightBROI;
	ofxCvGrayscaleImage		circleGeneralROI;
	ofxCvContourFinder 	contourFinder, contourFinder2, contourFinder3, contourFinder4, contourFinder5;
	ofxCvContourFinder 	contourFinder6, contourFinder7, contourFinder8;
	ofxCvContourFinder 	contourFinderCircleL, contourFinderCircleC, contourFinderCircleR;
	ofFbo fboTrigger;   //mascara para triggers

	// Variables de control
	int		thresholdM;
	int		findHue,findHue1, findHue2, findHue3, findhueRalto, threshold;
	int		margen; //margen de mascara rectangular
	int		hueDifC, hueDifM, hueDifY;
	int		findBright, findSat;
	bool	bLearnBakground;
	bool	lightSent;
	bool	lightSent2;
	bool	bassSent;
	bool    cirLisActive, cirCisActive, cirRisActive;
	int		minArea, maxArea;
	int		minAreaC, maxAreaC;
	int		maxBright,minBright;
	int		ROIx, ROIy;
	int		radioCirculo; //radio del circulo que servira de mascara
	float blobsValues[30];
	int numBlobsValues;
	float numBlobsSumaX;
	float numBlobsSumaY;
	//vector<float> blobsValues;

	//OSC
	ofxOscSender senderOSC;
	ofxOscMessage m;
	float posX, posY;
	float numBlobs;
	float blackArea;

	//MIDI
	void newMidiMessage(ofxMidiMessage& eventArgs);
	ofxMidiIn midiIn;
	std::vector<ofxMidiMessage> midiMessages;
	std::size_t maxMessages = 10; //< max number of messages to keep track of

	string jn;
	ofxSpout::Sender senderSPOUT;

		
};
