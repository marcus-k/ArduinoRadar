#include <Servo.h>
#include <DHT.h>

// Add DHT sensor
#define DHTTYPE DHT11
#define DHTPIN 2
DHT dht(DHTPIN, DHTTYPE);

// Trigger and echo pins for the ultrasonic sensor
const int trigPin = 10;
const int echoPin = 11;

float humidity;     // Relative humidity in %
float temperature;  // Temperature in C

// Servo object
Servo servo;
long duration;  // Ping travel time in us

// Distance in cm, change depending on your calibration setup
float distance = 30.0;
float speedOfSound; 

void setup() {
    // Setup ultrasonic trigger pin
    pinMode(trigPin, OUTPUT);
    digitalWrite(trigPin, LOW);

    // Setup ultrasonic echo pin
    pinMode(echoPin, INPUT);

    // Setup serial output
    Serial.begin(9600);

    // Start the DHT sensor
    dht.begin();

    // Start the servo on pin 12
    servo.attach(12);
    servo.write(90);

    // Tell the computer we're ready
    Serial.println("Ready");
}

void loop() {
    // Wait a few seconds between measurements.
    delay(2000);

    // Read temperature and humidity
    humidity = dht.readHumidity();
    temperature = dht.readTemperature();

    // Check if any reads failed and exit early (to try again).
    if (isnan(humidity) || isnan(temperature)) {
        Serial.println(F("Failed to read from DHT sensor!"));
        return;
    }

    // Display results
    Serial.print(F("Humidity: "));
    Serial.print(humidity);
    Serial.print(F(" %, Temperature: "));
    Serial.print(temperature);
    Serial.print(F(" C, "));

    // Get speed of sound
    speedOfSound = calculateSpeedOfSound();
    Serial.print("Speed of sound: ");
    Serial.print(speedOfSound, 5);
    Serial.println(" cm/us");
}

/*
*  Get speed of sound in cm/us.
*/
float calculateSpeedOfSound() {  
    // Send a 10us pulse to the ultrasonic sensor
    digitalWrite(trigPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);

    // Measure the duration of the pulse in us
    duration = pulseIn(echoPin, HIGH);

    // Calculate the speed of sound in cm/us
    speedOfSound = (distance * 2.0) / duration;
    
    return speedOfSound;
}