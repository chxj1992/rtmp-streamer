var isReady = false;

// Global method for ActionScript
function setSWFIsReady() {
    if (!isReady) {
        console.log('swf is ready!');
        isReady = true;
    }
}

define('rtmp-streamer', function () {
    return function RtmpStreamer(elem) {

        /**
         * Embed swf element, eg. <embed src="*.swf"></embed>.
         */
        var _elem = elem;

        if (!isReady) {
            setTimeout(function () {
                return RtmpStreamer(elem);
            }, 1000);
        }

        /**
         * Push video to RTMP stream from local camera.
         *
         * @param url  - The RTMP stream URL
         * @param name - The RTMP stream name
         */
        this.publish = function (url, name) {
            _elem.publish(url, name);
        };

        /**
         * Pull video from RTMP stream.
         *
         * @param url  - The RTMP stream URL
         * @param name - The RTMP stream name
         */
        this.play = function (url, name) {
            _elem.play(url, name);
        };

        /**
         * Disconnect from RTMP stream
         */
        this.disconnect = function () {
            _elem.disconnect();
        };

        /**
         * Set the screen width and height.
         *
         * @param width  - The screen width (pixels). The default value is 320.
         * @param height - The screen height (pixels). The default value is 240.
         */
        this.setScreenSize = function (width, height) {
            _elem.setScreenSize(width, height);
        };

        /**
         * Set the screen position.
         *
         * @param x - The screen horizontal position (pixels). The default value is 0.
         * @param y - The screen vertical position (pixels). The default value is 0.
         */
        this.setScreenPosition = function (x, y) {
            _elem.setScreenPosition(x, y);
        };

        /**
         * Set the camera mode.
         *
         * @param width  - The requested capture width (pixels). The default value is 640.
         * @param height - The requested capture height (pixels). The default value is 480.
         * @param fps    - The requested capture frame rate, in frames per second. The default value is 15.
         */
        this.setCamMode = function (width, height, fps) {
            _elem.setCamMode(width, height, fps);
        };


        /**
         * Set the camera frame interval.
         *
         * @param frameInterval - The number of video frames transmitted in full (called keyframes) instead of being interpolated by the video compression algorithm.
         * The allowed values are 1 through 300.
         * The default value is 15, which means that every 15th frame is a keyframe. A value of 1 means that every frame is a keyframe.
         */
        this.setCamFrameInterval = function (frameInterval) {
            _elem.setCamFrameInterval(frameInterval);
        };

        /**
         * Set the camera quality.
         *
         * @param bandwidth - Specifies the maximum amount of bandwidth that the current outgoing video feed can use, in bytes per second (bps).
         *    To specify that the video can use as much bandwidth as needed to maintain the value of quality, pass 0 for bandwidth.
         *    The default value is 200000.
         * @param quality   - An integer that specifies the required level of picture quality, as determined by the amount of compression
         *     being applied to each video frame. Acceptable values range from 1 (lowest quality, maximum compression) to 100
         *    (highest quality, no compression). To specify that picture quality can vary as needed to avoid exceeding bandwidth, pass 0 for quality.
         *    The default value is 90.
         */
        this.setCamQuality = function (bandwidth, quality) {
            _elem.setCamQuality(bandwidth, quality);
        };

        /**
         * Set the microphone quality.
         *
         * @param quality - The encoded speech quality when using the Speex codec. Possible values are from 0 to 10.
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
         * The default value is 9.
         */
        this.setMicQuality = function (quality) {
            _elem.setMicQuality(quality);

        };

        /**
         * Set the microphone rate.
         *
         * @param rate - The rate at which the microphone is capturing sound, in kHz. Acceptable values are 5, 8, 11, 22, and 44.
         * The default value is 44.
         */
        this.setMicRate = function (rate) {
            _elem.setMicRate(rate);
        }

    };


});