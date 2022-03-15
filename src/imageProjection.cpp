#include "imageProjection.h"

//------------------------------------------------------------------
imageProjection::imageProjection(){
}

void imageProjection::setup(){
    xProxeccion = 1024;
    nLineas = 0;
}

void imageProjection::reset(){
    //lineas.clear();
    if(nLineas > 0){
        for(int i=0; i<nLineas; i++){
            if(!lineas[i].getUpdated()){
                lineas.erase(lineas.begin()+i);
                nLineas = lineas.size();
            }else{
                lineas[i].setUpdated(false);
            }
        }
    }
}

void imageProjection::update(ofPoint _centro, ofRectangle _arredorRect){
    //chekeamos si o blob está dentro da linea
    // primeiro chekeamos si hai algunha linea creada
    if(nLineas > 0){
        bool checkDrawnAtBlob = false;
        for(int i = 0; i < nLineas; i++){
            //Chekeamos si o blob esta dentro dunha linea
            if(lineas[i].isInsideMe(_centro)){
                // if there is a blob inside this line, its boundingRect is updated
                lineas[i].setBlobOrigen(_centro, _arredorRect);
                lineas[i].set(reubicarPunto(_centro), reubicarRectangulo(_arredorRect));
                lineas[i].setUpdated(true);
                
                checkDrawnAtBlob = true;
            }
        }
        // creamos un debuxo si non hai ningún que se corresponda con este blob
        if(!checkDrawnAtBlob){
            creaDebuxo(_centro, _arredorRect);
        }
    // creamos un debuxo si todavía non hai ningún creado
    }else{
        creaDebuxo(_centro, _arredorRect);
    }
}

void imageProjection::draw(){
    for (int i=0; i<lineas.size(); i++) {
        lineas[i].draw(i);
    }
}

void imageProjection::creaDebuxo(ofPoint _blobPunto, ofRectangle _blobRect){
    linea lineaCreada = linea();
    
    // relocalizamos as coordenadas do blob para a proxeccion
    lineaCreada.set(reubicarPunto(_blobPunto), reubicarRectangulo(_blobRect));
    lineaCreada.setBlobOrigen(_blobPunto, _blobRect);
    lineaCreada.setUpdated(true);
    
    // engadimos a lina ao array
    lineas.push_back(lineaCreada);
    nLineas = lineas.size();
}

ofPoint imageProjection::reubicarPunto(ofPoint _punto){
    ofPoint punto;
    float lineaIPX = ofMap(_punto.x, 0, 320, 0, 1024);
    float lineaIPY = ofMap(_punto.y, 0, 240, 0, 768);
    punto.set(lineaIPX + xProxeccion, lineaIPY);

    return punto;
}

ofRectangle imageProjection::reubicarRectangulo(ofRectangle _rect){
    ofRectangle rectangulo;
    rectangulo.x = ofMap(_rect.x, 0, 320, 0, 1024);
    rectangulo.y = ofMap(_rect.y, 0, 240, 0, 768);
    rectangulo.width = ofMap(_rect.width, 0, 320, 0, 1024);
    rectangulo.height = ofMap(_rect.height, 0, 240, 0, 768);
    
    return rectangulo;
}

void imageProjection::borrarDebuxos(){
    lineas.clear();    
    nLineas = 0;
}

//--------------------------------------------------------------
void imageProjection::keyPressed(int key){
	switch(key){
        case 'u':
            borrarDebuxos();
	}
    
}

