using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;

class RehoboamView extends WatchUi.WatchFace {
    private var _animationDelegate;
    var _sleepmode;
    var _has_animation_stopped_in_sleep;
    
    function initialize() {
        WatchFace.initialize();
        _animationDelegate = new RehoboamAnimationController();
        _sleepmode = false;
        _has_animation_stopped_in_sleep = false;
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

    // Update the view
    function onUpdate(dc) {
        if (!_sleepmode){
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
            dc.clear();
            _animationDelegate.updateTextLayers();
            
        }
        if (_sleepmode){
            if (!_has_animation_stopped_in_sleep){
                _animationDelegate.clearAnimationLayer();
                 _has_animation_stopped_in_sleep = true;
            }
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
            dc.clear();
            _animationDelegate.updateTextLayers();
        }
        return;
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
        _has_animation_stopped_in_sleep = false;
        _sleepmode = false;
        _animationDelegate.handleOnHide(self);
        _animationDelegate.handleOnShow(self);
        _animationDelegate.play();
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
        _sleepmode = true;
    }

    function handleOnEnterSleep() {
        _animationDelegate.handleOnHide(self);
    }


}