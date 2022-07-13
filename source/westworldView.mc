using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;

class RehoboamView extends WatchUi.WatchFace {
    private var _animationDelegate;


    function initialize() {
        WatchFace.initialize();
        _animationDelegate = new RehoboamAnimationController();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));       
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        _animationDelegate.handleOnShow(self);
        _animationDelegate.play();
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
        _animationDelegate.handleOnHide(self);
    }

    // Build up the time string
    function updateTimeLayer() {
        /*
        var font_time = WatchUi.loadResource(Rez.Fonts.font_time);
        var dc = _textLayer.getDc();
        var width = dc.getWidth();
        var height = dc.getHeight();
        */
        // Clear the layer contents
        var time = getTimeString();
        var time_hour = time[0];
        var time_min = time[1];
        var time_sec = time[2];
        //dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        //dc.clear();
        // Draw the time in the middle
        drawTime(time_hour, time_min, time_sec);
        //dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        /*
        dc.drawText(width / 3, height / 2, font_time, timeString,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_CENTER);
        */
    }
    
    function drawTime(hour, min, sec) {
        
        var font_time = WatchUi.loadResource(Rez.Fonts.font_time);
        var dc = _animationDelegate.getTextLayer().getDc();
        var width = dc.getWidth();
        var height = dc.getHeight();
        var hour_str;
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        System.println(width);
        System.println(height);
        var size_policy = 20;
        var space = 15;
        var x_hour_position = width / 6;
        var x_first_space = x_hour_position + 2*size_policy + space;
        var x_min_position = x_first_space + space;
        x_first_space = x_first_space - size_policy;
        var x_sec_space = x_min_position + 2*size_policy + space;
        var x_sec_position = x_sec_space + space;
        x_sec_space = x_sec_space - size_policy;
        if (hour<10) {
            hour_str = Lang.format("0$1$", [hour]);
        }
        else {
            hour_str = Lang.format("$1$", [hour]);
        }
        dc.drawText(x_hour_position, height / 2, font_time, hour_str,
            Graphics.Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(x_first_space, height / 2, font_time, ":",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(x_min_position, height / 2, font_time, min,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER );
        dc.drawText(x_sec_space, height / 2, font_time, ":",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(x_sec_position, height / 2, font_time, sec,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function getTimeString() {
        var str_time;
        var clockTime = System.getClockTime();
        var info = System.getDeviceSettings();
        var hour = clockTime.hour;
        if( !info.is24Hour ) {
            hour = clockTime.hour % 12;
            if (hour == 0) {
                hour = 12;
            }
        }
        var min = clockTime.min.format("%02d");
        var sec = clockTime.sec.format("%02d");
        /*
        if (hour<10) {
            str_time = Lang.format("0$1$:$2$:$3$", [hour, clockTime.min.format("%02d"),clockTime.sec.format("%02d")]);
        }
        else {
            str_time = Lang.format("$1$:$2$:$3$", [hour, clockTime.min.format("%02d"),clockTime.sec.format("%02d")]);
        }
        */
        return [hour, min, sec];
    }


    // Update the view
    function onUpdate(dc) {
        /*_animationDelegate.handleOnShow(self);*/
        //_animationDelegate.play();
        // Clear the screen buffer
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.clear();
        // Update the contents of the time layer
        //_animationDelegate.updateTimeLayer();
        updateTimeLayer();
        return;
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
         _animationDelegate.play();
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
         _animationDelegate.stop();
    }

}