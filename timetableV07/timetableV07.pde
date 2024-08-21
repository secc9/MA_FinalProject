






import processing.serial.*;
import processing.video.*;
Capture video;
Serial myPort;
String receivedData = "";
int[] durations = new int[4];
int[] cumulativeDurations = new int[4];
String filePath = "cumulativeDurations.txt";

int totalHrs = 270;
float hourlyRate = 18.00;//my houry rate
float pencePerMinute; //pence per min

float costOfProject = 752.38;



void setup() {

  size(1080, 1920); 
  video = new Capture(this, width, height);
  video.start();
    noSmooth();

//  println("Available serial ports:");
 // println(Serial.list());  // Print list of available serial ports
  // Replace Serial.list()[0] with the appropriate index for your Arduino
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  
  // Load cumulative durations from file
  loadCumulativeDurations();

//calculate pence per min
pencePerMinute = (hourlyRate * 100) /60; //convert houry rate to pence per min

}


/*
void captureEvent(Capture video){
video.read();
}
*/
void draw() {
  background(255);
  fill(0);
  textSize(36);
  textAlign(CENTER, CENTER);
//----------------------------------------------------------------
//-------- This is the background webcam processing code
// webcam pixallation code
  int rndW = int(random(2, 6));
  int rndh = int(random(120, 180));

  if(video.available()==true){
    video.read();
    PImage img = createImage(width, height, RGB);
    arrayCopy(video.pixels, img.pixels);
    img.resize(rndW, rndh); // resize copy to height 1
    	image(img, 0, 0, width, height);
	//filter(BLUR, 5);
  }
//----------------------------------------------------------------
//---------- this is the code for all the text and calculations
 int y = 600;
  // Display the current and cumulative durations for each sensor
  for (int i = 0; i < 4; i++) {
    int currentDuration = durations[i];
    int cumulativeDuration = cumulativeDurations[i];

    int currentMinutes = currentDuration / (1000 * 60);
    int currentSeconds = (currentDuration / 1000) % 60;

    int cumulativeDays = cumulativeDuration / (1000 * 60 * 60 * 24);
    int cumulativeHours = (cumulativeDuration / (1000 * 60 * 60)) % 24;
    int cumulativeMinutes = (cumulativeDuration / (1000 * 60) % 60);
    int cumulativeSeconds = (cumulativeDuration / 1000) % 60;
    
   // text("Sensor " + (i + 1) + " Current Duration: " + currentMinutes + " mins " + currentSeconds + " secs", width / 2, height / 2 - 200 + i * 100-y);
    text("Your time spent with me at sensor: " +cumulativeDays+"."+cumulativeHours+"." + cumulativeMinutes + "." + cumulativeSeconds + ".", width / 2, height / 2 - 200 + i * 50-y);
  }
  
  // calculate and Display total cumulative time in days hours mins
  int totalCumulativeDuration = 0;
  for (int i = 0; i < 4; i++) {
    totalCumulativeDuration += cumulativeDurations[i];
  }
  int totalDays = totalCumulativeDuration / (1000 * 60 * 60 * 24);
  int totalHours= (totalCumulativeDuration / (1000 * 60 * 60))% 24;
  int totalMinutes = (totalCumulativeDuration / (1000 * 60) % 60);
  int totalSeconds = (totalCumulativeDuration / 1000) % 60;
  
  text("Your time spent with me in total: "+ totalDays + "." + totalHours + "." + totalMinutes + "." + totalSeconds + ".", width / 2, height / 2 +30-y);
/*  
  // Debugging: Print durations to console every frame
  for (int i = 0; i < 4; i++) {
    println("Sensor " + (i + 1) + " Current Duration: " + durations[i] + " ms");
    println("Sensor " + (i + 1) + " Cumulative Duration: " + cumulativeDurations[i] + " ms");
  }
*/
//--------------------------------------------------


//calculate total cost
float totalCost = (totalCumulativeDuration / (1000 * 60)) * pencePerMinute / 100; //total cost in pounds



// this is where I'll do the frmatting of my text etc
int n = 40;
int tY = 400; // move this text up or down on the y axis
// title
textSize(40);
textAlign(CENTER, CENTER);
text("It's all fun and games until you realise you're working for free!", width/2, 50 );

textSize(35);
//total hours spent -- MAKE SURE TO UPDATE THIS TO REFLECT THE CORRECT AMOUNT AT THE END OF THE PROJECT
text("Total hours spent on project: "+totalHrs, width/2, height/2-n-tY);
// total cost
text("Total cost of project: £" + costOfProject, width/2, height /2-tY);
//hourly rates
text("My hourly rate in with current employer: £18.00", width/2, height/2+n-tY);
text("Minimum wage over 21: £11.44[1]", width/2, height/2+n*2-tY);
text("Minimum wage under 21: £8.60[1]", width/2, height/2+n*3-tY);
text("Minimum wage under 18: £6.40[1]", width/2, height/2+n*4-tY);
textSize(20);
text("Information Source: [1] Minimum wage rates for 2024, GOV.UK, Aug. 8, 2024. [Online]. Available: https://www.gov.uk/government/publications/minimum-wage-rates-for-2024. [Accessed: Aug. 8, 2024].", width/2-450, height/2+n*4-tY, 900, 100);



//-----------------------


int boxY = 900;
int boxLX = 20;
int boxWidth = 500;
int boxHeight = 800;
int nTxt = 30;

// Draw the red rectangles
fill(255, 0, 0, 150);
rect(boxLX, boxY, boxWidth, boxHeight);

// box right profits (this code is not affected by the table)
fill(255, 0, 0, 150);
rect(600, boxY, boxWidth, boxHeight);

fill(0);
// Table data
String[] items = {
  "Raspberry PI 4",
  "Raspberry PI 5",
  "RPI PSU",
  "Touchscreen",
  "Soundcard",
  "Network Switch",
  "128GB SD Card",
  "RPi Camera v2",
  "HDMI Cables",
  "PI5 ActiveCooler",
  "Heatsink for PI4",
  "PI Cooling Fan",
  "Stereo Amplifier",
  "Loudspeaker",
  "Range Finder",
  "Arduino",
};
String[] quantities = {
   "1", "3", "4", "4", "3", "1", "3", "1", "3", "3", "1", "1", "2", "4", "4", "1"
};
String[] costs = {
  "£72", "£76.80", "£11.60", "£59.99", "£3.69", "£19.99", "£10.99", "£10.40", "£10.19", "£4.80", "£2.00", "£3.00", "£0.61", "£1.30", "£2.20", "£24"
};
String[] totalCosts = {
   "£72", "£230.4", "£46.4", "£239.96", "£11.07", "£19.99", "£32.97", "£10.4", "£30.57", "£14.4", "£2.00", "£3.00", "£1.22", "£5.2", "£8.8","£24"
};

// Draw the table in the left red rectangle
textAlign(LEFT, TOP);
textSize(27);

int tableY = boxY + 50; // Starting Y position for the table
int rowHeight = 40; // Height of each row

// Draw table header
text("Item", boxLX + 10, tableY);
text("Qty", boxLX + 200, tableY);
text("Unit", boxLX + 250, tableY);
text("Total Cost", boxLX + 350, tableY);

// Draw each row
for (int i = 0; i < items.length; i++) {
  text(items[i], boxLX + 10, tableY + (i + 1) * rowHeight);
  text(quantities[i], boxLX + 200, tableY + (i + 1) * rowHeight);
  text(costs[i], boxLX + 250, tableY + (i + 1) * rowHeight);
  text(totalCosts[i], boxLX + 350, tableY + (i + 1) * rowHeight);
}

// Add the total cost at the bottom
text("Total:", boxLX + 250, tableY + (items.length + 1) * rowHeight);
text("£752.38", boxLX + 350, tableY + (items.length + 1) * rowHeight);

}
//-------------------------------------------------


