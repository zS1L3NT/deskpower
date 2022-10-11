#include "env.h"
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <string>

#define D0 16
#define D1 5
#define D2 4
#define D3 0
#define D4 2
#define D5 14
#define D6 12
#define D7 13
#define D8 15

#define COMPUTER D0
#define SIGNAL D2
#define SUCCESS D6
#define FAILURE D8

HTTPClient http;
WiFiClient wifi;
char *authorization = new char[strlen(ACCESS_KEY) + 8];

void setup()
{
  Serial.begin(9600);

  pinMode(COMPUTER, OUTPUT);
  pinMode(SIGNAL, OUTPUT);
  pinMode(SUCCESS, OUTPUT);
  pinMode(FAILURE, OUTPUT);
  digitalWrite(COMPUTER, HIGH);
  digitalWrite(SIGNAL, LOW);
  digitalWrite(SUCCESS, LOW);
  digitalWrite(FAILURE, LOW);

  Serial.println("Connecting to WiFi");
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
  }

  Serial.println("Connected to WiFi");

  http.begin(wifi, "http://desktop-power.zectan.com/arduino");

  strcpy(authorization, "Bearer ");
  strcat(authorization, ACCESS_KEY);
}

void loop()
{
  http.addHeader("Authorization", authorization);
  if (http.GET() == 200)
  {
    digitalWrite(FAILURE, LOW);
    digitalWrite(SUCCESS, LOW);
    delay(250);
    digitalWrite(SUCCESS, HIGH);

    String state = http.getString();
    if (state == "true")
    {
      digitalWrite(COMPUTER, LOW);
      digitalWrite(SIGNAL, HIGH);
      delay(500);
      digitalWrite(COMPUTER, HIGH);
      digitalWrite(SIGNAL, LOW);

      http.addHeader("Authorization", authorization);
      http.POST("");
    }
  }
  else
  {
    digitalWrite(SUCCESS, LOW);
    digitalWrite(FAILURE, LOW);
    delay(250);
    digitalWrite(FAILURE, HIGH);
  }
  delay(1000);
}