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
         * swf插件元素, 即 <embed src="*.swf"></embed>
         */
        var _elem = elem;

        if (!isReady) {
            setTimeout(function () {
                return RtmpStreamer(elem);
            }, 1000);
        }

        this.publish = function (url, name) {
            _elem.publish(url, name);
        };

        this.play = function (url, name) {
            _elem.play(url, name);
        };

        this.disconnect = function () {
            _elem.disconnect();
        };

    };


});