void serialEvent(Serial myPort) {
  receivedData = myPort.readStringUntil('\n');
  receivedData = trim(receivedData);

  // Debugging: Print received data to console
  //println("Received data: " + receivedData);
  
  for (int i = 0; i < 4; i++) {
    if (receivedData.startsWith("SENSOR" + (i + 1) + "_DURATION:")) {
      String durationString = receivedData.substring(("SENSOR" + (i + 1) + "_DURATION:").length()).trim();
    //  println("Duration substring: " + durationString);  // Debugging: Print the substring
      
      try {
        durations[i] = int(durationString);
        // Update cumulative duration
        cumulativeDurations[i] += durations[i];
        
        // Save cumulative durations to file
        saveCumulativeDurations();
        
        // Debugging: Print parsed duration to console
      // println("Parsed duration for Sensor " + (i + 1) + ": " + durations[i] + " ms");
        //println("Updated cumulative duration for Sensor " + (i + 1) + ": " + cumulativeDurations[i] + " ms");
      } catch (NumberFormatException e) {
        println("Error parsing duration for Sensor " + (i + 1) + ": " + receivedData);
      }
    }
  }
}

void loadCumulativeDurations() {
  String[] lines = loadStrings(filePath);
  if (lines != null && lines.length == 4) {
    for (int i = 0; i < 4; i++) {
      try {
        cumulativeDurations[i] = int(lines[i]);
 //       println("Loaded cumulative duration for Sensor " + (i + 1) + ": " + cumulativeDurations[i] + " ms");
      } catch (NumberFormatException e) {
   //     println("Error loading cumulative duration for Sensor " + (i + 1) + ": " + lines[i]);
      }
    }
  } else {
  //  println("No previous cumulative durations found. Starting from 0.");
  }
}

void saveCumulativeDurations() {
  String[] lines = new String[4];
  for (int i = 0; i < 4; i++) {
    lines[i] = str(cumulativeDurations[i]);
  }
  saveStrings(filePath, lines);
 // println("Saved cumulative durations.");
}
