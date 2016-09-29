package {

import flash.display.MovieClip;
import flash.external.ExternalInterface;
import flash.net.NetConnection;
import flash.events.NetStatusEvent;
import flash.net.NetStream;
import flash.media.Video;
import flash.media.Camera;
import flash.media.Microphone;

//import flash.media.H264Profile;
//import flash.media.H264VideoStreamSettings;

public class RtmpStreamer extends MovieClip {

    internal var nc:NetConnection;
    internal var ns:NetStream;
    internal var nsPlayer:NetStream;
    internal var vidPlayer:Video;
    internal var cam:Camera;
    internal var mic:Microphone;

    internal var _camWidth:int = 640;
    internal var _camHeight:int = 480;
    internal var _camFps:int = 15;
    internal var _camFrameInterval:int = 25;
    internal var _camBandwidth:int = 200000;
    internal var _camQuality:int = 90;

    internal var _micQuality:int = 9;
    internal var _micRate:int = 44;

    internal var _screenWidth:int = 320;
    internal var _screenHeight:int = 240;
    internal var _screenX:int = 0;
    internal var _screenY:int = 0;


    public function RtmpStreamer() {
        ExternalInterface.addCallback("setScreenSize", setScreenSize);
        ExternalInterface.addCallback("setScreenPosition", setScreenPosition);
        ExternalInterface.addCallback("setCamMode", setCamMode);
        ExternalInterface.addCallback("setCamFrameInterval", setCamFrameInterval);
        ExternalInterface.addCallback("setCamQuality", setCamQuality);

        ExternalInterface.addCallback("setMicQuality", setMicQuality);
        ExternalInterface.addCallback("setMicRate", setMicRate);

        ExternalInterface.addCallback("publish", publish);
        ExternalInterface.addCallback("play", playVideo);
        ExternalInterface.addCallback("disconnect", disconnect);

        ExternalInterface.call("setSWFIsReady");
    }

    public function setScreenSize(width:int, height:int):void {
        _screenWidth = width;
        _screenHeight = height;
    }

    public function setScreenPosition(x:int, y:int):void {
        _screenX = x;
        _screenY = y;
    }

    public function setCamMode(width:int, height:int, fps:int):void {
        _camWidth = width;
        _camHeight = height;
        _camFps = fps;
    }

    public function setCamFrameInterval(frameInterval:int):void {
        _camFrameInterval = frameInterval;
    }

    public function setCamQuality(bandwidth:int, quality:int):void {
        _camBandwidth = bandwidth;
        _camQuality = quality;
    }

    public function setMicQuality(quality:int):void {
        _micQuality = quality;
    }

    public function setMicRate(rate:int):void {
        _micRate = rate;
    }

    public function publish(url:String, name:String):void {
        this.connect(url, name, function (name:String):void {
            publishCamera(name);
            displayPublishingVideo();
        });
    }

    public function playVideo(url:String, name:String):void {
        this.connect(url, name, function (name:String):void {
            displayPlaybackVideo(name);
        });
    }

    public function disconnect():void {
        nc.close();
    }

    private function connect(url:String, name:String, callback:Function):void {
        nc = new NetConnection();
        nc.addEventListener(NetStatusEvent.NET_STATUS, function (event:NetStatusEvent):void {
            ExternalInterface.call("console.log", "try to connect to " + url);
            ExternalInterface.call("console.log", event.info.code);
            if (event.info.code == "NetConnection.Connect.Success") {
                callback(name);
            }
        });
        nc.connect(url);
    }

    private function publishCamera(name:String):void {
//        Cam

        cam = Camera.getCamera();

        /**
         * public function setMode(width:int, height:int, fps:Number, favorArea:Boolean = true):void
         *  width:int — The requested capture width, in pixels. The default value is 160.
         *  height:int — The requested capture height, in pixels. The default value is 120.
         *  fps:Number — The requested capture frame rate, in frames per second. The default value is 15.
         */
        cam.setMode(_camWidth, _camHeight, _camFps);

        /**
         * public function setKeyFrameInterval(keyFrameInterval:int):void
         * The number of video frames transmitted in full (called keyframes) instead of being interpolated by the video compression algorithm.
         * The default value is 15, which means that every 15th frame is a keyframe. A value of 1 means that every frame is a keyframe.
         * The allowed values are 1 through 300.
         */
        cam.setKeyFrameInterval(_camFrameInterval);

        /**
         * public function setQuality(bandwidth:int, quality:int):void
         * bandwidth:int — Specifies the maximum amount of bandwidth that the current outgoing video feed can use, in bytes per second (bps).
         *    To specify that the video can use as much bandwidth as needed to maintain the value of quality, pass 0 for bandwidth.
         *    The default value is 16384.
         * quality:int — An integer that specifies the required level of picture quality, as determined by the amount of compression
         *     being applied to each video frame. Acceptable values range from 1 (lowest quality, maximum compression) to 100
         *    (highest quality, no compression). To specify that picture quality can vary as needed to avoid exceeding bandwidth,
         *    pass 0 for quality.
         */
        cam.setQuality(_camBandwidth, _camQuality);

        /**
         * public function setProfileLevel(profile:String, level:String):void
         * Set profile and level for video encoding.
         * Possible values for profile are H264Profile.BASELINE and H264Profile.MAIN. Default value is H264Profile.BASELINE.
         * Other values are ignored and results in an error.
         * Supported levels are 1, 1b, 1.1, 1.2, 1.3, 2, 2.1, 2.2, 3, 3.1, 3.2, 4, 4.1, 4.2, 5, and 5.1.
         * Level may be increased if required by resolution and frame rate.
         */
//            var h264setting:H264VideoStreamSettings = new H264VideoStreamSettings();
//            h264setting.setProfileLevel(H264Profile.MAIN, 4);


//            Mic

        mic = Microphone.getMicrophone();

        /*
         * The encoded speech quality when using the Speex codec. Possible values are from 0 to 10. The default value is 6.
         * Higher numbers represent higher quality but require more bandwidth, as shown in the following table.
         * The bit rate values that are listed represent net bit rates and do not include packetization overhead.
         * ------------------------------------------
         * Quality value | Required bit rate (kbps)
         *-------------------------------------------
         *      0        |       3.95
         *      1        |       5.75
         *      2        |       7.75
         *      3        |       9.80
         *      4        |       12.8
         *      5        |       16.8
         *      6        |       20.6
         *      7        |       23.8
         *      8        |       27.8
         *      9        |       34.2
         *      10       |       42.2
         *-------------------------------------------
         */
        mic.encodeQuality = _micQuality;

        /* The rate at which the microphone is capturing sound, in kHz. Acceptable values are 5, 8, 11, 22, and 44. The default value is 8 kHz
         * if your sound capture device supports this value. Otherwise, the default value is the next available capture level above 8 kHz that
         * your sound capture device supports, usually 11 kHz.
         *
         */
        mic.rate = _micRate;


        ns = new NetStream(nc);
//        H.264 Setting
//        ns.videoStreamSettings = h264setting;
        ns.attachCamera(cam);
        ns.attachAudio(mic);
        ns.publish(name, "live");
    }

    private function displayPublishingVideo():void {
        vidPlayer = getPlayer();
        vidPlayer.attachCamera(cam);
        addChild(vidPlayer);
    }

    private function displayPlaybackVideo(name:String):void {
        nsPlayer = new NetStream(nc);
        nsPlayer.play(name);
        vidPlayer = getPlayer();
        vidPlayer.attachNetStream(nsPlayer);
        addChild(vidPlayer);
    }

    private function getPlayer():Video {
        vidPlayer = new Video(_screenWidth, _screenHeight);
        vidPlayer.x = _screenX;
        vidPlayer.y = _screenY;

        return vidPlayer;
    }

}

}
