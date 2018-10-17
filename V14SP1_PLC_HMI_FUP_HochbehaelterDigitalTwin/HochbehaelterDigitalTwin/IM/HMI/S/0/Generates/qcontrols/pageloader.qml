import QtQuick 2.0

 Item {

     id: mypageloaderqml

     Global{
        z: 2
     }

     function setRotation(angle)
     {
	     //landscape mode SRT
         if(angle === 90)
		 {
            var diff = Math.abs(height - width)
            x = x + (diff / 2)
            y = y - (diff / 2)
            rotation = angle
		 }
     }
}
