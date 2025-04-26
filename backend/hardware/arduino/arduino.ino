
#include "Servo.h"
Servo myservo;
#define servoPin 9

int buzzerPin = 8;

int C4 = 523;
int E4 = 659;
int G4 = 784;
int C5 = 1064;
// Function to play a note
void playNote(int frequency, int duration) {
  duration = duration * 500;
  tone(buzzerPin, frequency);
  delay(duration);
  noTone(buzzerPin);
}

void playBuzzer() {
  playNote(C4, 1);
  playNote(E4, 1);
  playNote(G4, 1);
  playNote(C5, 1);
  delay(20000);
}


void setup() {
  myservo.attach(servoPin);
  myservo.write(0);
  Serial.begin(9600);
  pinMode(buzzerPin, OUTPUT);
}

void servoDropPills(int count) {
  int currentDeg = 0;
  for (int i = 1; i <= count; i ++) {
    currentDeg += 60;
    delay(1000);
    myservo.write(currentDeg);
  }
  delay(1000);
  playBuzzer();
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
