
#include "Servo.h"
Servo myservo;
#define servoPin 9
void setup() {
  myservo.attach(servoPin);
  Serial.begin(9600);
}

void servoReset() {
  myservo.write(0);
}

void servoDropPills(int count) {
  int currentDeg = 0;
  for (int i = 1; i <= count; i ++) {
    currentDeg += 60;
    delay(1000);
    myservo.write(currentDeg);
  }
}

void handleRequest() {
    int request = Serial.readStringUntil('\n').toInt();
    servoDropPills(request);
}

void loop() {
  if (Serial.available() > 0) {
    handleRequest();
  }
  else {
    myservo.write(0);
  }
}
