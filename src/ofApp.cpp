#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
	camWidth = 1280;  // try to grab at this size.1280
	camHeight = 720; //720
	factReduccionImg = 4; //reduccion de la imagen para deteccion mas rapida
	camWidthReduced = camWidth / factReduccionImg;
	camHeightReduced = camHeight / factReduccionImg;
	ofLog(OF_LOG_NOTICE, "Camwreduced " +ofToString(camWidthReduced) );
	ofLog(OF_LOG_NOTICE, "CamHreduced " + ofToString(camHeightReduced));
	anchoThumb = ofGetWidth()/3;
	altoThumb = ofGetHeight() / 3;


	//INIZILIZATION
	blackArea = 0;

	#ifdef _USE_LIVE_VIDEO

		//get back a list of devices.
		vector<ofVideoDevice> devices = vidGrabber.listDevices();

		for (size_t i = 0; i < devices.size(); i++) {
			if (devices[i].bAvailable) {
				//log the device
				ofLogNotice() << devices[i].id << ": " << devices[i].deviceName;
			}
			else {
				//log the device and note it as unavailable
				ofLogNotice() << devices[i].id << ": " << devices[i].deviceName << " - unavailable ";
			}
		}
		vidGrabber.setVerbose(true);
		//vidGrabber.setup(camWidth, camHeight);
		vidGrabber.setDeviceID(0);
		vidGrabber.setDesiredFrameRate(60);
		vidGrabber.initGrabber(camWidth, camHeight);
	#else
		camWidth = 640;  // try to grab at this size.
		camHeight = 360;
		vidPlayer.load("GravityAcua640.mov"); //  Magnetic640b GravityAcua640 GravityAlim640
		vidPlayer.play();
		vidPlayer.setLoopState(OF_LOOP_NORMAL);
	#endif
	
	//VIDEO TRANSFORM
	videoInverted.allocate(camWidth, camHeight, OF_PIXELS_RGB);
	videoTexture.allocate(videoInverted);
	ofSetVerticalSync(true);
	//CV
	colorImg.allocate(camWidth, camHeight);
	grayImage.allocate(camWidth, camHeight);
	grayBg.allocate(camWidth, camHeight);
	grayDiff.allocate(camWidth, camHeight);
	colorImgReduced.allocate(camWidth, camHeight);
	//COLOR FINDER
	//reserve memory for cv images

	//rgb.allocate(camWidth, camHeight);
	//hsb.allocate(camWidth, camHeight);
	//hue.allocate(camWidth, camHeight);
	//sat.allocate(camWidth, camHeight);
	//bri.allocate(camWidth, camHeight);
	//grayImage.allocate(camWidth, camHeight);
	//filtered.allocate(camWidth, camHeight);
	//filtered2.allocate(camWidth, camHeight);
	//filtered3.allocate(camWidth, camHeight);
	
	rgb.allocate(camWidthReduced, camHeightReduced);
	hsb.allocate(camWidthReduced, camHeightReduced);
	hue.allocate(camWidthReduced, camHeightReduced);
	sat.allocate(camWidthReduced, camHeightReduced);
	bri.allocate(camWidthReduced, camHeightReduced);
	grayImage.allocate(camWidthReduced, camHeightReduced);
	filtered.allocate(camWidthReduced, camHeightReduced);
	filtered2.allocate(camWidthReduced, camHeightReduced);
	filtered3.allocate(camWidthReduced, camHeightReduced);
	filtered4.allocate(camWidthReduced, camHeightReduced);
	filtered5.allocate(camWidthReduced, camHeightReduced);
	

	bLearnBakground = true;
	thresholdM = 100;
	minArea = 50;
	maxArea = camWidthReduced*camHeightReduced;//(camWidth * camHeight)/20;
	threshold = 20;
	hueDifC = 15;
	hueDifM = 15;
	hueDifY = 18;
	findHue = 20;
	findhueRalto = 190;
	findHue1 = 20;   //r
	findHue2 = 66;  //g
	findHue3 = 116;		//b
	lightSent = false;
	maxBright = 220;
	minBright = 101;
						
	//SPOUT
	senderSPOUT.init("2");
	senderSPOUT.setVerticalSync(true);

	//OSC
	// open an outgoing connection to HOST:PORT
	senderOSC.setup(HOST, PORT);

	//IDS DE BLOBS
	IP.setup();
}

