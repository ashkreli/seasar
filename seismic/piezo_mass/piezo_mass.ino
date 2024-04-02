/******************************************************************************
Piezo_Vibration_Sensor.ino
Example sketch for SparkFun's Piezo Vibration Sensor
  (https://www.sparkfun.com/products/9197)
Jim Lindblom @ SparkFun Electronics
April 29, 2016

- Connect a 1Mohm resistor across the Piezo sensor's pins.
- Connect one leg of the Piezo to GND
- Connect the other leg of the piezo to A0

Vibrations on the Piezo sensor create voltags, which are sensed by the Arduino's
A0 pin. Check the serial monitor to view the voltage generated.

Development environment specifics:
Arduino 1.6.7
******************************************************************************/
const int PIEZO_PIN0 = A0; // Piezo output
const int PIEZO_PIN1 = A1; // Piezo output
const int PIEZO_PIN2 = A2; // Piezo output
void setup() 
{
  Serial.begin(19200);
}

void loop() 
{
  // Read Piezo ADC value in, and convert it to a voltage
  int piezoADC0 = analogRead(PIEZO_PIN0);
  float piezoV0 = piezoADC0 / 1023.0 * 5.0;
  Serial.print(piezoV0); // Print the voltage.
  Serial.print(", ");
  int piezoADC1 = analogRead(PIEZO_PIN1);
  float piezoV1 = piezoADC1 / 1023.0 * 5.0;
  Serial.print(piezoV1); // Print the voltage.
  Serial.print(", ");
  int piezoADC2 = analogRead(PIEZO_PIN2);
  float piezoV2 = piezoADC2 / 1023.0 * 5.0;
  Serial.println(piezoV2); // Print the voltage.
}

