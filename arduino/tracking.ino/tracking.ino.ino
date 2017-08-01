#include <Servo.h>

Servo servo;
int pos = 90;
void setup() {
  Serial.begin(9600);
  servo.attach(9);
}

void loop() {
  char input_char;
  int int_from_char;
  if(Serial.available()>0){
    input_char = char(Serial.read());
    
    while(input_char == 'u' && pos<180 ) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
    servo.write(pos);              // tell servo to go to position in variable 'pos'
    pos+=1;
    // waits 15ms for the servo to reach the position
  }
    while(input_char == 'd' && pos >30){
      servo.write(pos);              // tell servo to go to position in variable 'pos'
      pos-=1;
    }
  }
  
  // put your main code here, to run repeatedly:

}
