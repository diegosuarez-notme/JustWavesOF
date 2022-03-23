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
	margen = 20;
	ROIx = camWidthReduced / 3;
	ROIy = camHeightReduced;


	//INIZILIZATION
	blackArea = 0;
	radioCirculo = 50;

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

	//PREPARAR MASCARAS
	fboTrigger.allocate(camWidthReduced, camHeightReduced, OF_IMAGE_COLOR_ALPHA); //or GL_RED if you are using the programmable renderer
	fboTrigger.begin();
	ofSetColor(255, 255, 255,0);
	ofFill();
	ofDrawRectangle(0, 0, camWidthReduced, camHeightReduced);
	ofSetColor(0,0,0,255);
	ofFill();
	//ofDrawRectangle(margen, margen, camWidthReduced - margen * 2, camHeightReduced - margen * 2);
	ofDrawRectangle(margen,margen, 10,10);
	fboTrigger.end();

	for (int i = 0; i < camWidthReduced * (camHeightReduced); i++) {
		if (i % camWidthReduced < margen || i / camWidthReduced < margen) {
			fboTrigger.begin();
			ofSetColor(255, 255, 255, 0);
			ofFill();
			ofDrawRectangle(i% camHeightReduced, i/ camWidthReduced, 1, 1);
			fboTrigger.end();

		}
		else {
			fboTrigger.begin();
			ofSetColor(0, 0, 0, 255);
			ofFill();
			ofDrawRectangle(i % camHeightReduced, i / camWidthReduced, 1, 1);
			fboTrigger.end();
		}
	}

	

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
	
	//colorTransparency.allocate(camWidthReduced, camHeightReduced,OF_PIXELS_RGBA);
	rgb.allocate(camWidthReduced, camHeightReduced);
	hsb.allocate(camWidthReduced, camHeightReduced);
	hue.allocate(camWidthReduced, camHeightReduced);
	sat.allocate(camWidthReduced, camHeightReduced);
	bri.allocate(camWidthReduced, camHeightReduced);
	
	circleLeftROI.allocate(ROIx, ROIy);
	circleCentreROI.allocate(ROIx, ROIy);
	circleRightROI.allocate(ROIx, ROIy);
	cirLB.allocate(ROIx, ROIy);
	cirCB.allocate(ROIx, ROIy);
	cirRB.allocate(ROIx, ROIy);
	circleGeneralROI.allocate(camWidthReduced, camHeightReduced);
	circleLeftBROI.allocate(camWidthReduced, camHeightReduced);
	circleCentreBROI.allocate(camWidthReduced, camHeightReduced);
	circleRightBROI.allocate(camWidthReduced, camHeightReduced);
	//imgMaskTrigger.allocate(camWidthReduced, camHeightReduced);
	//imgMaskColor.allocate(camWidthReduced, camHeightReduced);
	//colorTransparency.allocate(camWidthReduced, camHeightReduced,OF_IMAGE_COLOR_ALPHA);
	grayImage.allocate(camWidthReduced, camHeightReduced);
	filtered.allocate(camWidthReduced, camHeightReduced);
	filtered2.allocate(camWidthReduced, camHeightReduced);
	filtered3.allocate(camWidthReduced, camHeightReduced);
	filtered4.allocate(camWidthReduced, camHeightReduced);
	filtered5.allocate(camWidthReduced, camHeightReduced);
	filtered6.allocate(camWidthReduced, camHeightReduced);
	filtered7.allocate(camWidthReduced, camHeightReduced);
	filtered8.allocate(camWidthReduced, camHeightReduced);
	
	//CONTROLES
	bLearnBakground = true;
	thresholdM = 100;
	minArea = 50;
	maxArea = camWidthReduced*camHeightReduced;//(camWidth * camHeight)/20;
	minAreaC = 30;
	maxAreaC = 1500;// ROIx* ROIy; //mejorar a circulo
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
	lightSent2 = false;
	bassSent = false;
	maxBright = 250;
	minBright = 101;
	cirLisActive = false;
	cirCisActive = false; 
	cirRisActive = false;
	numBlobsValues = 0;


						
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
			colorTransparency= colorImg.getPixels();
			//colorTransparency.getTexture().setAlphaMask(fboTrigger.getTexture());

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
			//imgMaskColor = rgb;
			//imgMaskColor.getTexture().setAlphaMask(fboTrigger.getTexture());
			
			if (strcmp(PIEZA, "Color") == 0) {//pecera   se puede quitar para rgbdb y just waves

				

				//duplicate rgb
				hsb = rgb;
				//convert to hsb
				hsb.convertRgbToHsv();
				//store the three channels as grayscale images
				hsb.convertToGrayscalePlanarImages(hue, sat, bri);


				//Circulo izqda
				circleLeftBROI.resetROI();
				circleLeftBROI = bri;
				circleLeftBROI.setROI(ofRectangle(0, 0, ROIx, ROIy));
				cirLB= circleLeftBROI.getRoiPixels();

				//circleLeftROI = circleLeftBROI.getRoiPixels();
				//Circulo cenrto
				circleCentreBROI.resetROI();
				circleCentreBROI = bri;
				circleCentreBROI.setROI(ofRectangle(ROIx, 0, ROIx, ROIy));
				cirCB = circleCentreBROI.getRoiPixels();
				circleCentreROI = circleCentreBROI.getRoiPixels();
				//Circulo dcha
				circleRightBROI.resetROI();
				circleRightBROI = bri;
				circleRightBROI.setROI(ofRectangle(ROIx*2, 0, ROIx, ROIy));
				cirRB = circleRightBROI.getRoiPixels();
				circleRightROI = circleRightBROI.getRoiPixels();
				
				

				//Mascaras
				//imgMaskTrigger = imgMaskColor;
				//imgMaskTrigger.getTexture().setAlphaMask(fboTrigger.getTexture());

				//threshold of hue
				//hue.threshold(threshold);
				//float margen1 = 10;
				//filter image based on the hue value were looking for

				
				for (int i = 0; i < camWidthReduced*(camHeightReduced); i++) {
					//filtered.getPixels()[i] = (ofInRange(hue.getPixels()[i], findHue1 - hueDifC, findHue1 + hueDifC) && ofInRange(sat.getPixels()[i], 100,255)) ? 255 : 0;  //findhue for picked colors
					filtered.getPixels()[i] = ((ofInRange(hue.getPixels()[i], findHue - threshold, findHue + threshold) || ofInRange(hue.getPixels()[i], findhueRalto - threshold, findhueRalto + threshold)) && ofInRange(bri.getPixels()[i], minBright, maxBright) && ofInRange(sat.getPixels()[i], 60, 255)) ? 255 : 0;  //CYAN
					filtered2.getPixels()[i] = (ofInRange(hue.getPixels()[i], findHue2 - threshold, findHue2 + threshold) && ofInRange(bri.getPixels()[i], minBright, maxBright) && ofInRange(sat.getPixels()[i], 60, 255)) ? 255 : 0;
					filtered3.getPixels()[i] = (ofInRange(hue.getPixels()[i], findHue3 - threshold, findHue3 + threshold) && ofInRange(bri.getPixels()[i], minBright, maxBright) && ofInRange(sat.getPixels()[i], 60, 255)) ? 255 : 0;

					
					//filtered 4
					if (i % camWidthReduced < margen || i % camWidthReduced > camWidthReduced - margen || i / camWidthReduced < margen || i / camWidthReduced >camHeightReduced - margen) {
						//filtered4.getPixels()[i] = 255;
						filtered4.getPixels()[i] = ofInRange(bri.getPixels()[i], 110, 255) ? 255 : 0;
						
						//ofLog(OF_LOG_NOTICE, "NEGRO :" );

					}
					else {
						filtered4.getPixels()[i] = 0;
						//ofLog(OF_LOG_NOTICE, "Brillo :");
					}

					//filtered 8 caja
					if (i % camWidthReduced < margen || i % camWidthReduced > camWidthReduced - margen || i / camWidthReduced < margen || i / camWidthReduced >camHeightReduced - margen) {
						//filtered4.getPixels()[i] = 255;
						filtered8.getPixels()[i] = ((ofInRange(hue.getPixels()[i], findHue - threshold, findHue + threshold) || ofInRange(hue.getPixels()[i], findhueRalto - threshold, findhueRalto + threshold)) && ofInRange(bri.getPixels()[i], 130, 255) && ofInRange(sat.getPixels()[i], 60, 255)) ? 255 : 0;

						//ofLog(OF_LOG_NOTICE, "NEGRO :" );

					}
					else {
						filtered8.getPixels()[i] = 0;
						//ofLog(OF_LOG_NOTICE, "Brillo :");
					}

					//filtered 5 circulo izqda
					float res = sqrt(pow(i % camWidthReduced - (ROIx/2), 2) + pow((int)i / camWidthReduced - ROIy / 2, 2));
					if (res < radioCirculo) {
						filtered5.getPixels()[i] = ofInRange(bri.getPixels()[i], 110, 255) && ofInRange(sat.getPixels()[i], 60, 255) ? 255 : 0;

						//ofLog(OF_LOG_NOTICE, "NEGRO :" );

					}
					else {
						filtered5.getPixels()[i] = 0;
						//ofLog(OF_LOG_NOTICE, "Brillo :");
					}

					//filtered 6 circulo centro
					res = sqrt(pow(i % camWidthReduced - (ROIx+ROIx / 2), 2) + pow((int)i / camWidthReduced - ROIy / 2, 2));
					if (res < radioCirculo) {
						filtered6.getPixels()[i] = ofInRange(bri.getPixels()[i], 110, 255) && ofInRange(sat.getPixels()[i], 60, 255) ? 255 : 0;

						//ofLog(OF_LOG_NOTICE, "NEGRO :" );

					}
					else {
						filtered6.getPixels()[i] = 0;
						//ofLog(OF_LOG_NOTICE, "Brillo :");
					}

					//filtered 7 circulo dcha
					res = sqrt(pow(i % camWidthReduced - (ROIx*2+ROIx/2), 2) + pow((int)i / camWidthReduced - ROIy / 2, 2));
					if (res < radioCirculo) {
						filtered7.getPixels()[i] = ofInRange(bri.getPixels()[i], 110, 255) && ofInRange(sat.getPixels()[i], 60, 255) ? 255 : 0;

						//ofLog(OF_LOG_NOTICE, "NEGRO :" );

					}
					else {
						filtered7.getPixels()[i] = 0;
						//ofLog(OF_LOG_NOTICE, "Brillo :");
					}
					

					
				}
				//FOR PARA CIRCULOS
				/*
				for (int i = 0; i < ROIx * (ROIy); i++) {
					//Left circle
					float res = sqrt(pow(i % ROIx - ROIx / 2, 2) + pow((int)i / ROIx - ROIy / 2, 2)); //- ROIx / 2   - ROIy/2
					if (res > radioCirculo) {

						circleLeftROI.getPixels()[i] = 0;

						//ofLog(OF_LOG_NOTICE, "NEGRO :" );

					}
					else {
						circleLeftROI.getPixels()[i] = 255;
						circleLeftROI.getPixels()[i] = ofInRange(cirLB.getPixels()[i], 110, 255) ? 255 : 0;
					}

					//Centre circle
					res = sqrt(pow(i % ROIx - ROIx / 2, 2) + pow((int)i / ROIx - ROIy / 2, 2)); //- ROIx / 2   - ROIy/2
					if (res > radioCirculo) {

						circleCentreROI.getPixels()[i] = 0;

						//ofLog(OF_LOG_NOTICE, "NEGRO :" );

					}
					else {
						//circleCentreROI.getPixels()[i] = 255;
						circleCentreROI.getPixels()[i] = ofInRange(circleCentreROI.getPixels()[i], 110, 255) ? 255 : 0;
					}
					//Right circle
					res = sqrt(pow(i % ROIx - ROIx / 2, 2) + pow((int)i / ROIx - ROIy / 2, 2)); //- ROIx / 2   - ROIy/2
					if (res > radioCirculo) {

						circleRightROI.getPixels()[i] = 0;

						//ofLog(OF_LOG_NOTICE, "NEGRO :" );

					}
					else {
						//circleCentreROI.getPixels()[i] = 255;
						circleRightROI.getPixels()[i] = ofInRange(circleRightROI.getPixels()[i], 110, 255) ? 255 : 0;
					}
				}*/
				


				filtered.flagImageChanged();
				filtered2.flagImageChanged();
				filtered3.flagImageChanged();
				filtered4.flagImageChanged();
				filtered5.flagImageChanged();
				filtered6.flagImageChanged();
				filtered7.flagImageChanged();
				filtered8.flagImageChanged(); 
				//circleLeftROI.flagImageChanged();
				//circleCentreROI.flagImageChanged();
				//circleRightROI.flagImageChanged();

				//run the contour finder on the filtered image to find blobs with a certain hue
				contourFinder.findContours(filtered, minArea, 15000 , 10, false, true);   //R
				contourFinder2.findContours(filtered2, minArea, maxArea, 10, false, true);		//G
				contourFinder3.findContours(filtered3, minArea, maxArea, 10, false, true);		//B
				contourFinder4.findContours(filtered4, maxArea/3, maxArea, 1, false, true); //kick
				contourFinder8.findContours(filtered8, 500, maxArea, 2, false, true); //caja

				//contourFinderCircleL.findContours(circleLeftROI, 1, 15000, 6, false, true);
				//contourFinderCircleC.findContours(circleCentreROI, minAreaC, maxAreaC, 6, false, true);
				//contourFinderCircleR.findContours(circleRightROI, 1, maxAreaC, 6, false, true);
				if (cirLisActive) {
					contourFinder5.findContours(filtered5, minAreaC, maxAreaC, 1, false, true);
				}
				if (cirCisActive) {
					contourFinder6.findContours(filtered6, minAreaC, maxAreaC, 3, false, true);
				}
				if (cirRisActive) {
					contourFinder7.findContours(filtered7, minAreaC, maxAreaC, 3, false, true);
				}

				numBlobsValues = 0;
				numBlobsSumaX = 0;
				numBlobsSumaY = 0;
				if (contourFinder.nBlobs != 0) {
					//numBlobsValues = numBlobsValues+ contourFinder.blobs.size();
					for (int i = 0; i < contourFinder.nBlobs; i++) {
						numBlobsSumaX = numBlobsSumaX + contourFinder.blobs[i].boundingRect.getCenter().x; 
						numBlobsSumaY = numBlobsSumaY + contourFinder.blobs[i].boundingRect.getCenter().y;
						numBlobsValues++;
					}
				}
				if (contourFinder2.nBlobs != 0) {
					//numBlobsValues = numBlobsValues+ contourFinder.blobs.size();
					for (int i = 0; i < contourFinder2.nBlobs; i++) {
						numBlobsSumaX = numBlobsSumaX + contourFinder2.blobs[i].boundingRect.getCenter().x;
						numBlobsSumaY = numBlobsSumaY + contourFinder2.blobs[i].boundingRect.getCenter().y;
						numBlobsValues++;
					}
				}
				if (contourFinder3.nBlobs != 0) {
					//numBlobsValues = numBlobsValues+ contourFinder.blobs.size();
					for (int i = 0; i < contourFinder3.nBlobs; i++) {
						numBlobsSumaX = numBlobsSumaX + contourFinder3.blobs[i].boundingRect.getCenter().x;
						numBlobsSumaY = numBlobsSumaY + contourFinder3.blobs[i].boundingRect.getCenter().y;
						numBlobsValues++;
					}
				}

				

				

				//PRUEBA DE LLEVAR IDs
				/*maxArea/2
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
	
		//NOISE
		// 
		if (numBlobsValues > 0) {
			float mediaX = ofMap(numBlobsSumaX / numBlobsValues, 0, camWidthReduced, -1, 1);
			float mediaY = ofMap(numBlobsSumaY / numBlobsValues, 0, camHeightReduced, 1, 0);
			m.setAddress("/noise");
			m.addIntArg(numBlobsValues);
			m.addFloatArg(mediaX);
			m.addFloatArg(mediaY);
			senderOSC.sendMessage(m);
			//ofLog(OF_LOG_NOTICE, "OSC red " + ofToString(m));
			m.clear();
		}
		else {
			m.setAddress("/noise");
			m.addIntArg(0);
			senderOSC.sendMessage(m);
			//ofLog(OF_LOG_NOTICE, "OSC red 0 " + ofToString(m));
			m.clear();
		}
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

		//LUMINOSIDAD  //KICK
		if (contourFinder4.nBlobs != 0) {
			if (lightSent == false) {
				lightSent = true;
				int num = contourFinder4.blobs.size();
				//ofLog(OF_LOG_NOTICE, "OSC blue NUM " + ofToString(num));

				float a;
				m.setAddress("/light");
				m.addIntArg(num);

				for (int i = 0; i < contourFinder4.nBlobs; i++) {
					ofLog(OF_LOG_NOTICE, "Caja BLob tam " + ofToString(contourFinder4.blobs[i].boundingRect.getArea()));
					a = ofMap(contourFinder4.blobs[i].boundingRect.getArea(), minArea, maxArea, 0, 1);
					posX = ofMap(contourFinder4.blobs[i].boundingRect.getCenter().x, 0, camWidthReduced, 0, 1);
					posY = ofMap(contourFinder4.blobs[i].boundingRect.getCenter().y, 0, camHeightReduced, 0, 1);
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
			m.setAddress("/light");
			m.addIntArg(0);
			senderOSC.sendMessage(m);
			//ofLog(OF_LOG_NOTICE, "OSC blue 0 " + ofToString(m));
			m.clear();
		}

		//LUMINOSIDAD  //CAJA
		if (contourFinder8.nBlobs != 0) {
			if (lightSent2 == false) {
				lightSent2 = true;
				int num = contourFinder8.blobs.size();
				

				float a;
				m.setAddress("/lightSmall");
				m.addIntArg(num);

				for (int i = 0; i < contourFinder8.nBlobs; i++) {
					ofLog(OF_LOG_NOTICE, "Caja BLob tam " + ofToString(contourFinder8.blobs[i].boundingRect.getArea()));
					a = ofMap(contourFinder8.blobs[i].boundingRect.getArea(), minArea, maxArea, 0, 1);
					posX = ofMap(contourFinder8.blobs[i].boundingRect.getCenter().x, 0, camWidthReduced, -1, 1);
					posY = ofMap(contourFinder8.blobs[i].boundingRect.getCenter().y, 0, camHeightReduced, 0, 1);
					string s = ofToString(posX) + "," + ofToString(posY) + "," + ofToString(a);
					m.addStringArg(s);
				}

				senderOSC.sendMessage(m);
				//ofLog(OF_LOG_NOTICE, "OSC blue " + ofToString(m));
				m.clear();
			}
		}
		else {
			lightSent2 = false;
			m.setAddress("/lightSmall");
			m.addIntArg(0);
			senderOSC.sendMessage(m);
			//ofLog(OF_LOG_NOTICE, "OSC blue 0 " + ofToString(m));
			m.clear();
		}

		//CIRCULO IZQDA
		if (contourFinder5.nBlobs != 0) {
			if (bassSent == false) {
				bassSent = true;
				int num = contourFinder5.blobs.size();
				ofLog(OF_LOG_NOTICE, "OSC circ izqda " + ofToString(num));

				float centroX = ROIx / 2;
				float centroY = ROIy;
				float dist = 0;

				float a;
				m.setAddress("/circleLeft");
				m.addIntArg(num);

				for (int i = 0; i < contourFinder5.nBlobs; i++) {
					dist = sqrt(pow(contourFinder5.blobs[i].boundingRect.getCenter().x - centroX, 2) + pow(contourFinder5.blobs[i].boundingRect.getCenter().y - centroY, 2));
					dist = ofMap(dist, 0, radioCirculo, 0, 1);
					a = ofMap(contourFinder5.blobs[i].boundingRect.getArea(), minAreaC, maxAreaC, 0, 1);
					string s = ofToString(posX) + "," + ofToString(posY) + "," + ofToString(a);
					m.addStringArg(s);
				}

				senderOSC.sendMessage(m);
				//ofLog(OF_LOG_NOTICE, "OSC blue " + ofToString(m));
				m.clear();
			}
				
		}
		else {
			bassSent = false;
			m.setAddress("/circleLeft");
			m.addIntArg(0);
			senderOSC.sendMessage(m);
			//ofLog(OF_LOG_NOTICE, "OSC blue 0 " + ofToString(m));
			m.clear();
		}

		//CIRCULO CENTRO
		if (contourFinder6.nBlobs != 0) {

			//lightSent = true;
			int num = contourFinder6.blobs.size();
			//ofLog(OF_LOG_NOTICE, "OSC circ izqda " + ofToString(num));

			float centroX = ROIx+ROIx/2;
			float centroY = ROIy;
			float dist = 0;

			float a;
			m.setAddress("/circleCenter");
			m.addIntArg(num);

			for (int i = 0; i < contourFinder6.nBlobs; i++) {
				dist = sqrt(pow(contourFinder6.blobs[i].boundingRect.getCenter().x - centroX, 2) + pow(contourFinder6.blobs[i].boundingRect.getCenter().y - centroY, 2));
				dist = ofMap(dist, 0, radioCirculo, 0, 1);
				a = ofMap(contourFinder6.blobs[i].boundingRect.getArea(), minAreaC, maxAreaC, 0, 1);
				string s = ofToString(posX) + "," + ofToString(posY) + "," + ofToString(a);
				m.addStringArg(s);
			}

			senderOSC.sendMessage(m);
			//ofLog(OF_LOG_NOTICE, "OSC blue " + ofToString(m));
			m.clear();

		}
		else {
			m.setAddress("/circleCenter");
			m.addIntArg(0);
			senderOSC.sendMessage(m);
			//ofLog(OF_LOG_NOTICE, "OSC blue 0 " + ofToString(m));
			m.clear();
		}

		//CIRCULO CENTRO
		if (contourFinder7.nBlobs != 0) {

			//lightSent = true;
			int num = contourFinder7.blobs.size();
			//ofLog(OF_LOG_NOTICE, "OSC circ izqda " + ofToString(num));

			float centroX = ROIx*2+ROIx/2;
			float centroY = ROIy;
			float dist = 0;

			float a;
			m.setAddress("/circleRight");
			m.addIntArg(num);

			for (int i = 0; i < contourFinder7.nBlobs; i++) {
				dist = sqrt(pow(contourFinder7.blobs[i].boundingRect.getCenter().x - centroX, 2) + pow(contourFinder7.blobs[i].boundingRect.getCenter().y - centroY, 2));
				dist = ofMap(dist, 0, radioCirculo, 0, 1);
				a = ofMap(contourFinder7.blobs[i].boundingRect.getArea(), minAreaC, maxAreaC, 0, 1);
				string s = ofToString(posX) + "," + ofToString(posY) + "," + ofToString(a);
				m.addStringArg(s);
			}

			senderOSC.sendMessage(m);
			//ofLog(OF_LOG_NOTICE, "OSC blue " + ofToString(m));
			m.clear();

		}
		else {
			m.setAddress("/circleRight");
			m.addIntArg(0);
			senderOSC.sendMessage(m);
			//ofLog(OF_LOG_NOTICE, "OSC blue 0 " + ofToString(m));
			m.clear();
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
		//imgMaskTrigger.draw(camWidthReduced*3, 0, camWidthReduced, camHeightReduced); //prueba de mascaras
		//circleLeftROI.drawROI(camWidthReduced * 3, 0, camWidthReduced, camHeightReduced); //prueba de mascaras con imagen
		
		
		
		//segunda fila
		filtered.draw(0, camHeightReduced, camWidthReduced, camHeightReduced);
		filtered2.draw(camWidthReduced, camHeightReduced, camWidthReduced, camHeightReduced);
		filtered3.draw(camWidthReduced *2, camHeightReduced, camWidthReduced, camHeightReduced);
		filtered4.draw(camWidthReduced * 3, camHeightReduced, camWidthReduced, camHeightReduced);
		filtered8.draw(camWidthReduced * 4, camHeightReduced, camWidthReduced, camHeightReduced);
		
		
		//tercera fila
		contourFinder.draw(0, camHeightReduced *2, camWidthReduced, camHeightReduced); //draw the whole contour finder
		contourFinder2.draw(camWidthReduced, camHeightReduced * 2, camWidthReduced, camHeightReduced);
		contourFinder3.draw(camWidthReduced *2, camHeightReduced * 2, camWidthReduced, camHeightReduced);
		contourFinder4.draw(camWidthReduced * 3, camHeightReduced * 2, camWidthReduced, camHeightReduced);
		contourFinder8.draw(camWidthReduced * 4, camHeightReduced * 2, camWidthReduced, camHeightReduced);

		//cuarta fila
		circleLeftROI.draw(camWidthReduced, camHeightReduced * 3, ROIx, ROIy); 
		circleCentreROI.draw(camWidthReduced + ROIx, camHeightReduced * 3, ROIx, ROIy); 
		circleRightROI.draw(camWidthReduced + ROIx*2, camHeightReduced * 3, ROIx, ROIy); 

		contourFinderCircleL.draw(camWidthReduced, camHeightReduced * 3, ROIx, ROIy);
		contourFinderCircleC.draw(camWidthReduced + ROIx, camHeightReduced * 3, ROIx, ROIy);
		contourFinderCircleR.draw(camWidthReduced + ROIx * 2, camHeightReduced * 3, ROIx, ROIy);

		//cirLB.draw(camWidthReduced*2, camHeightReduced * 3, ROIx, ROIy);
		//cirCB.draw(camWidthReduced*2 + ROIx, camHeightReduced * 3, ROIx, ROIy);
		//cirRB.draw(camWidthReduced*2 + ROIx * 2, camHeightReduced * 3, ROIx, ROIy);
		filtered5.draw(camWidthReduced, camHeightReduced * 3, camWidthReduced, camHeightReduced);
		contourFinder5.draw(camWidthReduced, camHeightReduced * 3, camWidthReduced, camHeightReduced);
		filtered6.draw(camWidthReduced * 2, camHeightReduced * 3, camWidthReduced, camHeightReduced);
		contourFinder6.draw(camWidthReduced * 2, camHeightReduced * 3, camWidthReduced, camHeightReduced);
		filtered7.draw(camWidthReduced * 3, camHeightReduced * 3, camWidthReduced, camHeightReduced);
		contourFinder7.draw(camWidthReduced * 3, camHeightReduced * 3, camWidthReduced, camHeightReduced);
		
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
	if (key == 'x' || key == 'X')
	{
		margen--;
		ofLog(OF_LOG_NOTICE, "margen " + ofToString(margen));
	}
	if (key == 'z' || key == 'Z')
	{
		margen++;
		ofLog(OF_LOG_NOTICE, "margen " + ofToString(margen));
	}
	if (key == 'v' || key == 'V')
	{
		radioCirculo++;
		ofLog(OF_LOG_NOTICE, "radioCirculo " + ofToString(radioCirculo));
	}
	if (key == 'c' || key == 'C')
	{
		radioCirculo--;
		ofLog(OF_LOG_NOTICE, "radioCirculo " + ofToString(radioCirculo));
	}

	if (key == 'b' || key == 'B')
	{
		maxAreaC=maxAreaC+1000;
		ofLog(OF_LOG_NOTICE, "maxAreaC " + ofToString(maxAreaC));
	}
	if (key == 'n' || key == 'N')
	{
		maxAreaC = maxAreaC - 1000;
		ofLog(OF_LOG_NOTICE, "maxAreaC " + ofToString(maxAreaC));
	}

	if (key == 'y' || key == 'Y')
	{
		cirLisActive=!cirLisActive;
		ofLog(OF_LOG_NOTICE, "cirLisActive " + ofToString(cirLisActive));
	}
	if (key == 'u' || key == 'U')
	{
		cirCisActive = !cirCisActive;
		ofLog(OF_LOG_NOTICE, "cirCisActive " + ofToString(cirCisActive));
	}
	if (key == 'i' || key == 'I')
	{
		cirRisActive = !cirRisActive;
		ofLog(OF_LOG_NOTICE, "cirRisActive " + ofToString(cirRisActive));
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
	findBright = bri.getPixels()[my * camWidthReduced + mx];
	//findBright = filtered4.getPixels()[my*camWidthReduced + mx];
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
