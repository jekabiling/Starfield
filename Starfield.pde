Particle[] particles;
int total = 100;
float flightSpeed = 0;

void setup() {
  size(600, 600);
  particles = new Particle[total];
  for (int i = 0; i < particles.length; i++) {
    if (i == 0) {
      particles[i] = new OddballParticle();
    } else {
      particles[i] = new Particle();
    }
  }
}

void draw() {
  background(5, 10, 30);
  if (mousePressed) {
    flightSpeed = min(flightSpeed + 0.2, 15);
  } else {
    flightSpeed = max(flightSpeed - 0.1, 1);
  }
  for (int i = 0; i < particles.length; i++) {
    particles[i].move();
    particles[i].show();
  }
  drawBoost();

  noStroke();
  fill(125, 145, 175);
  triangle(300, 390, 205, 475, 285, 455);
  triangle(300, 390, 395, 475, 315, 455);
  fill(210, 45, 55);
  triangle(265, 425, 215, 465, 270, 445);
  triangle(335, 425, 385, 465, 330, 445);
  fill(190, 205, 225);
  triangle(300, 360, 263, 485, 300, 470);
  triangle(300, 360, 337, 485, 300, 470);
  fill(220, 50, 55);
  triangle(278, 455, 260, 485, 294, 475);
  triangle(322, 455, 340, 485, 306, 475);
  fill(25, 65, 110);
  ellipse(300, 405, 25, 45);

}

void drawBoost() {
  if (mousePressed || flightSpeed > 3) {
    float flameLength = map(flightSpeed, 1, 15, 15, 95);
    flameLength += random(-8, 8);

    noStroke();
    fill(255, 75, 15, 190);
    triangle(278, 470, 322, 470, 300, 470 + flameLength);
    fill(255, 180, 25, 230);
    triangle(287, 470, 313, 470, 300, 470 + flameLength * 0.75);
    fill(70, 190, 255, 210);
    triangle(294, 470, 306, 470, 300, 470 + flameLength * 0.4);
    fill(255, 120, 30, 80);
    ellipse(300, 473, 35, 18);
  }
}

class Particle {
  double x, y;
  color particleColor;
  double angle, speed;
  Particle() {
    reset();
    particleColor = color(180, 210, 255);
  }

  void reset() {
    angle = random(TWO_PI);
    double radius = random(20, 65);
    x = width / 2 + Math.cos(angle) * radius;
    y = height / 2 + Math.sin(angle) * radius;
    speed = random(1, 4);
  }

  void move() {
    double dx = x - width / 2;
    double dy = y - height / 2;

    x += dx * 0.025 * flightSpeed / 5;
    y += dy * 0.025 * flightSpeed / 5;
    x += Math.cos(angle) * speed * 0.2;
    y += Math.sin(angle) * speed * 0.2;

    if (x < 0 || x > width || y < 0 || y > height) {
      reset();
    }
  }

  void show() {
    float dx = (float)x - width / 2;
    float dy = (float)y - height / 2;
    float px = (float)x - dx * flightSpeed * 0.005;
    float py = (float)y - dy * flightSpeed * 0.005;

    stroke(particleColor);
    strokeWeight(1.5);
    line(px, py, (float)x, (float)y);
  }
}

class OddballParticle extends Particle {
  OddballParticle() {
    particleColor = color(random(100, 255), random(100, 255),random(100, 255));
    speed = 5;
  }

  void show() {
    float trailLength = flightSpeed * 0.015;
    float dx = (float)x - width / 2;
    float dy = (float)y - height / 2;
    float px = (float)x - dx * trailLength;
    float py = (float)y - dy * trailLength;
  
    stroke(particleColor);
    strokeWeight(6);
    line(px, py, (float)x, (float)y);
  }
}
