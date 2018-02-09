# rtmp-streamer [![npm version](https://badge.fury.io/js/rtmp-streamer.svg)](https://badge.fury.io/js/rtmp-streamer)

<a href="http://www.wtfpl.net/"><img
       src="http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-4.png"
       width="80" height="15" alt="WTFPL" /></a>
       
[![NPM](https://nodei.co/npm/rtmp-streamer.png)](https://npmjs.org/package/rtmp-streamer)

> 浏览器中通过内嵌swf推rtmp流的javascript库


#### Demo

可在任何http容器中加载项目目录来运行demo

如 [http-server](https://www.npmjs.com/package/http-server):

```bash
 $ http-server -p 8888 
```

或 [PHP build-in web server](http://php.net/manual/en/features.commandline.webserver.php):

```bash
 $ php -S 0.0.0.0:8888 
```

访问 `http://localhost:8888/demo`

![screenshot](http://blog.chxj.name/content/images/2016/06/screenshot.png)


#### Install

```
 $ npm install rtmp-streamer
```

OR

```
 $ bower install rtmp-streamer
```


#### Tutorial

`rtmp-streamer` 遵循[AMD](http://requirejs.org/docs/whyamd.html)规范，可通过[`require.js`](http://requirejs.org/)等方式加载, 另外, 请确保在页面中引入了`RtmpStreamer.swf`, 否则`rtmp-streamer`将无法正确载入。

```html
<object>
    <embed id="rtmp-streamer" src="../RtmpStreamer.swf" bgcolor="#999999" quality="high"
           width="320" height="240" allowScriptAccess="sameDomain" type="application/x-shockwave-flash"></embed>
</object>
```

```javascript
require(["rtmp-streamer"], function (RtmpStreamer) {
  var streamer = new RtmpStreamer(document.getElementById('rtmp-streamer'));
  streamer.publish(url, name);
});

```


#### Document

```javascript
  /**
   * Push video to RTMP stream from local camera.
   *
   * @param url  - The RTMP stream URL
   * @param name - The RTMP stream name
   */
   function publish(url, name);

  /**
   * Pull video from RTMP stream.
   *
   * @param url  - The RTMP stream URL
   * @param name - The RTMP stream name
   */
   function play(url, name);

  /**
   * Disconnect from RTMP stream
   */
   function disconnect();

  /**
   * Set the screen width and height.
   *
   * @param width  - The screen width (pixels). The default value is 320.
   * @param height - The screen height (pixels). The default value is 240.
   */
   function setScreenSize(width, height);

  /**
   * Set the screen position.
   *
   * @param x - The screen horizontal position (pixels). The default value is 0.
   * @param y - The screen vertical position (pixels). The default value is 0.
   */
   function setScreenPosition(x, y);

  /**
   * Set the camera mode.
   *
   * @param width  - The requested capture width (pixels). The default value is 640.
   * @param height - The requested capture height (pixels). The default value is 480.
   * @param fps    - The requested capture frame rate, in frames per second. The default value is 15.
   */
   function setCamMode(width, height, fps);

  /**
   * Set the camera frame interval.
   *
   * @param frameInterval - The number of video frames transmitted in full (called keyframes) instead of being interpolated by the video compression algorithm.
   * The allowed values are 1 through 300.
   * The default value is 15, which means that every 15th frame is a keyframe. A value of 1 means that every frame is a keyframe.
   */
   function setCamFrameInterval(frameInterval);

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
   function setCamQuality(bandwidth, quality);

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
   function setMicQuality(quality);

  /**
   * Set the microphone rate.
   *
   * @param rate - The rate at which the microphone is capturing sound, in kHz. Acceptable values are 5, 8, 11, 22, and 44.
   * The default value is 44.
   */
   function setMicRate(rate);

```


#### 快速搭建一个RTMP服务器？试试Wowza(https://www.wowza.com/free-trial)

[Install & Configuration](https://www.wowza.com/forums/content.php?217-How-to-install-and-configure-Wowza-Streaming-Engine)

![wowza](http://blog.chxj.name/content/images/2016/06/wowza.png)


#### 采用直播云服务

以[七牛云](https://www.qiniu.com/products/pili)为例:

设置参数的方式和用OBS等工具推流时的方式类似, 地址为直播云的空间名, 数据流名称为直播流的名称加鉴权参数:

![](http://blog.chxj.name/content/images/2017/03/Screen-Shot-2017-03-12-at-3.16.09-PM.png)


在七牛的直播云管理后台中预览推流视频:

![](http://blog.chxj.name/content/images/2017/03/Screen-Shot-2017-03-12-at-2.01.27-PM.png)



