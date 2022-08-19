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

  WiFi.begin("zS1L3NT", "leejieun");
}

void loop()
{
  if (WiFi.status() == WL_CONNECTED)
  {
    http.begin(wifi, "http://desktop-power.herokuapp.com/");
    if (http.GET() == 200)
    {
      String state = http.getString();
      if (state == "tap")
      {
        http.POST("");
        digitalWrite(D0, LOW);
        digitalWrite(D1, HIGH);
        delay(500);
        digitalWrite(D0, HIGH);
        digitalWrite(D1, LOW);
      }

      if (state == "hold")
      {
        http.POST("");
        digitalWrite(D0, LOW);
        digitalWrite(D1, HIGH);
        delay(3000);
        digitalWrite(D0, HIGH);
        digitalWrite(D1, LOW);
      }
    }
  }
  delay(1000);
}