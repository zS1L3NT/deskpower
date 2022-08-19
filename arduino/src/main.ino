#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

#define D0 16

HTTPClient http;
WiFiClient wifi;

void setup()
{
  Serial.begin(9600);

  pinMode(D0, OUTPUT);
  digitalWrite(D0, HIGH);

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
      if (state == "single")
      {
        http.POST("");
        digitalWrite(D0, LOW);
        delay(500);
        digitalWrite(D0, HIGH);
      }

      if (state == "hold")
      {
        http.POST("");
        digitalWrite(D0, LOW);
        delay(3000);
        digitalWrite(D0, HIGH);
      }
    }
  }
  delay(1000);
}