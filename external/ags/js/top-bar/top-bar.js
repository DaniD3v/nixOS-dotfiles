import Variable from "resource:///com/github/Aylur/ags/variable.js";

import { BatteryWidget } from "./battery-bar.js";

const time = Variable("", {
  poll: [
    1000,
    function () {
      return new Date().toLocaleTimeString("eu");
    },
  ],
});

export function TopBar(monitor = 0) {
  return Widget.Window({
    monitor,
    name: `top-bar`,
    class_name: "color-background rounded",

    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",

    child: Widget.CenterBox({
      start_widget: Widget.Label({
        class_name: "color-widget-box rounded margin-lr",
        hpack: "start",

        label: "Welcome to AGS!",
      }),
      center_widget: Widget.Label({
        class_name: "color-widget-box rounded",
        hpack: "center",

        label: time.bind(),
      }),
      end_widget: BatteryWidget("end"),
    }),
  });
}
