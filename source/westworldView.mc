using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;

class RehoboamView extends WatchUi.WatchFace {
    private var _animationDelegate;
    var _sleepmode;
    var _has_animation_stopped_in_sleep;
    var _has_clock_stopped_in_sleep;
    
    function initialize() {
        WatchFace.initialize();
        _animationDelegate = new RehoboamAnimationController();
        _sleepmode = false;
        _has_animation_stopped_in_sleep = false;
        _has_clock_stopped_in_sleep = false;
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));       
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        _animationDelegate.setCountAnimationRepete(0);
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
            /*
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
            dc.clear();
            
            System.println("new update with sleep");
            if (!_has_clock_stopped_in_sleep){
                System.println("clock stopped");
                //_animationDelegate.clearTextLayer();
                //_animationDelegate.clearLayers();
                 _animationDelegate.handleOnHide(self);
                 _animationDelegate.handleOnShow(self);
                 _animationDelegate.play();
                _has_clock_stopped_in_sleep = true;
            }
            */
            if (!_has_animation_stopped_in_sleep){
                _animationDelegate.clearAnimationLayer();
                 _has_animation_stopped_in_sleep = true;
            }
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
            dc.clear();
            _animationDelegate.updateTextLayers();
            /*
            System.println(_animationDelegate.getCountAnimationRepete());
            if (!_has_animation_stopped_in_sleep){
                if (_animationDelegate.getCountAnimationRepete() > 2){
                    System.println("count worked");
                    _animationDelegate.handleOnHide(self);
                    //_animationDelegate.clearLayers();
                    _has_animation_stopped_in_sleep = true;
                }
            }
            */
        }
        return;
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
        //_animationDelegate.setCountAnimationRepete(0);
        _has_animation_stopped_in_sleep = false;
        _has_clock_stopped_in_sleep = false;
        _sleepmode = false;
        _animationDelegate.handleOnHide(self);
        _animationDelegate.handleOnShow(self);
        _animationDelegate.play();
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
        //_animationDelegate.setCountAnimationRepete(0);
        //System.println("stopping animaton"); 
        _sleepmode = true;
    }

    function handleOnEnterSleep() {
        _animationDelegate.handleOnHide(self);
    }


}