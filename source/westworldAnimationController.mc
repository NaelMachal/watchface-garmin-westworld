using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Time;
using Toybox.Time.Gregorian;

class RehoboamAnimationController {
    private var _animation;
    private var _timeLayer;
    private var _dateLayer;
    private var _cityLayer;
    private var _drawLayer;
    private var _batteryLayer;
    private var _iconLayer;
    private var _playing;
    private var _delegator;
    private var _view;
    private var _count_repete_animation;
    private var _rate_x_start;
    private var _time_color;
    private var _date_color;
    

    function initialize() {
        _playing = false;
        _delegator = new RehoboamAnimationDelegate(self);
        _count_repete_animation = 0;
        _rate_x_start = 5;
        _time_color = Application.getApp().getProperty("time_color");
        _date_color = Application.getApp().getProperty("date_color");
    }

    function handleOnShow(view) {
        _view = view;
        if( view.getLayers() == null ) {
            // Initialize the Animation
             _animation = new WatchUi.AnimationLayer(
                Rez.Drawables.rehoboam,
                {
                    :locX=>0,
                    :locY=>0,
                }
                );

            // Build the time overlay
            _timeLayer = buildTimeLayer();
            _dateLayer = buildDateLayer();
            _cityLayer = buildCityLayer();
            _drawLayer = buildDrawLayer();
            _batteryLayer = buildBatteryLayer();
            _iconLayer = buildIconLayer();
            _view.addLayer(_animation);
            _view.addLayer(_timeLayer);
            _view.addLayer(_dateLayer);
            _view.addLayer(_cityLayer);
            _view.addLayer(_drawLayer);
            _view.addLayer(_batteryLayer);
            _view.addLayer(_iconLayer);
        }

    }

    function handleOnHide(view) {
        view.clearLayers();
        _animation = null;
        _timeLayer = null;
        _dateLayer = null;
        _cityLayer = null;
        _batteryLayer = null;
        _iconLayer = null;
    }

    // Function to initialize the time layer
    private function buildTimeLayer() {
        var info = System.getDeviceSettings();
        // Word aligning the width and height for better blits
        var width = (info.screenWidth * .80).toNumber() & ~0x3;
        var height = info.screenHeight * .25;

        var options = {
            :locX => ( (info.screenWidth - width) / 2 ).toNumber() & ~0x03,
            :locY => (info.screenHeight - height) / 2,
            :width => width,
            :height => height,
            :visibility=>true
        };

        // Initialize the Time over the animation
        var timeLayer = new WatchUi.Layer(options);
        return timeLayer;
    }

    private function buildDateLayer() {
        var info = System.getDeviceSettings();
        // Word aligning the width and height for better blits
        var width = (info.screenWidth * .80).toNumber() & ~0x3;
        var height = info.screenHeight * .25;

        var options = {
            :locX => ( (info.screenWidth - width) / 2 ).toNumber() & ~0x03,
            :locY => (info.screenHeight - height) / 3,
            :width => width,
            :height => height,
            :visibility=>true
        };

        // Initialize the Time over the animation
        var dateLayer = new WatchUi.Layer(options);
        return dateLayer;
    }

    private function buildCityLayer(){
        var info = System.getDeviceSettings();
        // Word aligning the width and height for better blits
        var width = (info.screenWidth * .80).toNumber() & ~0x3;
        var height = info.screenHeight * .25;

        var options = {
            :locX => ( (info.screenWidth - width) / 2 ).toNumber() & ~0x03,
            :locY => (info.screenHeight - height) / 1.5,
            :width => width,
            :height => height,
            :visibility=>true
        };

        // Initialize the Time over the animation
        var cityLayer = new WatchUi.Layer(options);
        return cityLayer;
    }
    private function buildDrawLayer(){
        var info = System.getDeviceSettings();
        // Word aligning the width and height for better blits
        var width = (info.screenWidth).toNumber() & ~0x3;
        var height = info.screenHeight * .5;

        var options = {
            :locX => ( info.screenWidth - width).toNumber() & ~0x03,
            :locY => (info.screenHeight - height) / 1.1,
            :width => width,
            :height => height,
            :visibility=>true
        };

        // Initialize the Time over the animation
        var drawLayer = new WatchUi.Layer(options);
        return drawLayer;
    }

    private function buildBatteryLayer(){
        var info = System.getDeviceSettings();
        // Word aligning the width and height for better blits
        var width = (info.screenWidth * .80).toNumber() & ~0x3;
        var height = info.screenHeight * .25;

        var options = {
            :locX => ( (info.screenWidth - width) / 2 ).toNumber() & ~0x03,
            :locY => (info.screenHeight - height) / 1.1,
            :width => width,
            :height => height,
            :visibility=>true
        };

        // Initialize the Time over the animation
        var batteryLayer = new WatchUi.Layer(options);
        return batteryLayer;
    }

    private function buildIconLayer(){
        var info = System.getDeviceSettings();
        // Word aligning the width and height for better blits
        var width = (info.screenWidth * .80).toNumber() & ~0x3;
        var height = info.screenHeight * .25;

        var options = {
            :locX => ( (info.screenWidth - width) / 2 ).toNumber() & ~0x03,
            :locY => (info.screenHeight - height) / 45,
            :width => width,
            :height => height,
            :visibility=>true
        };

        // Initialize the Time over the animation
        var iconLayer = new WatchUi.Layer(options);
        return iconLayer;
    }



