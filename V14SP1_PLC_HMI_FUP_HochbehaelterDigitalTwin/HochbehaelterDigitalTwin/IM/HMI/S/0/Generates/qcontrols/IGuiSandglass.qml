import QtQuick 2.0

Image
{
     id : sandglassrectangle
     x: 0
     y: 0
     z: 280
     width: 32
     height: 32

     property bool bPortrait: false

     function setPosition (xx, yy)
     {
         if(bPortrait === false)
         {
             x = (xx - width) / 2;
             y = (yy - height) / 2;
         }
         else
         {
             var diff = Math.abs(yy - xx);
             x = ((xx - width) / 2) + (diff / 2);
             y = ((yy - height) / 2) - (diff / 2);
         }
     }

     function setDisplayMode(bPort)
     {
        bPortrait =  bPort;
     }
   
      source: (bPortrait == true) ? "./pics/sandglass_portrait.bmp" : "./pics/sandglass.bmp"      
      fillMode: Image.PreserveAspectFit     
}
