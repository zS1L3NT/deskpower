#include "env.h"
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <string>

#define D0 16
#define D1 5

HTTPClient http;
WiFiClient wifi;
char *authorization = new char[strlen(ACCESS_KEY) + 8];

void setup()
{
  Serial.begin(9600);

  pinMode(D0, OUTPUT);
  pinMode(D1, OUTPUT);
  digitalWrite(D0, HIGH);
  digitalWrite(D1, LOW);

  Serial.println("Connecting to WiFi");
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
  }

  Serial.println("Connected to WiFi");

  http.begin(wifi, "http://desktop-power.herokuapp.com/");

  strcpy(authorization, "Bearer ");
  strcat(authorization, ACCESS_KEY);
}

void loop()
{
  http.addHeader("Authorization", authorization);
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

      http.addHeader("Authorization", authorization);
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

      http.addHeader("Authorization", authorization);
      http.POST("");
    }
  }
  delay(1000);
}