//--------------------------------------------------------------
void ofApp::update(){
	ofBackground(0, 0, 0);
	bool bNewFrame = false;

	#ifdef _USE_LIVE_VIDEO
		vidGrabber.update();
		bNewFrame = vidGrabber.isFrameNew();
		
		
	#else
		vidPlayer.update();
		bNewFrame = vidPlayer.isFrameNew();
	#endif
	//OPNECV
		if (bNewFrame) {

		#ifdef _USE_LIVE_VIDEO
			colorImg.setFromPixels(vidGrabber.getPixels());
		#else
			colorImg.setFromPixels(vidPlayer.getPixels());
		#endif
			colorImgReduced.resize(camWidth, camHeight);
			colorImgReduced = colorImg;
			colorImgReduced.resize(camWidthReduced, camHeightReduced);
			//GET TEXTURE FOR SPOUT
			ofPixels & pixels = colorImg.getPixels();
			/*for (size_t i = 0; i < pixels.size(); i++) {
				videoInverted[i] = pixels[i];
			}*/
			//load the inverted pixels
			//videoTexture.loadData(videoInverted);
			videoTexture.loadData(pixels);
			//SPOUT
			senderSPOUT.send(videoTexture);

			//FIND COLORS
			//copy webcam pixels to rgb image
			rgb= colorImgReduced;
			if (strcmp(PIEZA, "Luminosidad") == 0) {
				float areaTemp = 0;
				blackArea = 0; //se puede quitar?
				grayImage = colorImg;
				//grayDiff.absDiff(grayBg, grayImage);
				grayImage.threshold(threshold);
				//run the contour finder on the filtered image to find blobs with a certain hue
				contourFinder.findContours(grayImage, minArea, maxArea , 80, true, true);
			
				//BLOB ANALYSIS
				numBlobs = contourFinder.nBlobs;
				for (int i = 0; i < contourFinder.nBlobs; i++) {
					contourFinder.blobs[i].draw(camWidthReduced, camHeightReduced);
					if (i > 0) {
						areaTemp = contourFinder.blobs[i].boundingRect.getArea();
					}
					//posX = contourFinder.blobs[i].boundingRect.getCenter().x;
					//posY = contourFinder.blobs[i].boundingRect.getCenter().y;
					//ofLog(OF_LOG_NOTICE, "NumBlobs "+ ofToString(numBlobs) + "Blob: " + ofToString(i) + +" New Area is " + ofToString(areaTemp) +" x "+ ofToString(posX) +" y "+ ofToString(posY));
					if (areaTemp > blackArea && areaTemp < camWidth*camHeight) {
						blackArea = areaTemp;
						ofLog(OF_LOG_NOTICE, "Max Area is " + ofToString(blackArea));
						posX = contourFinder.blobs[i].boundingRect.getCenter().x;
						posY = contourFinder.blobs[i].boundingRect.getCenter().y;
					}
					// draw over the centroid if the blob is a hole
					ofSetColor(255);
					if (contourFinder.blobs[i].hole) {
						//ofDrawBitmapString("hole",
						//	contourFinder.blobs[i].boundingRect.getCenter().x + camWidth,
						//	contourFinder.blobs[i].boundingRect.getCenter().y + camHeight);
					}
				}
			}
			else if (strcmp(PIEZA, "Color") == 0) {//pecera


				//duplicate rgb
				hsb = rgb;
				//convert to hsb
				hsb.convertRgbToHsv();
				//store the three channels as grayscale images
				hsb.convertToGrayscalePlanarImages(hue, sat, bri);
				//threshold of hue
				//hue.threshold(threshold);
				//filter image based on the hue value were looking for
				for (int i = 0; i < camWidthReduced*(camHeightReduced); i++) {
					//filtered.getPixels()[i] = (ofInRange(hue.getPixels()[i], findHue1 - hueDifC, findHue1 + hueDifC) && ofInRange(sat.getPixels()[i], 100,255)) ? 255 : 0;  //findhue for picked colors
					filtered.getPixels()[i] =( (ofInRange(hue.getPixels()[i], findHue - threshold, findHue + threshold)|| ofInRange(hue.getPixels()[i], findhueRalto - threshold, findhueRalto + threshold)) && ofInRange(bri.getPixels()[i], minBright, maxBright)&& ofInRange(sat.getPixels()[i], 60, 255)) ? 255 : 0;  //CYAN
					filtered2.getPixels()[i] =( ofInRange(hue.getPixels()[i], findHue2 - threshold, findHue2 + threshold) && ofInRange(bri.getPixels()[i], minBright, maxBright) && ofInRange(sat.getPixels()[i], 60, 255)) ? 255 : 0;
					filtered3.getPixels()[i] = (ofInRange(hue.getPixels()[i], findHue3 - threshold, findHue3 + threshold) && ofInRange(bri.getPixels()[i], minBright, maxBright) && ofInRange(sat.getPixels()[i], 60, 255)) ? 255 : 0;
					filtered4.getPixels()[i] = (ofInRange(sat.getPixels()[i], 0, 60) && ofInRange(bri.getPixels()[i], 220, 255)) ? 255 : 0;
					filtered5.getPixels()[i] = (ofInRange(sat.getPixels()[i], 0, 60) && ofInRange(bri.getPixels()[i], 220, 255)) ? 255 : 0;
				}
				filtered.flagImageChanged();
				filtered2.flagImageChanged();
				filtered3.flagImageChanged();
				filtered4.flagImageChanged();
				//run the contour finder on the filtered image to find blobs with a certain hue
				contourFinder.findContours(filtered, minArea, maxArea , 10, false, true);
				contourFinder2.findContours(filtered2, minArea, maxArea, 10, false, true);
				contourFinder3.findContours(filtered3, minArea, maxArea, 10, false, true);
				contourFinder4.findContours(filtered4, minArea*2, maxArea, 1, false, true);
				contourFinder5.findContours(filtered4, minArea, maxArea, 1, false, true);

				//PRUEBA DE LLEVAR IDs
				/*
				IP.reset();
				for (int i = 0; i < contourFinder.nBlobs; i++) {
					IP.update(contourFinder.blobs[i].centroid, contourFinder.blobs[i].boundingRect);
				}
				float nu = IP.lineas.size();
				ofLog(OF_LOG_NOTICE,"BLobs IDsNum :"+ofToString(nu));
				*/

			}
			
			

			
			//EXAMPLE
			/*grayImage = colorImg;
			if (bLearnBakground == true) {
				grayBg = grayImage;		// the = sign copys the pixels from grayImage into grayBg (operator overloading)
				bLearnBakground = false;
			}
			// take the abs value of the difference between background and incoming and then threshold:
			grayDiff.absDiff(grayBg, grayImage);
			grayDiff.threshold(threshold);
			*/

			

			// find contours which are between the size of 20 pixels and 1/3 the w*h pixels.
			// also, find holes is set to true so we will get interior contours as well....
			//contourFinder.findContours(grayDiff, 20, (340 * 240) / 3, 10, true);	// find holes
		}


		//////// /OSC SEND
		

		if (strcmp(PIEZA, "Luminosidad") == 0) {
			if (contourFinder.nBlobs != 0) {
				//posX = ofMap(contourFinder.blobs[0].boundingRect.getCenter().x, 0, 640, 0, 1);
				//posY = ofMap(contourFinder.blobs[0].boundingRect.getCenter().y, 0, 480, 0, 1);
				float x = ofMap(posX, 0, camWidth, 0, 1);
				float y = ofMap(posY, 0, camHeight, 0, 1);
				float a = ofMap(blackArea, minArea, maxArea, 0, 1);
				float n = ofMap(numBlobs, 0, 80, 0, 100);
				ofLog(OF_LOG_NOTICE, "OSC NumBlobs " + ofToString(numBlobs) + " Area " + ofToString(a) + "posX " + ofToString(x)+" posY " + ofToString(y));
				sendOSCMessage("/black/posX", x);
				sendOSCMessage("/black/posY", y);
				sendOSCMessage("/black/numBlobs", n);
				sendOSCMessage("/black/area", a);
			}
		}
		else {
			//RED
			if (contourFinder.nBlobs != 0) {
				int num = contourFinder.blobs.size();
				//ofLog(OF_LOG_NOTICE, "OSC red NUM " + ofToString(num));
				
				float a;
				m.setAddress("/red");
				m.addIntArg(num);
				int cont = 0;
				for (int i = 0; i < contourFinder.nBlobs;i++) {
					a = ofMap(contourFinder.blobs[i].boundingRect.getArea(),minArea,maxArea,0,1);
					posX = ofMap(contourFinder.blobs[i].boundingRect.getCenter().x, 0, camWidthReduced, 0, 1);
					posY = ofMap(contourFinder.blobs[i].boundingRect.getCenter().y, 0, camHeightReduced, 0, 1);
					string s = ofToString(posX) + "," + ofToString(posY) + "," + ofToString(a);
					m.addStringArg(s);
					cont++;
				}
				if (cont < 10) {
					for (int i = cont; i < 10; i++) {

						string s = ofToString(0) + "," + ofToString(0) + "," + ofToString(0);
						m.addStringArg(s);
						
					}

				}
				
				senderOSC.sendMessage(m);
				//ofLog(OF_LOG_NOTICE, "OSC red " + ofToString(m));
				m.clear();
			}
			else {
				m.setAddress("/red");
				m.addIntArg(0);
				senderOSC.sendMessage(m);
				//ofLog(OF_LOG_NOTICE, "OSC red 0 " + ofToString(m));
				m.clear();
			}


			//GREEN
			if (contourFinder2.nBlobs != 0) {
				int num = contourFinder2.blobs.size();
				//ofLog(OF_LOG_NOTICE, "OSC green NUM " + ofToString(num));

				float a;
				m.setAddress("/green");
				m.addIntArg(num);
				int cont = 0;
				for (int i = 0; i < contourFinder2.nBlobs; i++) {
					a = ofMap(contourFinder2.blobs[i].boundingRect.getArea(), minArea, maxArea, 0, 1);
					posX = ofMap(contourFinder2.blobs[i].boundingRect.getCenter().x, 0, camWidthReduced, 0, 1);
					posY = ofMap(contourFinder2.blobs[i].boundingRect.getCenter().y, 0, camHeightReduced, 0, 1);
					string s = ofToString(posX) + "," + ofToString(posY) + "," + ofToString(a);
					m.addStringArg(s);
					cont++;
				}
				if (cont < 10) {
					for (int i = cont; i < 10; i++) {

						string s = ofToString(0) + "," + ofToString(0) + "," + ofToString(0);
						m.addStringArg(s);

					}

				}

				senderOSC.sendMessage(m);
				//ofLog(OF_LOG_NOTICE, "OSC green " + ofToString(m));
				m.clear();
			}
			else {
				m.setAddress("/green");
				m.addIntArg(0);
				senderOSC.sendMessage(m);
				//ofLog(OF_LOG_NOTICE, "OSC green 0 " + ofToString(m));
				m.clear();
			}


			//BLUE
			if (contourFinder3.nBlobs != 0) {
				int num = contourFinder3.blobs.size();
				//ofLog(OF_LOG_NOTICE, "OSC blue NUM " + ofToString(num));

				float a;
				m.setAddress("/blue");
				m.addIntArg(num);
				int cont = 0;
				for (int i = 0; i < contourFinder3.nBlobs; i++) {
					a = ofMap(contourFinder3.blobs[i].boundingRect.getArea(), minArea, maxArea, 0, 1);
					posX = ofMap(contourFinder3.blobs[i].boundingRect.getCenter().x, 0, camWidthReduced, 0, 1);
					posY = ofMap(contourFinder3.blobs[i].boundingRect.getCenter().y, 0, camWidthReduced, 0, 1);
					string s = ofToString(posX) + "," + ofToString(posY) + "," + ofToString(a);
					m.addStringArg(s);
					cont++;
				}
				if (cont < 10) {
					for (int i = cont; i < 10; i++) {

						string s = ofToString(0) + "," + ofToString(0) + "," + ofToString(0);
						m.addStringArg(s);

					}

				}

				senderOSC.sendMessage(m);
				//ofLog(OF_LOG_NOTICE, "OSC blue " + ofToString(m));
				m.clear();
			}
			else {
				m.setAddress("/blue");
				m.addIntArg(0);
				senderOSC.sendMessage(m);
				//ofLog(OF_LOG_NOTICE, "OSC blue 0 " + ofToString(m));
				m.clear();
			}

			//LUMINOSIDAD
			if (contourFinder4.nBlobs != 0) {
				int num = contourFinder4.blobs.size();
				//ofLog(OF_LOG_NOTICE, "OSC blue NUM " + ofToString(num));

				float a;
				m.setAddress("/light");
				m.addIntArg(num);

				for (int i = 0; i < contourFinder4.nBlobs; i++) {
					a = ofMap(contourFinder4.blobs[i].boundingRect.getArea(), minArea, maxArea, 0, 1);
					posX = ofMap(contourFinder4.blobs[i].boundingRect.getCenter().x, 0, camWidth, 0, 1);
					posY = ofMap(contourFinder4.blobs[i].boundingRect.getCenter().y, 0, camHeight, 0, 1);
					string s = ofToString(posX) + "," + ofToString(posY) + "," + ofToString(a);
					m.addStringArg(s);
				}

				senderOSC.sendMessage(m);
				//ofLog(OF_LOG_NOTICE, "OSC blue " + ofToString(m));
				m.clear();
			}
			else {
				m.setAddress("/light");
				m.addIntArg(0);
				senderOSC.sendMessage(m);
				//ofLog(OF_LOG_NOTICE, "OSC blue 0 " + ofToString(m));
				m.clear();
			}

			//LUMINOSIDAD 2
			if (contourFinder5.nBlobs != 0) {
				if (lightSent==false) {
					lightSent = true;
					int num = contourFinder5.blobs.size();
					//ofLog(OF_LOG_NOTICE, "OSC blue NUM " + ofToString(num));

					float a;
					m.setAddress("/lightSmall");
					m.addIntArg(num);

					for (int i = 0; i < contourFinder5.nBlobs; i++) {
						a = ofMap(contourFinder5.blobs[i].boundingRect.getArea(), minArea, maxArea, 0, 1);
						posX = ofMap(contourFinder5.blobs[i].boundingRect.getCenter().x, 0, camWidth, 0, 1);
						posY = ofMap(contourFinder5.blobs[i].boundingRect.getCenter().y, 0, camHeight, 0, 1);
						string s = ofToString(posX) + "," + ofToString(posY) + "," + ofToString(a);
						m.addStringArg(s);
					}

					senderOSC.sendMessage(m);
					//ofLog(OF_LOG_NOTICE, "OSC blue " + ofToString(m));
					m.clear();
				}
			}
			else {
				lightSent = false;
				m.setAddress("/lightSmall");
				m.addIntArg(0);
				senderOSC.sendMessage(m);
				//ofLog(OF_LOG_NOTICE, "OSC blue 0 " + ofToString(m));
				m.clear();
			}

		}
		
		
		
			

		////////// OSC END
	

}

