
/*
Hacked together by Gadget Reboot 2018 from two separate sources:
https://arduining.com/2013/08/05/arduino-and-processing-graph-example/
https://forum.processing.org/two/discussion/14060/#Comment_57867

 Based on the Tom Igoe example.
 Mofified by Arduining 17 Mar 2012:
  -A wider line was used. strokeWeight(4);
  -Continuous line instead of vertical lines.
  -Bigger Window size 600x400.
-------------------------------------------------------------------------------
This program takes ASCII-encoded strings
from the serial port at 9600 baud and graphs them. It expects values in the
range 0 to 1023, followed by a newline, or newline and carriage return

Created 20 Apr 2005
Updated 18 Jan 2008
by Tom Igoe
This example code is in the public domain.
*/

import processing.serial.*;

Serial myPort;        // The serial port
float inByte;         // Incoming serial data
boolean newData = false;
int xPos = 1;         // horizontal position of the graph 

//Variables to draw a continuous line.
int lastxPos=1;
int lastheight=0;

void setup () {
  // set the window size:
  size(600, 400);        

  myPort = new Serial(this, "ENTER_YOUR_COM_PORT_NAME_HERE!!!!!", 9600);  

  // A serialEvent() is generated when a newline character is received :
  myPort.bufferUntil('\n');
  background(0);      // set inital background:
}
void draw () {
  if (newData) {
    //Drawing a line from Last inByte to the new one.
    stroke(127,34,255);     //stroke color
    strokeWeight(4);        //stroke wider
    line(lastxPos, lastheight, xPos, height - inByte); 
    lastxPos= xPos;
    lastheight= int(height-inByte);

    // at the edge of the window, go back to the beginning:
    if (xPos >= width) {
      xPos = 0;
      lastxPos= 0;
      background(0);  //Clear the screen.
    } 
    else {
      // increment the horizontal position:
      xPos++;
    }
   newData =false;
 }
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);                // trim off whitespaces.
    inByte = float(inString);           // convert to a number.
    inByte = map(inByte, 0, 1023, 0, height); //map to the screen height.
    newData = true; 
  }
}
