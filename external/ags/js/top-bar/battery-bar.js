import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';

// const 

export const BatteryWidget = (hpack) => Widget.Box({
    class_name: "color-widget-box rounded margin-lr",
    hpack: hpack,

    children: [
        Widget.Icon({
            icon: Battery.bind("icon-name") 
            
            
            
        })
    ]
})

