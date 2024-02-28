class Painting {
  int numStrokes;
  //PaintStroke[] strokes;
  TriangleStroke[] strokes;
  float[] backColour;
  int alphaIndex;

  Painting(int n) {
    this.numStrokes = n;
    //this.strokes = new PaintStroke[numStrokes];
    this.strokes = new TriangleStroke[numStrokes];
    float[] empty = {};
    for (int i=0; i<numStrokes; i++) {
      //this.strokes[i] = new PaintStroke(empty, i, 0);
      this.strokes[i] = new TriangleStroke(empty, i, 0);
    }
    this.alphaIndex = this.strokes[0].numProperties-1;
  }

  void show() {
    background(0, 0, 0);
    for (int i=0; i<numStrokes; i++) {
      this.strokes[i].show();
    }
  }

  void mutate(int index, float mutationRate) {
    if (index == -1) index = int(random(0, this.numStrokes));
    int subIndex = int(random(0, this.strokes[index].numProperties-1));
    this.strokes[index].al = 0.1;
    if (random(0, 1) < mutationRate) this.strokes[index].properties[subIndex] = random(0, 1);
    else {
      this.strokes[index].properties[subIndex] += mutationRate*random(-1, 1);
      this.strokes[index].properties[subIndex] = min(this.strokes[index].properties[subIndex], 1);
      this.strokes[index].properties[subIndex] = max(this.strokes[index].properties[subIndex], 0);
    }
  }

  float calcFitness(PImage baseImg) {
    float mse = 0;
    int count = 0;
    float centreDist = 1;
    int x;
    int y;
    PImage getImg = get();
    getImg.resize(baseImg.width, baseImg.height);
    getImg.loadPixels();
    baseImg.loadPixels();
    int numPixels = baseImg.width * baseImg.height;
    for (int i=0; i < numPixels; i++) {
      //x = numPixels % width;
      //y = (numPixels - x)/width;
      //centreDist = pow(width/2-x,2) + pow(height/2-y,2);
      //centreDist = map(centreDist, 0, pow(width/2,2)+pow(height/2,2), 2, 1);
      color baseC = baseImg.pixels[i];
      color getC = getImg.pixels[i];

      int r1 = (baseC >> 16) & 0xFF;  // Faster way of getting red(argb)
      int g1 = (baseC >> 8) & 0xFF;   // Faster way of getting green(argb)
      int b1 = baseC & 0xFF;          // Faster way of getting blue(argb)

      int r2 = (getC >> 16) & 0xFF;  // Faster way of getting red(argb)
      int g2 = (getC >> 8) & 0xFF;   // Faster way of getting green(argb)
      int b2 = getC & 0xFF;          // Faster way of getting blue(argb)

      mse += centreDist * (pow((r2-r1)/255.0, 2) + pow((g2-g1)/255.0, 2) + pow((b2-b1)/255.0, 2));
      count += 3;


      //println(baseC, getC);
    }
    mse /= count;
    for (int i=0; i<this.numStrokes; i++) {
      if (this.strokes[i].properties[alphaIndex] > 0) mse += 0.0001;
    }
    return(mse);
  }

  Painting makeCopy() {
    Painting newPainting = new Painting(this.numStrokes);
    for (int i=0; i<this.numStrokes; i++) {
      newPainting.strokes[i] = this.strokes[i].makeCopy();
    }
    return newPainting;
  }
}
