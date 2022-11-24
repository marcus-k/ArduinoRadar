#include <Servo.h>

// Trigger and echo pins for the ultrasonic sensor
const int trigPin = 10;
const int echoPin = 11;

const float speedOfSound = 0.034656;  // Calibrated speed of sound in cm/us
long duration;  // Ping travel time in us
int distance; // Distance in cm
int angle;
Servo servo;    // Servo object

void setup() {
    // Setup ultrasonic trigger pin
    pinMode(trigPin, OUTPUT);
    digitalWrite(trigPin, LOW);

    // Setup ultrasonic echo pin
    pinMode(echoPin, INPUT);

    // Attach servo to pin 12
    servo.attach(12);

    // Setup serial output
    Serial.begin(9600);

    // Tell the computer we're ready
    Serial.println("Ready");
}

void loop() {
    if (Serial.available() > 0) {
        // Read the servo angle from the first byte and move to it
        angle = Serial.read();
        servo.write(angle);

        // Wait for the servo to move
        delay(10);

        // Get the distance from the ultrasonic sensor
        distance = calculateDistance();

        // Print the distance to the serial monitor
        output(angle, distance);

        Serial.flush();
    }
}

/* 
*  Print the distance measured by the ultrasonic sensor.
*/
void output(int angle, int distance) {
    Serial.print(angle);
    Serial.print(",");
    Serial.println(distance);
}

/*
*  Returns the distance measured by the ultrasonic sensor.
*/
int calculateDistance() {  
    // Send a 10 microsecond pulse out
    digitalWrite(trigPin, HIGH); 
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);

    // Calculate distance from time it took to receive the signal back
    duration = pulseIn(echoPin, HIGH);
    distance = (duration * speedOfSound) / 2;

    return distance;
}