
int echoPin = A1;  
 
int value;
 
void setup(){
  pinMode(echoPin,INPUT); 
  Serial.begin(9600); 
}
void loop()
{
  value = analogRead(echoPin); 
 /* byte firstByte = value / 256;
  byte secondByte = value % 256;
   Serial.write(firstByte);
   Serial.write(secondByte);
   */
    Serial.write(value/5);
   delay(50);
}
