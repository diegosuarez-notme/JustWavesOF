#include "linea.h"

//------------------------------------------------------------------
linea::linea(){
}

void linea::set(ofPoint _centro, ofRectangle _arredorRect){
    centro = _centro;
    arredorRect = _arredorRect;
}

void linea::setBlobOrigen(ofPoint _centro, ofRectangle _arredorRect){
    centroBlobOrigen = _centro;
    arredorRectBlobOrigen = _arredorRect;
}

void linea::setUpdated(bool _updated){
    updated = _updated;
}

bool linea::getUpdated(){
    return updated;
}

void linea::draw(int _id){
	ofEnableSmoothing();
	ofEnableAlphaBlending();
	
    ofSetColor(255, 255, 255, 255);

    ofCircle(centro.x, centro.y, 5);
    ofLine(centro.x, centro.y - (arredorRect.height/2), centro.x, centro.y + (arredorRect.height/2));

    ofSetColor(255, 255, 255, 255);

    ofCircle(centro.x - arredorRect.width, centro.y, 5);
    ofLine(centro.x - arredorRect.width, centro.y - (arredorRect.height/2), centro.x - arredorRect.width, centro.y + (arredorRect.height/2));
    
	ofDisableAlphaBlending();
    
    ofDrawBitmapString(ofToString(_id), centro.x - arredorRect.width-15, centro.y);

	ofDisableSmoothing();    
}

bool linea::isInsideMe(ofPoint _centroBlob){
    if(_centroBlob.x > arredorRectBlobOrigen.x && 
       _centroBlob.x < arredorRectBlobOrigen.x + arredorRectBlobOrigen.width && 
       _centroBlob.y > arredorRectBlobOrigen.y && 
       _centroBlob.y < arredorRectBlobOrigen.y + arredorRectBlobOrigen.height
       ){
        return true;
    }else{
        return false;
    }
}