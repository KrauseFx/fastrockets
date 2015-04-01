#include "rpi-rgb-led-matrix/include/led-matrix.h"

#include <unistd.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <list>

using rgb_matrix::GPIO;
using rgb_matrix::RGBMatrix;
using rgb_matrix::Canvas;

class Rocket {
  public:
    int x;
    float y;
    int r;
    int g;
    int b;
    float speed;
    void draw(Canvas *canvas);
    inline bool operator == (Rocket r) {
      return r.x == x && r.y == y;
    }
};

void Rocket::draw(Canvas *canvas) {
  int iY = floor(y);
  canvas->SetPixel(x,y,r,g,b);
  if (iY - 1 >= 0) {
    canvas->SetPixel(x,iY-1,r,g,b);
  }
  if (iY+1 < canvas->width()) {
    canvas->SetPixel(x,iY+1,0,0,0);
  }
  float factor = y / (canvas->height() - 1);
  float decreasing = std::max(((factor * factor) * speed), 0.005f);
  y -= decreasing;
}



static void DrawOnCanvas(Canvas *canvas) {
  /*
   * Let's create a simple animation. We use the canvas to draw
   * pixels. We wait between each step to have a slower animation.
   */
  canvas->Fill(0, 0, 0);
  std::list<Rocket> rockets;
  while (true) {
    int r;
    scanf("%i", &r);
    if (r == -1) {
      std::list<Rocket>::iterator it;
      Rocket *toDelete = NULL;
      for (it = rockets.begin(); it != rockets.end(); it++) {
        if (toDelete != NULL) {
          rockets.remove((*toDelete));
          toDelete = NULL;
        }
        (*it).draw(canvas);
        if ((*it).y < -1) {
         toDelete = &(*it);
          canvas->SetPixel((*toDelete).x,(*toDelete).y+1,0,0,0);
        }
      }
      if (toDelete != NULL) {
          rockets.remove((*toDelete));
          toDelete = NULL;
      }
      continue;
    }
    int g;
    scanf("%i", &g);
    int b;
    scanf("%i", &b);
    int x;
    scanf("%i", &x);
    float speed;
    scanf("%f", &speed);
    Rocket rocket;
    rocket.x = x;
    rocket.y = canvas->height()-1;
    rocket.speed = speed;
    rocket.r = r;
    rocket.g = g;
    rocket.b = b;
    rockets.push_back(rocket);
  }
}

int main(int argc, char *argv[]) {
  /*
   * Set up GPIO pins. This fails when not running as root.
   */
  GPIO io;
  if (!io.Init())
    return 1;
    
  /*
   * Set up the RGBMatrix. It implements a 'Canvas' interface.
   */
  int rows = 16;    // A 32x32 display. Use 16 when this is a 16x32 display.
  int chain = 1;    // Number of boards chained together.
  int parallel = 1; // Number of chains in parallel (1..3). > 1 for plus or Pi2
  Canvas *canvas = new RGBMatrix(&io, rows, chain, parallel);

  DrawOnCanvas(canvas);    // Using the canvas.

  // Animation finished. Shut down the RGB matrix.
  canvas->Clear();
  delete canvas;

  return 0;
}
