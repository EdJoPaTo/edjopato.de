function updateBg() {
	console.log("updateBg hue");

	const timefactor = Date.now() / 1000;
	const hue = timefactor % 360;

	document.documentElement.style.setProperty("--hue", hue);

	const themeColor = document.querySelector("meta[name=theme-color]");
	if (themeColor) {
		themeColor.content = `hsl(${hue}, 100%, 10%)`;
	}
}
setInterval(updateBg, 1000);
document.addEventListener("DOMContentLoaded", updateBg);
updateBg();
