import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="video"
export default class extends Controller {

  static values = {
    slug: String
  }


  connect() {
    this.done = false

    console.log(this.slugValue);
    this.onYouTubeIframeAPIReady()
  }




  onPlayerStateChange = (event) => {
    console.log('ok onPlayerStateChange')
    if (event.data == YT.PlayerState.PLAYING && !this.done) {
      //setTimeout(stopVideo, 6000);
      //done = true;
    }
  }

  stopVideo = () => {
    console.log('ok stopVideo')
    this.player.stopVideo();
  }



  onPlayerReady = (event) => {
    console.log('ok onPlayerReady')
    //event.target.playVideo();
    event.target.loadVideoById(slug , 0.1, "large")
  };

  onYouTubeIframeAPIReady = () => {
    console.log('ok onYouTubeIframeAPIReady')
    this.player = new YT.Player('player', {
      height: '390',
      width: '640',
      videoId: '',
      playerVars: {
        'playsinline': 1
      },
      events: {
        'onReady': (event) => this.onPlayerReady(event),
        'onStateChange': (event) => this.onPlayerStateChange(event)
      }
    });
  }


}
