# Arduino Radar System

Code for a simple radar setup using an Arduino UNO, HC-SR04 ultrasonic sensor, SG90 
servo motor, and DHT11 temperature and humidity sensor.

## Table of Contents
* [Installation](#installation)
* [Usage](#usage)
* [Troubleshooting](#troubleshooting)
* [Additional Things to Read](#additional-things-to-read)

## Installation

First, the necessary Arduino libraries should be installed:
- [https://github.com/arduino-libraries/Servo](https://github.com/arduino-libraries/Servo)
- [https://github.com/adafruit/DHT-sensor-library](https://github.com/adafruit/DHT-sensor-library)  

Both of these libraries can be found in the Arduino IDE's Library Manager under 
`Sketch > Include Library > Manage Libraries...`.

Next, the necessary Python libraries should be installed:
- NumPy
- Matplotlib
- PySerial
- Pandas

The Anaconda distribution of Python was used to install these libraries. For convenience:
```
conda install -c conda-forge numpy pandas matplotlib pyserial
```

## Usage

## Troubleshooting

On Linux, one possible issue may be that you do not have permission to read the
`/dev/tty*` ports. I found that following [this](https://askubuntu.com/questions/210177/serial-port-terminal-cannot-open-dev-ttys0-permission-denied)
answer and adding myself to the `dialout` group allowed me to read the files.

## Additional Things to Read