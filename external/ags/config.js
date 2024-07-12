import { TopBar } from "./js/top-bar/top-bar.js";

App.config({
  windows: [TopBar()],
  style: `${App.configDir}/css/top-bar.css`,
});
