using Toybox.WatchUi;
using Toybox.Application;

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
    //private var _time_color;
    //private var _date_color;
    private var _layer_builder;
    private var _drawer;
    

    function initialize() {
        _playing = false;
        _delegator = new RehoboamAnimationDelegate(self);
        _layer_builder = new WestworldLayerBuilder();
        _drawer = new WestworldDrawer();
        //_time_color = Application.getApp().getProperty("time_color");
        //_date_color = Application.getApp().getProperty("date_color");
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
            _timeLayer = _layer_builder.buildTimeLayer();
            _dateLayer = _layer_builder.buildDateLayer();
            _cityLayer = _layer_builder.buildCityLayer();
            _downBarLayer = _layer_builder.buildDownBarLayer();
            //_drawLayer = _layer_builder.buildDrawLayer();
            _batteryLayer = _layer_builder.buildBatteryLayer();
            _iconLayer = _layer_builder.buildIconLayer();
            _view.addLayer(_animation);
            _view.addLayer(_timeLayer);
            _view.addLayer(_dateLayer);
            _view.addLayer(_cityLayer);
            _view.addLayer(_downBarLayer);
            //_view.addLayer(_drawLayer);
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
        //_drawLayer = null;
        _downBarLayer = null;
        _batteryLayer = null;
        _iconLayer = null;
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
        //_view.addLayer(_drawLayer);
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
            //_view.addLayer(_drawLayer);
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
        _drawer.drawTime(_timeLayer);
        _drawer.drawDate(_dateLayer);
        _drawer.drawCity(_cityLayer);
        _drawer.drawDownBar(_downBarLayer);
        //_drawer.drawLines(_drawLayer);
        _drawer.drawHealthStatus(_batteryLayer);
        _drawer.drawIcon(_iconLayer);
    }

    
}