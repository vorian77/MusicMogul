function initPage() {
	initNavIndexes();
	initButtons();
}
function initNavIndexes()
{
	var nav = document.getElementById("breadcrumbs");
	if(nav) {
		var lis = nav.getElementsByTagName("li");
		for (var i=0; i<lis.length; i++) {
			//lis[i].style.zIndex = i+1;
			lis[i].style.zIndex = lis.length-i;
		}
	}
}
if (window.addEventListener)
	window.addEventListener("load", initPage, false);
else if (window.attachEvent)
	window.attachEvent("onload", initPage)
	
	
	
	
function initButtons()
{
	var buttons = document.getElementsByTagName("a");
	for(var i = 0; i < buttons.length; i++) {
		if(buttons[i].className.indexOf("button") != -1) {
			buttons[i].onmousedown = function() {
				if(this.className.indexOf("pressed") == -1) this.className += " pressed";
			}
			buttons[i].onmouseup = function() {
				this.className = this.className.replace("pressed","");
			}
			buttons[i].onmouseout = function() {
				this.className = this.className.replace("pressed","");
			} 
		}
	}
}
if (window.addEventListener)
	window.addEventListener("load", initPage, false);
else if (window.attachEvent)
	window.attachEvent("onload", initPage)
if (window.addEventListener)
	window.addEventListener("load", initPage, false);
else if (window.attachEvent)
	window.attachEvent("onload", initPage)
