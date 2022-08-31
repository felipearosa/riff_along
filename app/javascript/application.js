// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"


console.log('ok')


var done = false;
var player;
function onYouTubeIframeAPIReady() {
  player = new YT.Player('player', {
    height: '390',
    width: '640',
    videoId: '',
    playerVars: {
      'playsinline': 1
    },
    events: {
      'onReady': onPlayerReady,
      'onStateChange': onPlayerStateChange
    }
  });
  }


  function onPlayerStateChange(event) {
    if (event.data == YT.PlayerState.PLAYING && !done) {
      //setTimeout(stopVideo, 6000);
      //done = true;
    }
  }
  function stopVideo() {
    player.stopVideo();
  }



function onPlayerReady(event) {
  //event.target.playVideo();
  event.target.loadVideoById('IZBlqcbpmxY', 0.1, "large")

};

onYouTubeIframeAPIReady();
