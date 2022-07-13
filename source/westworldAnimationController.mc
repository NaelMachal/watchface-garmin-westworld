using Toybox.WatchUi;

class RehoboamAnimationController {
    private var _animation;
    private var _textLayer;
    private var _playing;
    private var _need_playing;
    private var _delegator;
    private var _view;

    function initialize() {
        _playing = false;
        _need_playing = true;
        _delegator = new RehoboamAnimationDelegate(self);
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

    function play() {
        if (!_playing){
         //_view.addLayer(_animation);
         System.println("we are in the second play");
         System.println(_animation.play({
            :delegate => _delegator
            }));
        _playing = true;
        }
        else {
            System.println("let's continue");
            //_view.removeLayer(_animation);
            _view.clearLayers();
            _view.addLayer(_animation);
            _view.addLayer(_textLayer);
            System.println(_animation.play({
            :delegate => _delegator
            }));
            updateTimeLayer();
            
        }
        
        _need_playing = true;
        
    
    }

    function stop() {
        if(_playing) {
            _animation.stop();
            _playing = false;
            _need_playing = true;
        }
    }

    function updateTimeLayer() {
        var dc = _textLayer.getDc();
        var width = dc.getWidth();
        var height = dc.getHeight();

        // Clear the layer contents
        var timeString = getTimeString();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
        dc.clear();
        // Draw the time in the middle
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width / 3, height / 2, Graphics.FONT_NUMBER_MEDIUM, timeString,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function getTimeString() {
        var clockTime = System.getClockTime();
        var info = System.getDeviceSettings();
        var hour = clockTime.hour;

        if( !info.is24Hour ) {
            hour = clockTime.hour % 12;
            if (hour == 0) {
                hour = 12;
            }
        }

        return Lang.format("$1$:$2$:$3$", [hour, clockTime.min.format("%02d"),clockTime.sec.format("%02d")]);
    }

}