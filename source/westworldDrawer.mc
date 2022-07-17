using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor as ActMon;
using Toybox.Activity as Act;
using Toybox.Weather as Weather;

class WestworldDrawer {
    private var _rate_x_start;

    function initialize()  {
        _rate_x_start = 5;
    }

    function drawIcon(_iconLayer) {
        //var image = WatchUi.loadResource(Rez.Drawables.WWIcon);
        var dc = _iconLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var width = dc.getWidth();
        var height = dc.getHeight();
        var x_icon_position = width / 2 - 16;
        var height_icon = height / 2;
        //dc.drawBitmap( x_icon_position, height_icon, image );
    }

    function drawHealthStatus(_batteryLayer) {
        var font_icons_str = WatchUi.loadResource(Rez.Fonts.font_icons_str);
        var dc = _batteryLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        var height = dc.getHeight();
        var height_icons = height / 1.8;
        //drawWeather(dc, font_icons_str, height_icons, 2.75);
        drawDistance(dc, font_icons_str, height_icons, 2.75);
        drawBattery(dc, font_icons_str, height_icons, 2);
        drawHeart(dc, font_icons_str, height_icons, 1.55);
    }

    function drawDistance(dc, font_icons_str, height_icons, rate_width) {
        var font_steps = WatchUi.loadResource(Rez.Fonts.font_steps);
        var width = dc.getWidth();
        var height = dc.getHeight();
        var x_heart_position = width / rate_width;
        var distance = getCurrentDistance();
        dc.drawText(x_heart_position, height_icons -5 , font_steps, "a",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);

        dc.drawText(x_heart_position, height_icons +20 ,font_icons_str , distance,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function getCurrentDistance() {
        var distance;
        distance = ActMon.getInfo().distance;
        if(distance!=null) {
            distance = (distance / 100000.0);
            distance = distance.format("%0.1f");
        }
        else{
            distance = "--";
        }
        return distance;
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
            temperature = weather.temperature.format("%02d");
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
            dc.drawText(x_weather_position, height_icons + +20 ,font_icons_str , temperature,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
        else {
            dc.drawText(x_weather_position, height_icons -5 , font_weather, "o",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            dc.drawText(x_weather_position, height_icons + +20 ,font_icons_str , "--",
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

        dc.drawText(x_heart_position, height_icons +20 ,font_icons_str , heartRate,
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
            /*
            if(heartRate==null) {
                var HRH=ActMon.getHeartRateHistory(1, true);
                var HRS=HRH.next();
                if(HRS!=null && HRS.heartRate!= ActMon.INVALID_HR_SAMPLE){
                    heartRate = HRS.heartRate;
                }
            }
            */
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

    function drawDownBar(_downBarLayer){
        var font_bar = WatchUi.loadResource(Rez.Fonts.font_date);
        var dc = _downBarLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(183, 87, font_bar, "____________________",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function drawLines(_drawLayer) {
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

    function drawCity(_cityLayer) {
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

    function drawDate(_dateLayer) {
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
    
    function drawTime(_timeLayer){
        var time = getTimeString();
        var hour = time[0];
        var min = time[1];
        var sec = time[2];
        var font_time = WatchUi.loadResource(Rez.Fonts.font_time);
        var dc = _timeLayer.getDc();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
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