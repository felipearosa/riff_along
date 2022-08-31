import { Controller } from "@hotwired/stimulus"
import YouTubePlayer from 'youtube-player';

// Connects to data-controller="video"
export default class extends Controller {
  static targets = [ "start", "stop" ]
  static values = {
    slug: String
  }


  connect() {
    console.log(this.startTarget);
    this.done = false;
    this.player = YouTubePlayer('player');
    this.player.loadVideoById(this.slugValue);
    this.player.playVideo();
  }

  markStart(){
    console.log('working');
    this.player.getCurrentTime()
    .then(data => {
      console.log(data)
    });
  }


  // onPlayerStateChange = (event) => {
  //   console.log('ok onPlayerStateChange')
  //   if (event.data == YT.PlayerState.PLAYING && !this.done) {
  //     //setTimeout(stopVideo, 6000);
  //     //done = true;
  //   }
  // }

  // stopVideo = () => {
  //   console.log('ok stopVideo')
  //   this.player.stopVideo();
  // }



  // onPlayerReady = (event) => {
  //   console.log('ok onPlayerReady')
  //   //event.target.playVideo();
  //   event.target.loadVideoById(slug , 0.1, "large")
  // };

  // onYouTubeIframeAPIReady = () => {
  //   console.log('ok onYouTubeIframeAPIReady')
  //   this.player = YouTubePlayer('video', {
  //     videoId: 'M7lc1UVf-VE'
  //   });


    // this.player = new YT.Player('player', {
    //   height: '390',
    //   width: '640',
    //   videoId: '',
    //   playerVars: {
    //     'playsinline': 1
    //   },
    //   events: {
    //     'onReady': (event) => this.onPlayerReady(event),
    //     'onStateChange': (event) => this.onPlayerStateChange(event)
    //   }
    // });
  //}


}
