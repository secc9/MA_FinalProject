 



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
float myHourlyRate = 18.00;
float dwellTime = 0.30;


//define minimum wages
float minWageOver21 = 11.44;
float minWageUnder21 =8.60;
float minWageUnder18 = 6.40;

float pencePerMinuteOver21;
float pencePerMinuteUnder21;
float pencePerMinuteUnder18;

//Profit loss calculations

float totalIncome;
float totalCostOfLabour;
float profitOrLoss;



//no activity data
int [] lastActivityTimes = new int[4];
int decrementInterval = 60 * 1000; //1 min in milliseconds
float penceDecrement = 01.0;



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

// Calculate pence per min for minimum wages
  pencePerMinuteOver21 = (minWageOver21 * 100) / 60;
  pencePerMinuteUnder21 = (minWageUnder21 * 100) / 60;
  pencePerMinuteUnder18 = (minWageUnder18 * 100) / 60;

for(int i = 0; i < 4; i++){
lastActivityTimes[i] = millis(); //init the last activity times to current time

		     }

}



void draw() {
  background(255);
  fill(0);
  textSize(36);
  textAlign(CENTER, CENTER);



  // Webcam processing and display code
  int y = 600;
  if (video.available() == true) {
    video.read();
    PImage img = createImage(width, height, RGB);
    arrayCopy(video.pixels, img.pixels);
    img.resize(int(random(2, 6)), int(random(120, 180)));
    image(img, 0, 0, width, height);
  }


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

    text("Your time spent with me at sensor: " + cumulativeDays + "." + cumulativeHours + "." + cumulativeMinutes + "." + cumulativeSeconds + ".", width / 2, height / 2 - 200 + i * 50 - y);
  }

  // Calculate and display total cumulative time
  int totalCumulativeDuration = 0;
  for (int i = 0; i < 4; i++) {
    totalCumulativeDuration += cumulativeDurations[i];
  }
  int totalDays = totalCumulativeDuration / (1000 * 60 * 60 * 24);
  int totalHours = (totalCumulativeDuration / (1000 * 60 * 60)) % 24;
  int totalMinutes = (totalCumulativeDuration / (1000 * 60) % 60);
  int totalSeconds = (totalCumulativeDuration / 1000) % 60;

  text("Your time spent with me in total: " + totalDays + "." + totalHours + "." + totalMinutes + "." + totalSeconds + ".", width / 2, height / 2 + 30 - y);

  // Calculate total cost
  float totalCost = (totalCumulativeDuration / (1000 * 60)) * pencePerMinute / 100; // Total cost in pounds

  totalCostOfLabour = totalHrs * myHourlyRate;
  totalIncome = costOfProject + totalCostOfLabour;

