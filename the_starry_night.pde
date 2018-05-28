import processing.sound.*;

PImage img;
boolean isRain = false;
boolean isLightning = false;
boolean isSnow = false;
void setup() {
  size(1280,800);
  String url = "https://api.openweathermap.org/data/2.5/weather?q=";
  String city = "Miami";
  String apiKey = "INSERT_API_KEY";
  JSONObject json = loadJSONObject(url + city + "&appid=" + apiKey);
  int code = 200;//(int)(json.getJSONArray("weather").getJSONObject(0).get("id"));
  print(json);
  if(code == 800) {
    img = loadImage("a_starry_night.jpg");
  } else if(code > 800) {
    img = loadImage("a_cloudy_night.jpg");
  }
  else if(code >= 700) {
    img = loadImage("a_cloudy_night2.jpg");
  } else if(code >= 600) {
    img = loadImage("a_snowy_night.jpg");
    isSnow = true;
  } else if(code >= 300){
    img = loadImage("a_cloudy_night.jpg");
    isRain = true;
  } else {
    img = loadImage("a_cloudy_night.jpg");
    isRain = true;
    isLightning = true;
  }
  //wind
  SoundFile wind = new SoundFile(this, "wind.wav");
  wind.loop();
  wind.amp(0.5);
  if(!isRain && !isLightning && !isSnow) {
    //crickets
    new SoundFile(this, "crickets.wav").loop();
  }
  if(isRain) {
    //rain
    new SoundFile(this, "rain.wav").loop();
  }
  if(isLightning) {
    //lightning
    new SoundFile(this, "lightning.wav").loop();
    
  }
  background(0);
  for(int i = 0; i < 10000; i++) {
  float x = random(width);
  float y = random(height);
  fill(img.get((int)x,(int)y));
  noStroke();
  ellipse(x, y, 4, 4);
  }
}

void draw() {
  for(int i = 0; i < 5000; i++) {
  float x = random(width);
  float y = random(height);
  fill(img.get((int)x,(int)y));
  noStroke();
  ellipse(x, y, 4, 4);
  }
  if(isLightning) {
    if((int)random(125) == 1) {
      lightning((int)random(400,1280), 0);
    }
  }
  if(isRain) {
    rain();
  }
  
  if(isSnow) {
    snow();
  }
}

void rain() {
  for(int i = 0; i < 7; i++) {
    int x = (int)random(width);
    int y = (int)random(height);
    fill(255);
    stroke(255);
    strokeWeight(2);
    line(x, y, x + 5, y-15);
  }
  
}
void snow() {
  for(int i = 0; i <2; i++) {
    int x = (int)random(width);
    int y = (int)random(height);
    fill(255);
    stroke(255);
    strokeWeight(2);
    ellipse(x, y, 15, 15);
  }
  
}

void lightning(int x, int y) {
  stroke(255,190,255);
  int type = (int)random(3);
  if(type == 0) {
    strokeWeight(6);
    line(x,y, x - 100, y + 257);
    x -= 100;
    y += 257;
    strokeWeight(5);
    line(x,y, x + 88, y + 178);
    x += 88;
    y += 178;
    strokeWeight(2);
    line(x,y, x - 34, y + 50);
    x -= 34;
    y += 50;
  } else if(type == 1) {
    strokeWeight(6);
    line(x,y, x + 45, y + 200);
    x += 45;
    y += 200;
    strokeWeight(5);
    line(x,y, x , y + 100);
    y += 100;
    strokeWeight(4);
    line(x,y, x - 34, y + 70);
    line(x,y, x + 34, y + 56);
    x -= 34;
    y += 70;
  }else {
    strokeWeight(8);
    line(x,y, x + 100, y + 257);
    x += 100;
    y += 257;
    strokeWeight(7);
    line(x,y, x - 88, y + 178);
    x -= 88;
    y += 178;
    strokeWeight(4);
    line(x,y, x + 34, y + 50);
    x += 34;
    y += 50;
    strokeWeight(2);
    line(x,y, x + 10, y + 40);
    x += 34;
    y += 50;
  }
  
  
}
