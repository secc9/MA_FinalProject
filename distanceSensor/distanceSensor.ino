
// this is a scrpit for sensing distance


#include <HCSR04.h>



byte triggerPin = 8;
byte echoPin = 9;

void setup(){

     Serial.begin(9600);
     HCSR04.begin(triggerPin, echoPin);
     
}



void loop(){

     double* distances = HCSR04.measureDistanceCm();

     if(distances[0] == -1){
     distances[0] = 4000;
     }

     Serial.print("1: ");
     Serial.print(distances[0]);
     Serial.println(" cm");
     Serial.println("---");

}