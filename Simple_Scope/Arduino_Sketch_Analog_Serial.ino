// This sketch reads analog data on A0 and sends it out to 
// the serial port with each sample terminated by a new line "\n"
// The Processing sketch can then parse the data and plot it graphically.

void setup() {
  Serial.begin(9600);
}

void loop() {
  Serial.print(analogRead(A0));
  Serial.print("\n");
  delay(5);
}
