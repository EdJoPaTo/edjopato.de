function updateBg() {
	var date = new Date();
	var hour = date.getHours();
	var minute = date.getMinutes();
	var minuteOfDay = (hour * 60) + minute;
	var hue = minuteOfDay % 360;

	var element = document.getElementsByTagName("html")[0];
	element.style["background-color"] = "hsl(" + hue + ",100%,20%)";
	console.log("update bg hue", hue, date);
}
setInterval(updateBg, 30000);
updateBg();
