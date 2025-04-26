
#include "Servo.h"
Servo myservo;
#define servoPin 9
void setup() {
  myservo.attach(servoPin);
  Serial.begin(9600);
}

void servoOpen() {
  myservo.write(180);
}

void servoClose() {
  myservo.write(0);
}

void receiveData() {
  if (Serial.available() > 0) {
    String received_data = Serial.readStringUntil('\n');
    Serial.print("Received from Python: ");
    Serial.println(received_data);
  }
}

void sendData() {
  if (Serial.available() > 0) {
    String request = Serial.readStringUntil('\n');
    if(request == "Request data"){
      Serial.println("Data from Arduino");
    }
  }
}

void loop() {
}