//--------------------------------------------------------------
void ofApp::draw(){
	ofSetHexColor(0xffffff);
	//vidGrabber.draw(20, 20);
	//videoTexture.draw(0, 0);// +camWidth, 20, camWidth, camHeight);

	//EXAMPLE OPENCV
	/*colorImg.draw(20, 20);
	grayImage.draw(360, 20);
	grayBg.draw(20, 280);
	grayDiff.draw(360, 280);*/

	//COLOR FINDER
	 //draw all cv images
	if (strcmp(PIEZA, "Ferro")==0) {
		rgb.draw(0, 0);
		grayImage.draw(camWidth,0);
		contourFinder.draw(0, camHeight); //draw the whole contour finder
	}
	else {
		//Primera fila
		//rgb.draw(0, 0, anchoThumb, altoThumb);
		rgb.draw(0, 0, camWidthReduced, camHeightReduced);
		hue.draw(camWidthReduced, 0, camWidthReduced, camHeightReduced);
		sat.draw(camWidthReduced * 2, 0, camWidthReduced, camHeightReduced);
		bri.draw(camWidthReduced *3, 0, camWidthReduced, camHeightReduced);
		
		
		//segunda fila
		filtered.draw(0, camHeightReduced, camWidthReduced, camHeightReduced);
		filtered2.draw(camWidthReduced, camHeightReduced, camWidthReduced, camHeightReduced);
		filtered3.draw(camWidthReduced *2, camHeightReduced, camWidthReduced, camHeightReduced);
		filtered4.draw(camWidthReduced * 3, camHeightReduced, camWidthReduced, camHeightReduced);
		
		
		//tercera fila
		contourFinder.draw(0, camHeightReduced *2, camWidthReduced, camHeightReduced); //draw the whole contour finder
		contourFinder2.draw(camWidthReduced, camHeightReduced * 2, camWidthReduced, camHeightReduced);
		contourFinder3.draw(camWidthReduced *2, camHeightReduced * 2, camWidthReduced, camHeightReduced);
		contourFinder4.draw(camWidthReduced * 3, camHeightReduced * 2, camWidthReduced, camHeightReduced);
		
		//draw  circles for found blobs
		for (int i = 0; i < contourFinder.nBlobs; i++) {
			ofColor c = ofColor::fromHsb(findHue, findSat, findBright); //findhue for picked
			ofSetColor(c);
			ofFill();
			ofCircle(contourFinder.blobs[i].centroid.x, contourFinder.blobs[i].centroid.y, 20);
		}
		//draw  circles for found blobs
		for (int i = 0; i < contourFinder2.nBlobs; i++) {
			ofColor c = ofColor::fromHsb(findHue2, 230, 255);
			ofSetColor(c);
			ofFill();
			ofCircle(contourFinder2.blobs[i].centroid.x, contourFinder2.blobs[i].centroid.y, 20);
		}
		//draw red circles for found blobs
		for (int i = 0; i < contourFinder3.nBlobs; i++) {
			ofColor c = ofColor::fromHsb(findHue3, 230, 255);
			ofSetColor(c);
			ofFill();
			ofCircle(contourFinder3.blobs[i].centroid.x, contourFinder3.blobs[i].centroid.y, 20);
		}
		// or, instead we can draw each blob individually from the blobs vector,
		// this is how to get access to them:
		/*
		for (int i = 0; i < contourFinder.nBlobs; i++) {
			contourFinder.blobs[i].draw(camWidth, camHeight);

			// draw over the centroid if the blob is a hole
			ofSetColor(255);
			if (contourFinder.blobs[i].hole) {
				ofDrawBitmapString("hole",
					contourFinder.blobs[i].boundingRect.getCenter().x + camWidth,
					contourFinder.blobs[i].boundingRect.getCenter().y + camHeight);
			}
		}
		*/
		//DRAW HUE TO SEARCH
		ofColor c1 = ofColor::fromHsb(findHue1, 255, 255);
		ofSetColor(c1);
		ofFill();
		ofCircle(10, 10, 20);
		c1 = ofColor::fromHsb(findHue2, 255, 255);
		ofSetColor(c1);
		ofFill();
		ofCircle(30, 10, 20);
		c1 = ofColor::fromHsb(findHue3, 255, 255);
		ofSetColor(c1);
		ofFill();
		ofCircle(60, 10, 20);

		c1 = ofColor::fromHsb(findHue, findSat, findBright);
		ofSetColor(c1);
		ofFill();
		ofCircle(150, 10, 20);
	}//END PIEZAS BANDEJA Y PECERA
	

	// finally, a report:
	ofSetHexColor(0xffffff);
	stringstream reportStr;
	reportStr << "Detecion de formas y colores" << endl
		<< "  " << endl
		<< "threshold " << threshold << " (presiona: +/-)" << endl
		<< "blobs R " << contourFinder.nBlobs << " Blobs G " << contourFinder2.nBlobs << " Blobs B " << contourFinder3.nBlobs << endl
		<< "Fps: " << ofGetFrameRate() << endl
		<< "Hue Search: " << findHue1 << "," << findHue2 << ","<<findHue3 << " ,Hue selected: " << findHue << ", Bright: " << findBright << ", Sat: " << findSat << endl
		<< "Hue difC: " << hueDifC << ",Hue difM: " << hueDifM << ", Hue difY: " << hueDifY ;
	ofDrawBitmapString(reportStr.str(), 20, 600);

	//MIDI
	for (unsigned int i = 0; i < midiMessages.size(); ++i) {

		ofxMidiMessage &message = midiMessages[i];
		int x = 10;
		int y = i * 40 + 40;

		// draw the last recieved message contents to the screen,
		// this doesn't print all the data from every status type
		// but you should get the general idea
		stringstream text;
		text << ofxMidiMessage::getStatusString(message.status);
		while (text.str().length() < 16) { // pad status width
			text << " ";
		}

		ofSetColor(127);
		if (message.status < MIDI_SYSEX) {
			text << "chan: " << message.channel;
			if (message.status == MIDI_CONTROL_CHANGE) {
				text << "\tctl: " << message.control;
				ofDrawRectangle(x + ofGetWidth()*0.2, y + 12,
					ofMap(message.control, 0, 127, 0, ofGetWidth()*0.2), 10);
			}
			else if (message.status == MIDI_PITCH_BEND) {
				text << "\tval: " << message.value;
				ofDrawRectangle(x + ofGetWidth()*0.2, y + 12,
					ofMap(message.value, 0, MIDI_MAX_BEND, 0, ofGetWidth()*0.2), 10);
			}
			else {
				text << "\tpitch: " << message.pitch;
				ofDrawRectangle(x + ofGetWidth()*0.2, y + 12,
					ofMap(message.pitch, 0, 127, 0, ofGetWidth()*0.2), 10);

				text << "\tvel: " << message.velocity;
				ofDrawRectangle(x + (ofGetWidth()*0.2 * 2), y + 12,
					ofMap(message.velocity, 0, 127, 0, ofGetWidth()*0.2), 10);
			}
			text << " "; // pad for delta print
		}

		text << "delta: " << message.deltatime;
		ofSetColor(0);
		ofDrawBitmapString(text.str(), x, y);
		text.str(""); // clear
	}
	
	

}
//--------------------------------------------------------------


