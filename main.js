requirejs(["rtmp-streamer"], function (RtmpStreamer) {

    var url = document.getElementById('url').value;
    var name = document.getElementById('stream-name').value;

    var streamer = new RtmpStreamer(document.getElementById('rtmp-streamer'));
    var player = new RtmpStreamer(document.getElementById('rtmp-player'));

    document.getElementById("play").addEventListener("click", function () {
        player.play(url, name);
    });

    document.getElementById("publish").addEventListener("click", function () {
        streamer.publish(url, name);
    });

    document.getElementById("streamer-disconnect").addEventListener("click", function () {
        streamer.disconnect();
    });

    document.getElementById("player-disconnect").addEventListener("click", function () {
        player.disconnect();
    });

});
