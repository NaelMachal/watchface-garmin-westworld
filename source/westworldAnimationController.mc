using Toybox.WatchUi;

class RehoboamAnimationController {
    private var _animation;
    private var _textLayer;
    private var _playing;
    private var _need_playing;
    private var _delegator;
    private var _view;
    private var _count_repete_animation;

    function initialize() {
        _playing = false;
        _need_playing = true;
        _delegator = new RehoboamAnimationDelegate(self);
        _count_repete_animation = 0;
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
            _textLayer = buildTextLayer();

            _view.addLayer(_animation);
            _view.addLayer(_textLayer);
        }

    }

    function handleOnHide(view) {
        view.clearLayers();
        _animation = null;
        _textLayer = null;
    }

    // Function to initialize the time layer
    private function buildTextLayer() {
        var info = System.getDeviceSettings();
        // Word aligning the width and height for better blits
        var width = (info.screenWidth * .60).toNumber() & ~0x3;
        var height = info.screenHeight * .25;

        var options = {
            :locX => ( (info.screenWidth - width) / 2 ).toNumber() & ~0x03,
            :locY => (info.screenHeight - height) / 2,
            :width => width,
            :height => height,
            :visibility=>true
        };

        // Initialize the Time over the animation
        var textLayer = new WatchUi.Layer(options);
        return textLayer;
    }

    function getTextLayer() {
        return _textLayer;
    }

    function getNeedPlaying() {
        return _need_playing;
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
        _view.addLayer(_textLayer);
    }

    function clearTextLayer(){
        _view.clearLayers();
        _view.addLayer(_animation);
        _animation.play({:delegate => _delegator});
    }

    function play() {
        System.println("has been asked to play");
        if (!_playing){
         //_view.addLayer(_animation);
         _animation.play({:delegate => _delegator});
        _playing = true;
        }
        else {
            _count_repete_animation = _count_repete_animation + 1;
            _view.clearLayers();
            _view.addLayer(_animation);
            _view.addLayer(_textLayer);
            _animation.play({:delegate => _delegator});
            updateTimeLayer();
            
        }
        _need_playing = true;
    }

    function stop() {
        System.println(_playing);
        if(_playing) {
            System.println(_animation.stop());
            _playing = false;
            _need_playing = true;
        }
    }

    function updateTimeLayer() {
        // Clear the layer contents
        var time = getTimeString();
        var time_hour = time[0];
        var time_min = time[1];
        var time_sec = time[2];
        drawTime(time_hour, time_min, time_sec);
    }
    
    function drawTime(hour, min, sec){
        var font_time = WatchUi.loadResource(Rez.Fonts.font_time);
        var dc = _textLayer.getDc();
        var width = dc.getWidth();
        var height = dc.getHeight();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var size_policy = 20;
        var hour_str;
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
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(x_first_space, height / 2, font_time, ":",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(x_min_position, height / 2, font_time, min,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
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
        return [hour, min, sec];
    }
}