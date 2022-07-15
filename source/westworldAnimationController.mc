using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor as ActMon;
using Toybox.Activity as Act;
using Toybox.Weather as Weather;

class RehoboamAnimationController {
    private var _animation;
    private var _timeLayer;
    private var _dateLayer;
    private var _cityLayer;
    private var _downBarLayer;
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
            _downBarLayer = buildDownBarLayer();
            _drawLayer = buildDrawLayer();
            _batteryLayer = buildBatteryLayer();
            _iconLayer = buildIconLayer();
            _view.addLayer(_animation);
            _view.addLayer(_timeLayer);
            _view.addLayer(_dateLayer);
            _view.addLayer(_cityLayer);
            _view.addLayer(_downBarLayer);
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
        _downBarLayer = null;
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

    private function buildDownBarLayer(){
        var info = System.getDeviceSettings();
        // Word aligning the width and height for better blits
        var width = (info.screenWidth).toNumber() & ~0x3;
        var height = info.screenHeight * 0.5;

        var options = {
            :locX => ( info.screenWidth - width).toNumber() & ~0x03,
            :locY => (info.screenHeight - height) / 1.1,
            :width => width,
            :height => height,
            :visibility=>true
        };

        // Initialize the Time over the animation
        var barLayer = new WatchUi.Layer(options);
        return barLayer;
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
        _view.addLayer(_downBarLayer);
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
            _view.addLayer(_downBarLayer);
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
        drawDownBar();
        drawLines();
        drawHealthStatus();
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

    function drawHealthStatus() {
        var font_icons_str = WatchUi.loadResource(Rez.Fonts.font_icons_str);
        var dc = _batteryLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        var height = dc.getHeight();
        var height_icons = height / 1.8;
        drawWeather(dc, font_icons_str, height_icons, 2.75);
        drawBattery(dc, font_icons_str, height_icons, 2);
        drawHeart(dc, font_icons_str, height_icons, 1.55);

    }

    function drawWeather(dc, font_icons_str, height_icons, rate_width) {
        var temperature;
        var condition;
        var weather = getWeather();
        var font_weather = WatchUi.loadResource(Rez.Fonts.font_weather);
        var width = dc.getWidth();
        var height = dc.getHeight();
        var x_weather_position = width / rate_width;
        if (weather != null) {
            temperature = weather.temperature;
            condition = weather.condition;
            var clear = [0, 23];
            var rainy = [3,15,25,26, 49];
            var partially_cloudy = [1, 22];
            var cloudy = [2,20,52, 22];
            var snow = [4, 16, 17, 18, 19, 21, 34,43, 44, 51];
            var windy = [5];
            var storms = [6, 12, 28];
            var light_rain = [11, 13, 14, 24, 27, 45];
            var fog = [8, 33];
            if (clear.indexOf(condition) != -1){ //Weather is clear
            dc.drawText(x_weather_position, height_icons -5 , font_weather, "D",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            }
            else if (partially_cloudy.indexOf(condition) != -1){ //Weather is partially clear or partially cloudy
                dc.drawText(x_weather_position, height_icons -5 , font_weather, "B",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            }
            else if (cloudy.indexOf(condition) != -1){ //Weather is Cloudy
                dc.drawText(x_weather_position, height_icons -5 , font_weather, "A",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            }
            else if (rainy.indexOf(condition) != -1){ //Weather is rainy
                dc.drawText(x_weather_position, height_icons -5 , font_weather, "y",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            }
            else if (light_rain.indexOf(condition) != -1){ //Weather is  light rainy
                dc.drawText(x_weather_position, height_icons -5 , font_weather, "z",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            }
            else if (snow.indexOf(condition) != -1){ //Weather is snow
                dc.drawText(x_weather_position, height_icons -5 , font_weather, "u",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            }
            else if (windy.indexOf(condition) != -1){ //Weather is windy
                dc.drawText(x_weather_position, height_icons -5 , font_weather, "c",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            }
            else if (fog.indexOf(condition) != -1){ //Weather is fog
                dc.drawText(x_weather_position, height_icons -5 , font_weather, "f",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            }
            else if (storms.indexOf(condition) != -1){ //Weather is storm
                dc.drawText(x_weather_position, height_icons -5 , font_weather, "r",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            }
            else { //Unknown
                dc.drawText(x_weather_position, height_icons -5 , font_weather, "o",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            }
        }
        else {
            dc.drawText(x_weather_position, height_icons -5 , font_weather, "o",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
        
        
    }

    function getWeather() {
        var weather = Weather.getCurrentConditions();
        return weather;
    }

    function drawHeart(dc, font_icons_str, height_icons, rate_width) {
        var font_heart = WatchUi.loadResource(Rez.Fonts.font_icons);
        var width = dc.getWidth();
        var height = dc.getHeight();
        var x_heart_position = width / rate_width;
        var heartRate = getHeartRate();
        dc.drawText(x_heart_position, height_icons -5 , font_heart, "h",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);

        dc.drawText(x_heart_position, height_icons + +20 ,font_icons_str , heartRate,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function drawBattery(dc, font_icons_str, height_icons, rate_width) {
        var battery_str;
        var battery = System.getSystemStats().battery;
        if (battery == 100){
            battery_str = battery.format("%03d");
        }
        else {
            battery_str = battery.format("%02d");
        }
        var font_battery = WatchUi.loadResource(Rez.Fonts.font_battery);
        var width = dc.getWidth();
        var height = dc.getHeight();
        var x_battery_position = width / rate_width;
        if (System.getSystemStats().charging) {
            dc.drawText(x_battery_position, height_icons, font_battery, "[",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
        else if (battery > 75) {
            dc.drawText(x_battery_position, height_icons, font_battery, "A",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else if (battery > 50) {
            dc.drawText(x_battery_position, height_icons, font_battery, "R",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else if (battery > 25) {
            dc.drawText(x_battery_position, height_icons, font_battery, "S",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        } else {
           dc.drawText(x_battery_position, height_icons, font_battery, "T",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }

        dc.drawText(x_battery_position, height_icons  + 20 ,font_icons_str , battery_str,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function getHeartRate(){
        var heartRate;
        if (ActMon has :getHeartRateHistory) {
            heartRate = Act.getActivityInfo().currentHeartRate;
            if(heartRate==null) {
                var HRH=ActMon.getHeartRateHistory(1, true);
                var HRS=HRH.next();
                if(HRS!=null && HRS.heartRate!= ActMon.INVALID_HR_SAMPLE){
                    heartRate = HRS.heartRate;
                }
            }
            if(heartRate!=null) {
                heartRate = heartRate.toString();
            }
            else{
                heartRate = "--";
            }
        }
        else {
            heartRate = "--";
        }
        return heartRate;
    }

    function drawDownBar(){
        var font_bar = WatchUi.loadResource(Rez.Fonts.font_date);
        var dc = _downBarLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(183, 87, font_bar, "____________________",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function drawLines() {
        var dc = _drawLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        
        //dc.setPenWidth(2.5);
        //dc.drawLine(72,95,300,95);
        dc.setPenWidth(1);
        dc.drawLine(230,97,335,145);
        dc.fillCircle(335, 145, 5);
        dc.drawCircle(335, 145, 15);
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