import sys
from glob import glob
from serial import Serial, SerialException


def port_search():
    """
    Search all appropriate ports to see which can connect with PySerial.
    
    """
    # Windows
    if sys.platform.startswith("win"): # Windows
        ports = [f"COM{i:1.0f}" for i in range(1,256)]
    # Linux
    elif sys.platform.startswith("linux") or sys.platform.startswith("cygwin"):
        ports = glob("/dev/tty[A-Za-z]*")
    # Macintosh
    elif sys.platform.startswith("darwin"):
        ports = glob("/dev/tty.*")
    else:
        raise EnvironmentError("Machine Not PySerial Compatible")

    # Check each port to see if it is available
    available_ports = []
    for port in ports:
        if len(port.split("Bluetooth")) > 1:
            continue
        try:
            ser = Serial(port)
            ser.close()
            available_ports.append(port)
        except (OSError, SerialException):
            pass

    return available_ports


if __name__ == "__main__":
    print(port_search())