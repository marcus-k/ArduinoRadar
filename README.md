# Arduino Radar System

Creating an makeshift radar system with an Arduino, HC-SR04 ultrasonic sensor, and SG90 
servo motor.

# Installation

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
The Anaconda distribution of Python was used to install these libraries.

# Troubleshooting

On Linux, one possible issue may be that you do not have permission to read the
`/dev/tty*` ports. I found that following [this](https://askubuntu.com/questions/210177/serial-port-terminal-cannot-open-dev-ttys0-permission-denied)
answer and adding myself to the `dialout` group allowed me to read the files.