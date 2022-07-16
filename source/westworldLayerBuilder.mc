using Toybox.WatchUi;

class WestworldLayerBuilder {

    function initialize()  {

    }

    // Function to initialize the time layer
    function buildTimeLayer() {
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

    function buildDateLayer() {
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

    function buildCityLayer(){
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

    function buildDownBarLayer(){
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
    


    function buildDrawLayer(){
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

    function buildBatteryLayer(){
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

    function buildIconLayer(){
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



}