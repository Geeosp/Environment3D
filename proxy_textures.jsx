#target "illustrator"
/**
	export first layer to prefab texture

*/


var doc = activeDocument;
var layer  = doc.layers[0];
var names = [
	"escalator_step",
	"escalator_hand",	
	"tree",
	"pot",
	"telephone",
	"roundLight",
	"a",
	"soidjd",
	"odihad"
];
var step = 255/names.length;
//alert(step);
var red =0 ;
var blue = 255;
var green = 255;
var i =0;

for (var x in names){
	
	red +=step;
	nblue-=step;
	green -=step;
 	var nred=Math.floor(red -i*step);
	var nblue=Math.floor(blue - i*step);
	var ngreen=Math.floor(green - i*step);

  walkPathItems(layer, function(pathItem) {
  //	alert (rgbToHex(red,blue, green));

  var color = new RGBColor();
  		var color  = hexColor(rgbToHex(red, green, blue));
        pathItem.fillColor =  color;
      });

var filePath = new File(doc.path+"/out/"+names[x]+"_texture.png");
	mkdirs(filePath.parent);
	// Create PNG export
        var opts = new ExportOptionsPNG24();
        opts.artBoardClipping = true;
        opts.horizontalScale = opts.verticalScale = 100;
        activeDocument.exportFile(filePath, ExportType.PNG24, opts);

}

function mkdirs(folder) {
  if (folder && !folder.exists && folder.create()) {
    mkdirs(folder.parent);
  }
}


function componentToHex(c) {
    var hex = c.toString(16);
    return hex.length == 1 ? "0" + hex : hex;
}

function rgbToHex(r, g, b) {
	var k = "";
    return componentToHex(r) + componentToHex(g) + componentToHex(b);
}


function walkPathItems(container, fn) {
  fn = fn || function(){};
  container = container || {};
  if ('pathItems' in container) {
    for (var i = 0; i < container.pathItems.length; i++) {
      fn(container.pathItems[i]);
    }
  }
  if ('compoundPathItems' in container) {
    for (var i = 0; i < container.compoundPathItems.length; i++) {
      walkPathItems(container.compoundPathItems[i], fn);
    }
  }
  if ('groupItems' in container) {
    for (var i = 0; i < container.groupItems.length; i++) {
      walkPathItems(container.groupItems[i], fn);
    }
  }
}

function savePng8 ( doc, filePath) {
	var destFile = new File( filePath + '.png' );
	var options = new ExportOptionsPNG8();
	options.antiAliasing = true;
	options.transparency = true; 
	options.artBoardClipping = true;
	options.horizontalScale = 1;
	options.verticalScale = 1;
	doc.exportFile(destFile, ExportType.PNG8 , options);
}


function hexColor(s) {
 // s = s.replace(/#/, '');
  if (s.length == 3) {
    s = s.substring(0,1) + s.substring(0,1)
      + s.substring(1,2) + s.substring(1,2)
      + s.substring(2,3) + s.substring(2,3);
  }

  if (s.length != 6) {
    return new RGBColor();
  }

  var color = new RGBColor();
  color.red = parseInt(s.substring(0, 2), 16);
  color.green = parseInt(s.substring(2, 4), 16);
  color.blue = parseInt(s.substring(4, 6), 16);
  return color;
}










