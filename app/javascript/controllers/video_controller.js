import { Controller } from "@hotwired/stimulus"
import YouTubePlayer from 'youtube-player';

// Connects to data-controller="video"
export default class extends Controller {
  static targets = [ "start", "stop", "list", "row" ]
  static values = {
    slug: String
  }

  connect() {
    this.done = false;
    this.player = YouTubePlayer('player');
    this.player.loadVideoById(this.slugValue);
    this.player.playVideo();
    console.log('sworking2');
  }

  markStart(){
    this.player.getCurrentTime()
    .then(data => {
      this.exactStart = data
      this.startTime = this.#turnSecIntoMin(data);
    });
  }

  markStop(){
    this.player.getCurrentTime()
    .then(data => {
      this.exactEnd = data
      this.endTime = this.#turnSecIntoMin(data);


      const row = document.createElement('tr');
      row.dataset.action = "click->video#setRowActive";
      row.dataset.videoTarget = "row";
      row.innerHTML = `
                <td>(mastered_img)</td>
                <td>${this.startTime} - ${this.endTime}</td>
                <td class="btn btn-primary" data-video-start="${this.exactStart}" data-video-end="${this.exactEnd}" data-action="click->video#playSolo">Go to Solo</td>
                <td class="btn btn-primary disabled" data-video-start="${this.exactStart}" data-video-end="${this.exactEnd}" data-action="click->video#loop">Go to Loop</td>
            `;
      this.listTarget.appendChild(row);
    });
  }

  playSolo(event){
    const element = event.target;
    this.player.loadVideoById({'videoId': this.slugValue,
    'startSeconds': element.dataset.videoStart,
    'endSeconds': element.dataset.videoEnd,
    'suggestedQuality': 'large'});

    element.nextElementSibling.classList.remove('disabled')
    this.#checkLoopActive(element.nextElementSibling)
  }

  loop(event){
    const element = event.target;
    element.classList.toggle('loop-active');
    // console.log(element.className.includes("loop-active"))
    this.#checkLoopActive(element);
  }

  #checkLoopActive(element){
    if(element.className.includes("loop-active")){
      this.player.on('stateChange', (event) => {
        this.player.getPlayerState().then(data => {
          if (data === 0 ) {
            this.player.loadVideoById({'videoId': this.slugValue,
            'startSeconds': element.dataset.videoStart,
            'endSeconds': element.dataset.videoEnd,
            'suggestedQuality': 'large'});
          }
        })
      });
    } else {
      this.player.on('stateChange', (event) => {
        this.player.getPlayerState().then(data => {
          if (data === 0) {
            this.player.stopVideo()
          }
        })
      });
    }
  }

  setRowActive(event){
    const element = event.target;
    this.rowTargets.forEach((row) => {
      row.classList.remove('line-active');
    })
    element.closest('tr').classList.add('line-active')
  }

  #turnSecIntoMin(seconds){
    let startTime
    if(seconds <60){
      const exactSecond = Math.floor(seconds)
      if(exactSecond <10){
        startTime = `0:0${exactSecond}`

      } else {
        startTime = `0:${exactSecond}`
      }
    } else {
      const startTimeMin = Math.floor(seconds/60)
      const startTimeSec = Math.floor(seconds%60)

      if(startTimeSec <10){
        startTime = `${startTimeMin}:0${startTimeSec}`

      } else {
        startTime = `${startTimeMin}:${startTimeSec}`
      }

    }

    return startTime
  }
}
