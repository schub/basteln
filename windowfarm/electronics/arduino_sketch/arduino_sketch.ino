/*
 * Windowfarm
 *
 * this code runs the windowfarm as described here:
 * https://github.com/schub/basteln/wiki/Windowfarm
 *
 */
 
int led = 13; // led connected to pin 13
int pump = 9; // transistor connected to pin 9 running the pump
int dur = 15000; // 15 seconds full pump
int pause = 6 * 60 * 60 * 1000;  // 6 hours pause

// setup
void setup() {
  pinMode(led, OUTPUT);
  pinMode(pump, OUTPUT);
}

// main loop
void loop() {

  digitalWrite(led, HIGH);

  for (int i = 0; i<=255; i++) {
    analogWrite(pump, i);
    delay(10);
  }
  
  delay(dur);
  
  for (int i = 255; i>=0; i--) {
    analogWrite(pump, i);
    delay(10);
  }
  
  digitalWrite(led, LOW);
  
  // wait
  delay(pause);  
}

