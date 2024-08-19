//fredrick olafsson udk160512 

//-miniamal open cv example



import processing.video.*;
import gab.opencv.*;
import oscP5.*;
import netP5.*;

Capture video;
OpenCV opencv;
OscP5 oscP5;
NetAddress receiver;

int downscale = 4; //try with 1, 2, 3, 4, 8

int r=0;
int g=0;
int b=0;


void setup(){
       size(1920, 1080);
     video = new Capture(this, width, height);
     video.start();
     opencv = new OpenCV(this, video.width, video.height);
     opencv.startBackgroundSubtraction(1000, 16, 0.1); //remove the background
     oscP5 = new OscP5(this, 12000);
     receiver = new NetAddress("127.0.0.1", 57120);
}

void captureEvent(Capture video){
     video.read();     
}

void draw(){
     stroke(255, 0, 255);
     opencv.loadImage(video);
     opencv.updateBackground(); //removes background
     scale(downscale, downscale);
     PImage img = opencv.getOutput();
     long total = 0;
     for(int i = 0; i < img.pixels.length; i++){
     	     total = total+int(brightness(img.pixels[i]));
	     }
	total = total / 255;
	image(img, 0, 0);
//	text("total: "+total, 10, 20);
	sendOsc(total);
	

opencv.flip(OpenCV.HORIZONTAL); //flip the image
opencv.brightness(-100); //-255 to 255
//image(opencv.getOutput(), -200, 0); // draws output of open cv image to left of screen

/*
// add some filters
  opencv.dilate();
  opencv.dilate();
  opencv.contrast(2.5); // 1.0 is no change
    opencv.erode();
     opencv.erode();
     opencv.blur(8); // number of pixels
   // opencv.threshold(1);
    opencv.flip(OpenCV.HORIZONTAL); //flip image back
    //image(opencv.getOutput(), width/2, 0); // uncomment for video //right hand image
   // PVector locLightA = opencv.min(); //min pixel light      
    //PVector locLightB = opencv.max(); // max pixxel light

*/

//draw the contours
       fill(0, 255, b);
       stroke(255, 0, b);
       for(Contour contour : opencv.findContours()){
       contour.draw();
       }

b  +=1;

if(b >=255 || b <= 0){
b *= -1;
}

// draw ellipsess tracking the lowest and highest pixel


    strokeWeight(4);
    fill(255,0,0);
   // ellipse(locLightA.x, locLightA.y, 30, 30);
//    ellipse(locLightB.x, locLightB.y, 30, 30);

}


void sendOsc(long t){
     OscMessage msg = new OscMessage("/total");
     msg.add(t);
     oscP5.send(msg, receiver);
}