//--------------------------------------------------------------
void ofApp::keyPressed(int key){
	// in fullscreen mode, on a pc at least, the 
	// first time video settings the come up
	// they come up *under* the fullscreen window
	// use alt-tab to navigate to the settings
	// window. we are working on a fix for this...

	// Video settings no longer works in 10.7
	// You'll need to compile with the 10.6 SDK for this
	// For Xcode 4.4 and greater, see this forum post on instructions on installing the SDK
	// http://forum.openframeworks.cc/index.php?topic=10343
	if (key == 's' || key == 'S') {
		//vidGrabber.videoSettings.focus=10;
		#ifdef _USE_LIVE_VIDEO
			vidGrabber.videoSettings();
		#endif
		
	}
	if (key == 'q' || key == 'Q')
	{
		minArea++;
		ofLog(OF_LOG_NOTICE, "minSizeM " + ofToString(minArea));
	}
	if (key == 'a' || key == 'A')
	{
		minArea--;
		ofLog(OF_LOG_NOTICE, "minSizeM " + ofToString(minArea));
	}
	if (key == 'w' || key == 'W')
	{
		hueDifC++;
		ofLog(OF_LOG_NOTICE, "hueDifC " + ofToString(hueDifC));
	}
	if (key == 's' || key == 'S')
	{
		hueDifC--;
		ofLog(OF_LOG_NOTICE, "hueDifC " + ofToString(hueDifC));
	}
	if (key == 'e' || key == 'E')
	{
		hueDifM++;
		ofLog(OF_LOG_NOTICE, "hueDifM " + ofToString(hueDifM));
	}
	if (key == 'd' || key == 'D')
	{
		hueDifM--;
		ofLog(OF_LOG_NOTICE, "hueDifM " + ofToString(hueDifM));
	}
	if (key == 'r' || key == 'R')
	{
		hueDifY++;
		ofLog(OF_LOG_NOTICE, "hueDifY " + ofToString(hueDifY));
	}
	if (key == 'f' || key == 'F')
	{
		hueDifY--;
		ofLog(OF_LOG_NOTICE, "hueDifY " + ofToString(hueDifY));
	}
	switch (key) {
	case ' ':
		bLearnBakground = true;
		break;
	case '+':
		threshold++;
		if (threshold > 255) threshold = 255;
		break;
	case '-':
		threshold--;
		if (threshold < 0) threshold = 0;
		break;
	}
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
	//calculate local mouse x,y in image
	//float sx =  camWidthReduced/anchoThumb;
	//float sy =camHeightReduced/ altoThumb ;
	int mx = (x % camWidthReduced);
	int my = (y % camHeightReduced);

	//get hue value on mouse position
	//findHue = hue.getPixels()[my*camWidth + mx];
	findHue = hue.getPixels()[my*camWidthReduced + mx];
	findBright = bri.getPixels()[my*camWidthReduced + mx];
	findSat = sat.getPixels()[my*camWidthReduced + mx];

	//ofLog(OF_LOG_NOTICE, "Escala " + ofToString(sx));
	ofLog(OF_LOG_NOTICE, "Multiplicador x " + ofToString(mx));
	ofLog(OF_LOG_NOTICE, "Multiplicador y " + ofToString(my));
}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
//--------------------------------------------------------------
void ofApp::exit() {

	// clean up
	midiIn.closePort();
	//midiIn.removeListener(this);
}
//--------------------------------------------------------------
void ofApp::newMidiMessage(ofxMidiMessage& msg) {

	// add the latest message to the message queue
	midiMessages.push_back(msg);

	// remove any old messages if we have too many
	while (midiMessages.size() > maxMessages) {
		midiMessages.erase(midiMessages.begin());
	}
}

//--------------------------------------------------------------
void ofApp::sendOSCMessage(string s,float v) {

	ofxOscMessage m;
	m.setAddress(s);
	m.addFloatArg(v);
	senderOSC.sendMessage(m);
}