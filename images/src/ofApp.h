#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp{
	public:
		void setup();
		void update();
		void draw();
		
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
  

  ofImage latestImage;
  vector<ofImage> images;
  vector<string> imagePaths; //to track loaded image paths
  int currentImageIndex; // index of the current image
  float lastImageSwitchTime;
  float interval; // time interval between images in seconds

  float refreshInterval; //time interval to refres the dir
  float lastRefreshTime;

  string targetDir; //dir to monitor
  size_t lastImageCount; //to keep track of image loaded

  void updateImageList(); //function to update image list with the new images

  ofVideoGrabber grabber;

  //timer variables fr loading the latest image

  float lastImageLoadTime;
  float loadInterval;
  
  float w = 0;
  float d = 0;
  float r = 0;
  float n = 0;
  float red, green, blue;
  float alpha = 255;

};
