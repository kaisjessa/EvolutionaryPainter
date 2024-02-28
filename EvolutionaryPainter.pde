PImage img;
int res = 128;
float sc = 900.0/res;
int numStrokes = 1000;
Painting currentPainting;
Painting newPainting;
float currentFitness = 10;
float newFitness;

void settings() {
  img = loadImage("nobuzzes.png");
  float rt = float(img.width)/float(img.height);
  img.resize(int(rt*res), res);
  size(int(sc*img.width), int(sc*img.height));
}

void setup() {
  frameRate(144);
  colorMode(HSB, 1);
  rectMode(CENTER);
  noStroke();
  currentPainting = new Painting(numStrokes);
}

void draw() {
  //int index = int(random(min(numStrokes, frameCount/5)));
  int index = -1;
  float mutationRate = 1;
  //float mutationRate = max(0.05, 20*currentFitness);
  for (int i=0; i<1; i++) {
    newPainting = currentPainting.makeCopy();
    newPainting.mutate(index, mutationRate);
    newPainting.show();
    newFitness = newPainting.calcFitness(img);
    if (newFitness < currentFitness) {
      currentFitness = newFitness;
      currentPainting = newPainting;
      println(currentFitness);
    }
    //clear();
  }
  //currentPainting.show();
  // println(frameRate);
}
