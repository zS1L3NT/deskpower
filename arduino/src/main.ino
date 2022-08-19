#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

#define D0 16
#define D1 5

HTTPClient http;
WiFiClient wifi;

void setup()
{
  Serial.begin(9600);

  pinMode(D0, OUTPUT);
  pinMode(D1, OUTPUT);
  digitalWrite(D0, HIGH);
  digitalWrite(D1, LOW);

  Serial.println("Connecting to WiFi");
  WiFi.begin("zS1L3NT", "leejieun");

  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
  }

  Serial.println("Connected to WiFi");
}

void loop()
{
  http.begin(wifi, "https://desktop-power.herokuapp.com/");
  if (http.GET() == 200)
  {
    String state = http.getString();
    if (state == "tap")
    {
      Serial.println(millis() + ": Tap");
      digitalWrite(D0, LOW);
      digitalWrite(D1, HIGH);
      delay(500);
      digitalWrite(D0, HIGH);
      digitalWrite(D1, LOW);
      http.POST("");
    }

    if (state == "hold")
    {
      Serial.println(millis() + ": Hold");
      digitalWrite(D0, LOW);
      digitalWrite(D1, HIGH);
      delay(3000);
      digitalWrite(D0, HIGH);
      digitalWrite(D1, LOW);
      http.POST("");
    }
  }
  delay(1000);
}