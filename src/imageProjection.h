#ifndef _IMAGE_PROJECTION_H
#define _IMAGE_PROJECTION_H

#include "ofxOpenCv.h"
#include "ofMain.h"
#include "linea.h"

class imageProjection : public ofBaseApp{

public:
    
    imageProjection();
    
    void update(ofPoint _centro, ofRectangle _arredorRect);
    
    void setup();
    void draw();
    void reset();
    
    void keyPressed(int key);

    vector <linea>  lineas;
    vector <int> probas;
    int xProxeccion;
    
private:
    
    void creaDebuxo(ofPoint _blobPunto, ofRectangle _blobRect);
    void borrarDebuxos();
    ofPoint reubicarPunto(ofPoint _punto);
    ofRectangle reubicarRectangulo(ofRectangle _rect);
    
    int nLineas;
    
};

#endif
