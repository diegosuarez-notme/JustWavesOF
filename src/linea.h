#ifndef _LINEA_H
#define _LINEA_H

#include "ofMain.h"

class linea : public ofBaseApp{

public:
    linea();
    void set(ofPoint _centro, ofRectangle _arredorRect);
    void setBlobOrigen(ofPoint _centro, ofRectangle _arredorRect);
    void draw(int _id);
    
    bool isInsideMe(ofPoint _centroBlob);
    void setUpdated(bool _updated);
    bool getUpdated();
    
    ofPoint centroBlobOrigen;
    ofRectangle arredorRectBlobOrigen;

    ofPoint centro;
    ofRectangle arredorRect;
    
    bool updated;

};


#endif
