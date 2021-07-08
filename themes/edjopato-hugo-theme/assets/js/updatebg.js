function updateBg() {
	const date = new Date();
	const hour = date.getHours();
	const minute = date.getMinutes();
	const minuteOfDay = (hour * 60) + minute;
	const hue = minuteOfDay % 360;

	document.documentElement.style.setProperty('--time-hue', hue);
	console.log("update bg hue", hue, date);
}
setInterval(updateBg, 30000);
updateBg();
