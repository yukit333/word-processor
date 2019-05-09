int A, B;

void setup(){
  //12番ピンをデジタル入力に設定
  pinMode(1,OUTPUT); //信号用ピン
  pinMode(2,OUTPUT); //信号用ピン
  pinMode(11, INPUT);
  pinMode(12, INPUT);
  //13番ピンをデジタル出力に設定
//  pinMode(13, OUTPUT);
  Serial.begin(9600);
  digitalWrite(1,HIGH);
  digitalWrite(2,LOW);
}

void loop(){
  if(digitalRead(11) == HIGH) {
    A = 1;
//    Serial.write(1);
  }else {
    A = 2;
//    Serial.write(2);
  }
  
  if(digitalRead(12) == HIGH) {
    B = 10;
//    Serial.write(3);
  }else {
    B = 20;
//    Serial.write(4);
  }
  
  int writer = A + B;
  
  if(writer == 12 || writer == 21){
    analogWrite(3, 255);
//    digitalWrite(3, HIGH);
  }else {
    analogWrite(3, 160);
  }
  
  Serial.write(writer);

}

