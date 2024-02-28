class PaintStroke {
  int numProperties;
  float[] properties;
  int order;
  float al;

  PaintStroke (float[] p, int o, float a) {
    this.numProperties = 8;
    this.order = o;
    this.al = a;
    if (p.length == 0) setRandom();
    else this.properties = p;
  }

  void setRandom() {
    float[] p = new float[this.numProperties];
    for (int i=0; i<this.numProperties; i++) {
      p[i] = random(0, 1);
    }
    this.properties = p;
  }

  void show() {
    if (this.al > 0) {
      float x = map(this.properties[0], 0, 1, 0, width);
      float y = map(this.properties[1], 0, 1, 0, height);
      float h = map(this.properties[2], 0, 1, 0, height);
      float w = map(this.properties[3], 0, 1, 0, width);
      float theta = map(this.properties[4], 0, 1, 0, PI);
      // float theta = PI*int(2*this.properties[4]);
      float hu = this.properties[5];
      float sa = this.properties[6];
      float br = this.properties[7];
      // float al = map(this.properties[8], 0, 1, 0, 1);

      push();
      fill(hu, sa, br, this.al);
      translate(x, y);
      rotate(theta);
      rect(0, 0, w, h);
      pop();
    }
  }

  PaintStroke makeCopy() {
    PaintStroke newStroke = new PaintStroke(this.properties.clone(), this.order, this.al);
    return newStroke;
  }
}
