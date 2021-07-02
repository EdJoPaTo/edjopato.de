function updateBg() {
	const date = new Date();
	const hour = date.getHours();
	const minute = date.getMinutes();
	const minuteOfDay = (hour * 60) + minute;
	const hue = minuteOfDay % 360;

	const element = document.getElementsByTagName("html")[0];
	element.style["background-color"] = "hsl(" + hue + ",100%,25%)";
	console.log("update bg hue", hue, date);
}
setInterval(updateBg, 30000);
updateBg();
