//defines motor encoder
#define ENCA 2
#define ENCB 3

//defines L289N pins
#define IN2 8
#define IN1 9
#define ENA 10


int pos = 0;
float dec_position;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(ENCA, INPUT);
  pinMode(ENCB, INPUT);
  attachInterrupt(digitalPinToInterrupt(ENCA),readEncoder,RISING);

  //picks direction of motor
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(ENA, OUTPUT);
  
  //set motor direction
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  analogWrite(ENA,0);
}

void loop() {
  
  analogWrite(ENA,255);
  delay(1000);
  //analogWrite(ENA,0);
  delay(500);

  //Serial.println(pos);
  //Serial.print(" ");

  //dec_position = (float)pos*12.857; //(float)sin(pos/2)*180/3.814;

  //dec_position = (float)sin(pos*0.2244);
  //Serial.println(dec_position);
  //int a = digitalRead(ENCA);
  //int b = digitalRead(ENCB);

  //Serial.print(5*a);
  //Serial.print(" ");
  //Serial.print(5*b);
  //Serial.println();

}

void readEncoder() {
  int a = digitalRead(ENCA);
  int b = digitalRead(ENCB);

  if(b>0){
    pos++;
  }
  else{
    pos--;
  }
  //dec_position = (float)sin(pos*0.2244);
  //dec_position = (float)pos*12.857;
  //dec_position = (pos);
  dec_position = (float)12.857*(pos%28);
  Serial.println(dec_position);
  Serial.print(" ");
}