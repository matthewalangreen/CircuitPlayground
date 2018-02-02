


int r = 10;
int g = 10;
int b = 10;
int brushSize = 10;

float pBrushX;
float pBrushY;
float brushX;
float brushY;

void setup() 
{
  size(800,800);
  background(255);
  
}


void draw() 
{
 
 
  fill(r,g,b);
  noStroke();
  rect(0,0,100,12);
  fill(255);
  text((r + "," + g + "," + b),10,10);
   fill(0);
  //text(("BRUSH SIZE"), 720,20);
  fill(r,g,b);
  //ellipse(750, 55, brushSize, brushSize);
  
  
 
  
  if(keyPressed == true)
  {
  
  if(key == 'r')
  {
   r++;
   if (r > 255)
   {
    r = 0; 
   } 
  }
  
  else if(key == 'g')
  {
   g++;
   if (g > 255)
   {
    g = 0; 
   }
  }
  
  else if(key == 'b')
  {
   b++;
   if (b > 255)
   {
    b = 0; 
   } 
  }
  
   else if(keyCode == UP)
  {
  brushSize++;
  eraseBrush();
  if (brushSize >= 50)
  {
   b = 50; 
  }
  }
  
  else if(keyCode == DOWN)
  {
  brushSize--;
  eraseBrush();
  if (brushSize <= 0)
  {
   b = 0; 
   
  }
  }
  
}
}

void mouseDragged()
{
  if(mouseButton == LEFT)
  {
     strokeWeight(brushSize);
     stroke(r,g,b);
     line(pmouseX, pmouseY, mouseX, mouseY); 
  }
}

void mousePressed()
{
 if(mouseButton == RIGHT)
 {
  background(255); 
  brushSize = 10;
  eraseBrush();
 }
}

void eraseBrush() 
{
 fill(255);
 rect(700, 0, 100, 100); 
 text(("BRUSH SIZE"), 720,20);
}