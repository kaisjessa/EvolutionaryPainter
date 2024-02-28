class TriangleStroke {
  int numProperties;
  float[] properties;
  int order;
  float al;

  TriangleStroke (float[] p, int o, float a) {
    this.numProperties = 9;
    this.order = 0;
    this.al = a;
    if (p.length == 0) setRandom();
    else this.properties = p;
  }

  void setRandom() {
    float[] p = new float[numProperties];
    for (int i=0; i<numProperties; i++) {
      p[i] = random(0, 1);
    }
    this.properties = p;
  }

  void show() {
    if (this.properties[this.numProperties-1] > 0) {
      float x1 = map(this.properties[0], 0, 1, -0.1*width, 1.1*width);
      float y1 = map(this.properties[1], 0, 1, -0.1*height, 1.1*height);
      float x2 = map(this.properties[2], 0, 1, -0.1*width, 1.1*width);
      float y2 = map(this.properties[3], 0, 1, -0.1*height, 1.1*height);
      float x3 = map(this.properties[4], 0, 1, -0.1*width, 1.1*width);
      float y3 = map(this.properties[5], 0, 1, -0.1*height, 1.1*height);
      float hu = this.properties[6];
      float sa = this.properties[7];
      float br = this.properties[8];

      push();
      fill(hu, sa, br, this.al);
      triangle(x1, y1, x2, y2, x3, y3);
      pop();
    }
  }

  TriangleStroke makeCopy() {
    TriangleStroke newStroke = new TriangleStroke(this.properties.clone(), this.order, this.al);
    return newStroke;
  }
}
