
require.config({
    paths: {
        "rtmp-streamer": "../rtmp-streamer.min"
    }
});

require(["rtmp-streamer"], function (RtmpStreamer) {

    var getUrl = function () {
        return document.getElementById('url').value;
    };

    var getName = function () {
        return document.getElementById('stream-name').value;
    };

    var streamer = new RtmpStreamer(document.getElementById('rtmp-streamer'));
    var player = new RtmpStreamer(document.getElementById('rtmp-player'));

    document.getElementById("play").addEventListener("click", function () {
        player.play(getUrl(), getName());
    });

    document.getElementById("publish").addEventListener("click", function () {
        streamer.publish(getUrl(), getName());
    });

    document.getElementById("streamer-disconnect").addEventListener("click", function () {
        streamer.disconnect();
    });

    document.getElementById("player-disconnect").addEventListener("click", function () {
        player.disconnect();
    });

});