//calculate profit or loss
profitOrLoss = totalIncome - costOfProject;

  int n = 40;
  int tY = 400;
  textSize(40);
  textAlign(CENTER, CENTER);
  text("It's all fun and games until you realise you're working for free!", width / 2, 50);

  textSize(35);
  text("Total hours spent on project: " + totalHrs, width / 2, height / 2 - n - tY);
  text("Total cost of project: £" + costOfProject, width / 2, height / 2 - tY);
  text("Hourly rate with current employer: £" + myHourlyRate, width / 2, height / 2 + n - tY);
  text("Minimum wage over 21: £11.44[1]", width / 2, height / 2 + n * 2 - tY);
  text("Minimum wage under 21: £8.60[1]", width / 2, height / 2 + n * 3 - tY);
  text("Minimum wage under 18: £6.40[1]", width / 2, height / 2 + n * 4 - tY);
  textSize(20);
  text("Information Source: [1] Minimum wage rates for 2024, GOV.UK, Aug. 8, 2024. [Online]. Available: https://www.gov.uk/government/publications/minimum-wage-rates-for-2024. [Accessed: Aug. 8, 2024].", width / 2 - 450, height / 2 + n * 4 - tY, 900, 100);

  int boxY = 860;
  int boxLX = 20;
  int boxWidth = 500;
  int boxHeight = 800;

  // Draw the red rectangles
  fill(255, 0, 0, 150);
  rect(boxLX, boxY, boxWidth, boxHeight);

  fill(255, 0, 0, 150);
  rect(600, boxY, boxWidth, boxHeight);

  fill(0);
  String[] items = {
    "Raspberry PI 4", "Raspberry PI 5", "RPI PSU", "Touchscreen", "Soundcard", "Network Switch",
    "128GB SD Card", "RPi Camera v2", "HDMI Cables", "PI5 ActiveCooler", "Heatsink for PI4",
    "PI Cooling Fan", "Stereo Amplifier", "Loudspeaker", "Range Finder", "Arduino"
  };
  String[] quantities = {
    "1", "3", "4", "4", "3", "1", "3", "1", "3", "3", "1", "1", "2", "4", "4", "1"
  };
  String[] costs = {
    "£72", "£76.80", "£11.60", "£59.99", "£3.69", "£19.99", "£10.99", "£10.40", "£10.19",
    "£4.80", "£2.00", "£3.00", "£0.61", "£1.30", "£2.20", "£24"
  };
  String[] totalCosts = {
    "£72", "£230.4", "£46.4", "£239.96", "£11.07", "£19.99", "£32.97", "£10.4", "£30.57",
    "£14.4", "£2.00", "£3.00", "£1.22", "£5.2", "£8.8", "£24"
  };

  textAlign(LEFT, TOP);
  textSize(27);

  int tableY = boxY + 50;
  int rowHeight = 40;

  text("Item", boxLX + 10, tableY);
  text("Qty", boxLX + 200, tableY);
  text("Unit", boxLX + 250, tableY);
  text("Total Cost", boxLX + 350, tableY);

  for (int i = 0; i < items.length; i++) {
    text(items[i], boxLX + 10, tableY + (i + 1) * rowHeight);
    text(quantities[i], boxLX + 200, tableY + (i + 1) * rowHeight);
    text(costs[i], boxLX + 250, tableY + (i + 1) * rowHeight);
    text(totalCosts[i], boxLX + 350, tableY + (i + 1) * rowHeight);
  }

  text("Total:", boxLX + 250, tableY + (items.length + 1) * rowHeight);
  text("£752.38", boxLX + 350, tableY + (items.length + 1) * rowHeight);

  int textRX = 610;
  fill(0);
  textSize(25);
  text("Total cost of project (cost + labour): £" + (costOfProject + (totalHrs * myHourlyRate)), textRX, boxY + 50);
  text("Dwell time calculated at £0.30 per min*", textRX, boxY + 100);
  text("*£18.00 * 100 / 60", textRX, boxY + 130);


  // Calculate total worth of cumulative dwell time for current hourly rate
  float finalTotalMinutes = totalCumulativeDuration / (1000 * 60); // Convert total cumulative duration to minutes
  float totalWorthInPence = finalTotalMinutes * pencePerMinute; // Total worth in pence
  float totalWorthInPounds = totalWorthInPence / 100; // Convert pence to pounds



 // Calculate the total worth of cumulative dwell time for minimum wages
  float totalWorthInPenceOver21 = totalMinutes * pencePerMinuteOver21;
  float totalWorthInPoundsOver21 = totalWorthInPenceOver21 / 100;

  float totalWorthInPenceUnder21 = totalMinutes * pencePerMinuteUnder21;
  float totalWorthInPoundsUnder21 = totalWorthInPenceUnder21 / 100;

  float totalWorthInPenceUnder18 = totalMinutes * pencePerMinuteUnder18;
  float totalWorthInPoundsUnder18 = totalWorthInPenceUnder18 / 100;




//the decrement code
int currentTime = millis();
for (int i = 0; i < 4; i++){
if(currentTime - lastActivityTimes[i] >= decrementInterval){
//decrease the cumulative duratoin equivalent to 30p if no activity
cumulativeDurations[i] -= penceToDuration(penceDecrement);

//Ensure cumulative duration doesnt go below zeero
if(cumulativeDurations[i] < 0){
cumulativeDurations[i] = 0;
}

//update last activity time
lastActivityTimes[i] = currentTime;
		     }
}




  // Display the total worth of cumulative dwell time
  fill(0); // Set text color to black
  textSize(25);
  text("Total worth of cumulative dwell time at £" + nf(hourlyRate, 0, 2) + " per hour:", textRX, boxY + 200);
  text("£" + nf(totalWorthInPounds, 0, 2), textRX, boxY + 240); // nf() formats the number with 2 decimal places


text("Total worth at minimum wage over 21:", textRX, boxY + 290);
  text("£" + nf(totalWorthInPoundsOver21, 0, 2), textRX, boxY + 320);

  text("Total worth at minimum wage under 21:", textRX, boxY + 370);
  text("£" + nf(totalWorthInPoundsUnder21, 0, 2), textRX, boxY + 400);

  text("Total worth at minimum wage under 18:", textRX, boxY + 450);
  text("£" + nf(totalWorthInPoundsUnder18, 0, 2), textRX, boxY + 480);



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


//Update last activity time when a new duration is recieved
	 lastActivityTimes[i] = millis();

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

int penceToDuration(float pence){
//convert pence to duration in millis
float minutes = pence/pencePerMinute;
return int(minutes * 60 * 1000);
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
