$(document).ready(function(){
	var canvasCollection = $('canvas.graph-animations');
	var canvas, innerColor, outterColor, percent, thickness, innerWhite;
	var graphCollection = []
	for (var i = 0; i < canvasCollection.length; i++) {
		canvas = canvasCollection[i];
		innerColor = $(canvasCollection[i]).data('innercolor')
		thickness = $(canvasCollection[i]).data('thickness')
		percent = $(canvasCollection[i]).data('percent')
		innerWhite = $(canvasCollection[i]).data('innerwhite')
		outterColor = $(canvasCollection[i]).data('outtercolor')
		graphCollection.push(new ScoreGraph(canvas, innerColor, outterColor, percent, thickness, innerWhite))
	}

	for (var i = 0; i < graphCollection.length; i++) {
		graphCollection[i].drawFullCircle();
		graphCollection[i].drawPartialCircle();
	}
});

function ScoreGraph (canvas, innerColor, outterColor, percent, thickness, innerWhite){
	this.innerWhite = innerWhite;
	this.ctx = canvas;
	this.canvas = canvas.getContext('2d');
	this.outterColor = outterColor;
	this.innerColor = innerColor;
	this.intervalID;
	this.thickness = thickness;
	this.startAngle = Math.PI*3/2;
	this.endAngle = Math.PI*3/2;
	this.speed = 10; // speed * 100 = total time in ms
	this.xCenter = canvas.width / 2;
	this.yCenter = canvas.height / 2;
	this.radius = this.xCenter - this.thickness / 2;
	this.zeroDegree = Math.PI*3/2;
	this.percent = parseInt(percent);
}

ScoreGraph.prototype.drawFullCircle = function (){
	// Draw the solid circle 
  this.canvas.beginPath();
  this.canvas.arc(this.xCenter, this.yCenter, this.radius, 0, Math.PI*2, false);
  this.canvas.lineWidth = this.thickness;
  this.canvas.strokeStyle = this.innerColor;
  this.canvas.stroke(); 

  if (this.innerWhite == true){
	  this.canvas.arc(this.xCenter, this.yCenter, this.radius, 0, Math.PI*2, false);
	  this.canvas.lineWidth = 0;
	  this.canvas.fillStyle ='#f7f7f7';
	  this.canvas.fill();
	  this.canvas.stroke();
	}
return this;
};


ScoreGraph.prototype.drawPartialCircle = function() {
  var self = this;
  function updateInterval() {
    self.updateShape();
  }
  this.intervalID = window.setInterval(updateInterval, this.speed);
}

ScoreGraph.prototype.stopTimer = function() {
  if (this.intervalID != null) window.clearInterval(this.intervalID)
  this.intervalID = null;
}

ScoreGraph.prototype.updateShape = function() {
	if ( this.endAngle < ( 2*Math.PI*this.percent/100 + this.zeroDegree )){
		// Draw a piece of the circle on each existing canvas
		this.canvas.beginPath();
		this.canvas.arc(this.xCenter, this.yCenter, this.radius, this.startAngle, this.endAngle, false);
		this.canvas.lineWidth = this.thickness;
		this.canvas.strokeStyle = this.outterColor;
		this.canvas.stroke();
		this.startAngle = this.endAngle - Math.PI/(4*180);
		this.endAngle = this.endAngle + (2 * Math.PI/100);
	}
	else {
		this.stopTimer();
	}
}

var count = 1;
ScoreGraph.prototype.drawLoading = function(){
	if ( count < 10 ){

		this.canvas.beginPath();
	  this.canvas.arc(this.xCenter, this.yCenter, this.radius, 0, Math.PI*2, false);
	  this.canvas.lineWidth = this.thickness;
	  this.canvas.strokeStyle = this.innerColor;
	  this.canvas.stroke(); 
	  
		// Draw a piece of the circle on each existing canvas
		this.canvas.beginPath();
		this.canvas.arc(this.xCenter, this.yCenter, this.radius, this.startAngle, this.startAngle + Math.PI/2, false);
		this.canvas.lineWidth = this.thickness;
		this.canvas.strokeStyle = this.outterColor;
		this.canvas.stroke();
		this.startAngle = this.startAngle + Math.PI/180;
	}
	else {
		this.stopTimer();
	}
}

ScoreGraph.prototype.drawArc = function() {
  var self = this;
  function draw() {
    self.drawLoading();
  }
  this.intervalID = window.setInterval(draw, this.speed)
}
 