from serial import Serial
import pandas as pd
from pathlib import Path

port = "/dev/ttyACM0"   # Serial port to use
baudrate = 9600         # Baud rate
timeout = 1             # Timeout
output = "data1.txt"     # Output file

def main():
    # Open serial port. Serial port connection restarts the Arduino.
    ser = Serial(port=port, baudrate=baudrate, timeout=timeout)

    # Wait for Arduino to be ready
    while ser.readline().decode("ascii").strip() != "Ready":
        pass


    # Continuously read data from serial port
    try: 
        speed_values = []
        unit = None

        with open(Path(output), "w") as f:
            while True:
                # Get next line
                line = ser.readline().decode("ascii").strip()
                if not line:
                    continue

                # Parse for speed of sound
                speed, unit = line.split(",")[2].split(":")[1].strip().split()
                speed = float(speed)
                speed_values.append(speed)

                # Write to file
                f.write(line)
                f.write("\n")
                print(line)

    except KeyboardInterrupt:
        print("Interrupted")

    finally:
        ser.close()

    # Get average values
    df = pd.read_table(Path(output), sep=" ", header=0, names=["humidity", "temp", "speed"], usecols=[1, 4, 9])
    print(df.mean())


if __name__ == "__main__":
    main()
