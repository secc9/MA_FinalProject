#include "ofApp.h"


//--------------------------------------------------------------
void ofApp::setup(){

  ofSetFullscreen(true);



   vector<ofVideoDevice> devices = grabber.listDevices();

    // Print the available devices to the console
    for (size_t i = 0; i < devices.size(); i++) {
        ofLogNotice() << "Device " << i << ": " << devices[i].deviceName 
                      << " (ID: " << devices[i].id << "), Hardware: " 
                      << devices[i].hardwareName;
    }

    
  
    // Set the device ID to the second webcam (e.g., device 1 or another ID you find appropriate)
    grabber.setDeviceID(0);  // Use the ID of your second webcam, adjust if needed

    // Set the desired frame rate and resolution
    grabber.setDesiredFrameRate(30);
    grabber.setup(640, 480);  // Adjust resolution as needed


     // Ensure that the webcam is initialized
    if (grabber.isInitialized()) {
        ofLogNotice() << "Webcam initialized successfully!";
    } else {
        ofLogError() << "Failed to initialize webcam with ID 2!";
    }
    
  //  ofHideCursor();
    targetDir = ofFilePath::getUserHomeDir() + "/Documents/Dev/openFrameworks/apps/myApps/images/bin/data";
    currentImageIndex = 0;
    lastImageSwitchTime = ofGetElapsedTimef();
    interval = 0.1f; // Switch image every n second
    loadInterval = 0.2f; //load the latest image every 1 second
			   
    updateImageList();  // Initial load of images
    
}

//--------------------------------------------------------------
void ofApp::update(){


  grabber.update();

    // Only process the frame if it's new
    if (grabber.isFrameNew()) {
        // Process the webcam frame
    }


  
  //Periodically update the image list
  updateImageList();

  red = 255;
  green=255;
  blue=255;
  red +=1;;


    // Check if it's time to switch to the next image
    if (!images.empty() && ofGetElapsedTimef() - lastImageSwitchTime > interval){
        currentImageIndex = (currentImageIndex + 1) % images.size(); // Loop back to the first image
        lastImageSwitchTime = ofGetElapsedTimef();
    }

    

    //load the latest image every second

    if (ofGetElapsedTimef() - lastImageLoadTime > loadInterval) {
        ofDirectory dir(targetDir);
        dir.allowExt("jpg");
        dir.listDir();
        dir.sort(); // Sort so the latest file is last

        if (dir.size() > 0) {
            // Load the latest image (last in the sorted directory)
            latestImage.load(dir.getPath(dir.size() - 1));
        }
        
        lastImageLoadTime = ofGetElapsedTimef();
    }
   
}


//--------------------------------------------------------------
void ofApp::draw(){

  ofBackground(0,0,0);

 // Draw the webcam feed if initialized and a new frame is available
    if (grabber.isInitialized() && grabber.isFrameNew()) {
        grabber.draw(0, 0, ofGetWidth(), ofGetHeight());
    } else {
        ofLogNotice() << "No new frame from webcam!";
    }

    /*    
  // Draw the webcam feed
    if (grabber.isFrameNew()) {
        grabber.draw(0, 0, ofGetWidth(), ofGetHeight());
    }
    */
  
  ofSetColor(red, green, blue);
  if(!images.empty()){
    images[currentImageIndex].draw(0, 0, ofGetWidth(), ofGetHeight());
      }

  

  //draw the latest image
  ofSetColor(255, 255, 255, 150);
  latestImage.draw(0, 0, ofGetWidth(), ofGetHeight());

    ofSetColor(255, 255, 255, 50);
  grabber.draw(0, 0, ofGetWidth(), ofGetHeight());

  
}

  
//--------------------------------------------------------------
void ofApp::updateImageList(){
    ofDirectory dir(targetDir);
    dir.allowExt("jpg");
  
    // Check if the directory exists before listing
    if (dir.exists()) {
        dir.listDir();


	
    //sort the files by time to ensure newest is last
    dir.sort();

	
        // Load new images that aren't already in the list
        for(int i = 0; i < dir.size() -1; i++){
            string path = dir.getPath(i);
            if(std::find(imagePaths.begin(), imagePaths.end(), path) == imagePaths.end()){
                ofImage img;
                img.load(path);
                images.push_back(img);
                imagePaths.push_back(path);
            }
        }
        
        // Remove images that no longer exist in the directory
        for(int i = imagePaths.size() - 1; i >= 0; i--){
            if(!ofFile::doesFileExist(imagePaths[i])){
                images.erase(images.begin() + i);
                imagePaths.erase(imagePaths.begin() + i);
                if(currentImageIndex >= images.size()){
                    currentImageIndex = 0; // Reset to the first image if out of bounds
                }
            }
        }

	
    } else {
        ofLogError("ofApp") << "Directory does not exist: " << targetDir;
    }
}



//--------------------------------------------------------------
void ofApp::keyPressed(int key){

    if (key == 'f') {
        ofToggleFullscreen(); // Allow toggling fullscreen mode with 'f' key
    }
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

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
