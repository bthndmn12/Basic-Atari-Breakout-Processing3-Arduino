
 int pongOne = A1;  
int pongTwo = A2; 
 int firstSensor = 0;    // first analog sensor
int secondSensor = 0;   // second analog sensor
 int inByte = 0;  
void setup(){
  Serial.begin(9600); 
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  establishContact(); 
}
void loop()
{
  if (Serial.available() > 0) {
    inByte = Serial.read();
    firstSensor = analogRead(A1) / 3;
    delay(10);
    secondSensor = analogRead(A2) / 3;

    Serial.write(firstSensor);
    Serial.write(secondSensor);
  }
  
}void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}
