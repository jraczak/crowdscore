function GraphAnimation (canvas, innerColor, outterColor, percent, zeroDegree, thickness)
{
	this.ctx = canvas;
	this.canvas = canvas.getContext('2d');
	this.outterColor = outterColor;
	this.innerColor = innerColor;
	this.intervalID;
	this.thickness = thickness;
	this.startAngle = zeroDegree;
	this.endAngle = zeroDegree;
	this.speed = 10; // speed * 100 = total time in ms
	this.xCenter = canvas.width / 2;
	this.yCenter = canvas.height / 2;
	this.radius = this.xCenter - this.thickness / 2;
	this.zeroDegree = zeroDegree;
	this.percent = percent;
}

GraphAnimation.prototype.drawFullCircle = function (){
	// Draw the solid circle 
  this.canvas.beginPath();
  this.canvas.arc(this.xCenter, this.yCenter, this.radius, 0, Math.PI*2, false);
  this.canvas.lineWidth = this.thickness;
  this.canvas.strokeStyle = this.innerColor;
  this.canvas.stroke(); 

  this.canvas.arc(this.xCenter, this.yCenter, this.radius, 0, Math.PI*2, false);
  this.canvas.lineWidth = 0;
  this.canvas.fillStyle ='#FFFFFF';
  this.canvas.fill();
  this.canvas.stroke();
};

GraphAnimation.prototype.drawPartialCircle = function() {
  var self = this;
  function updateInterval() {
    self.updateShape();
  }
  this.intervalID = window.setInterval(updateInterval, this.speed)
}

GraphAnimation.prototype.stopTimer = function() {
  if (this.intervalID != null) window.clearInterval(this.intervalID)
  this.intervalID = null;
}

GraphAnimation.prototype.updateShape = function() {
	
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

GraphAnimation.prototype.drawPercent = function(size){
	this.canvas.font = size + 'pt Sans-Serif';
	this.canvas.textAlign = 'center';
	this.canvas.fillStyle = this.outterColor;
	this.canvas.fillText(this.percent, this.xCenter, this.yCenter + size / 2);
}

var count = 1;
GraphAnimation.prototype.drawLoading = function(){
	if ( count < 10 ){
	
		this.canvas.beginPath();
	  this.canvas.arc(this.xCenter, this.yCenter, this.radius, 0, Math.PI*2, false);
	  this.canvas.lineWidth = this.thickness + 1;
	  this.canvas.strokeStyle = "#FFFFFF";
	  this.canvas.stroke(); 
	  
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

GraphAnimation.prototype.drawArc = function() {
  var self = this;
  function draw() {
    self.drawLoading();
  }
  this.intervalID = window.setInterval(draw, this.speed)
}