    function getCountAnimationRepete(){
        return _count_repete_animation;
    }

    function setCountAnimationRepete(a){
        _count_repete_animation = a;       
    }

    function clearLayers(){
        _view.clearLayers();
    }

    function clearAnimationLayer(){
        _view.clearLayers();
        _view.addLayer(_timeLayer);
        _view.addLayer(_dateLayer);
        _view.addLayer(_cityLayer);
        _view.addLayer(_drawLayer);
        _view.addLayer(_batteryLayer);
        _view.addLayer(_iconLayer);
    }

    function clearTextLayer(){
        _view.clearLayers();
        _view.addLayer(_animation);
        _animation.play({:delegate => _delegator});
    }

    function play() {
        if (!_playing){
         //_view.addLayer(_animation);
         _animation.play({:delegate => _delegator});
        _playing = true;
        }
        else {
            //_count_repete_animation = _count_repete_animation + 1;
            _view.clearLayers();
            _view.addLayer(_animation);
            _view.addLayer(_timeLayer);
            _view.addLayer(_dateLayer);
            _view.addLayer(_cityLayer);
            _view.addLayer(_drawLayer);
            _view.addLayer(_batteryLayer);
            _view.addLayer(_iconLayer);
            _animation.play({:delegate => _delegator});
            updateTextLayers();
            
        }
    }

    function stop() {
        if(_playing) {
            _playing = false;
        }
    }

    function updateTextLayers() {
        // Clear the layer contents
        drawTime();
        drawDate();
        drawCity();
        drawLines();
        drawBattery();
        drawIcon();
    }

    function drawIcon() {
        var image = WatchUi.loadResource(Rez.Drawables.WWIcon);
        var dc = _iconLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var width = dc.getWidth();
        var height = dc.getHeight();
        var x_icon_position = width / 2 - 16;
        var height_icon = height / 2;
        dc.drawBitmap( x_icon_position, height_icon, image );
    }


    function drawBattery() {
        var battery = System.getSystemStats().battery;
        var font_battery = WatchUi.loadResource(Rez.Fonts.font_battery);
        var dc = _batteryLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        var width = dc.getWidth();
        var height = dc.getHeight();
        var x_battery_position = width / 2;
        var height_date = height / 2;
        
        if (System.getSystemStats().charging) {
            dc.drawText(x_battery_position, height_date, font_battery, "B",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
        else if (battery > 75) {
            dc.drawText(x_battery_position, height_date, font_battery, "A",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else if (battery > 50) {
            dc.drawText(x_battery_position, height_date, font_battery, "R",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else if (battery > 25) {
            dc.drawText(x_battery_position, height_date, font_battery, "S",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else {
           dc.drawText(x_battery_position, height_date, font_battery, "T",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }

    function drawLines() {
        var dc = _drawLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        
        dc.setPenWidth(2.5);
        dc.drawLine(72,90,300,90);
        dc.setPenWidth(1);
        dc.drawLine(200,90,335,145);
        dc.fillCircle(335, 145, 5);
    }

    function drawCity() {
        var font_city = WatchUi.loadResource(Rez.Fonts.font_city);
        var dc = _cityLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var width = dc.getWidth();
        var height = dc.getHeight();
        var x_city_position = width / _rate_x_start + 80;
        var height_date = height / 2;
        var city_string = "Divergence : Annecy";
        dc.drawText(x_city_position, height_date, font_city, city_string,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        
    }

    function drawDate() {
        var font_date = WatchUi.loadResource(Rez.Fonts.font_date);
        var dc = _dateLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        var width = dc.getWidth();
        var height = dc.getHeight();
        var x_bar_position = width / _rate_x_start + 40;
        var x_date_position = width / _rate_x_start + 40;
        var height_date = height / 2;
        dc.drawText(x_bar_position, height_date, font_date, "_____________",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format(
            "$1$ $2$ $3$ $4$",
            [
                today.day_of_week,
                today.day,
                today.month,
                today.year
            ]
        );
        dc.drawText(x_date_position, height/2.5, font_date,dateString,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);

    }
    
    function drawTime(){
        var time = getTimeString();
        var hour = time[0];
        var min = time[1];
        var sec = time[2];
        var font_time = WatchUi.loadResource(Rez.Fonts.font_time);
        var dc = _timeLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(_time_color, Graphics.COLOR_TRANSPARENT);
        var width = dc.getWidth();
        var height = dc.getHeight();
        var size_policy = 20;
        var hour_str;
        var space = 25;
        var x_hour_position = width / _rate_x_start;
        var height_time = height / 2;
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
        dc.drawText(x_hour_position, height_time, font_time, hour_str,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(x_first_space, height_time, font_time, ":",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(x_min_position, height_time, font_time, min,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
         dc.drawText(x_sec_space, height_time, font_time, ":",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(x_sec_position, height_time, font_time, sec,
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
        return [hour, min, sec];
    }
}