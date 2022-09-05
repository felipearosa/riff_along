import { Controller } from "@hotwired/stimulus"
import YouTubePlayer from 'youtube-player';

// Connects to data-controller="video"
export default class extends Controller {
  static targets = [ "start", "stop", "list", "row", "control", "message" ]
  static values = {
    slug: String
  }

  connect() {
    this.done = false;
    this.player = YouTubePlayer('player');
    this.player.loadVideoById(this.slugValue);
    this.player.playVideo();
    console.log('sworking2');
    this.recording == false;

    this.player.on('stateChange', (event) => {
      this.player.getPlayerState().then(data => {
        if (data === 1 && !this.recording) {
          this.startTarget.classList.remove('disabled')
        }
      })
    });
  }

  markStart(){
    this.player.getCurrentTime()
    .then(data => {
      this.exactStart = data
      this.startTime = this.#turnSecIntoMin(data);
    });
    this.recording = true;
    this.stopTarget.classList.remove('disabled');
    this.startTarget.classList.add('disabled');
    this.messageTarget.innerHTML = `<p>Recording your solo...</p>`
  }

  markStop(){
    this.player.getCurrentTime()
    .then(data => {
      this.exactEnd = data
      this.endTime = this.#turnSecIntoMin(data);


      const row = document.createElement('tr');
      row.dataset.action = "click->video#setRowActive";
      row.dataset.videoTarget = "row";
      row.dataset.videoStart = this.exactStart;
      row.dataset.videoEnd = this.exactEnd;
      if (this.startTime === 'NaN:NaN') {
        this.startTime = "Unloaded"
      }
      if (this.endTime === 'NaN:NaN') {
        this.startTime = "Unloaded"
      }
      row.innerHTML = `
                <td class="container-td text-center"><div>(mastered_img)</div></td>
                <td class="container-td text-center"><div>${this.startTime} - ${this.endTime}</div></td>
            `;
      this.listTarget.appendChild(row);
    });
    this.recording = false;
    this.stopTarget.classList.add('disabled');
    this.startTarget.classList.remove('disabled');
    this.#messageSucess();
  }

  playSolo(event){
    const element = event.target;
    this.#loadSolo(element)
    element.nextElementSibling.classList.remove('disabled');
    this.#checkLoopActive(element.nextElementSibling);
  }

  loop(event){
    const element = event.target;
    element.classList.toggle('loop-active');
    // console.log(element.className.includes("loop-active"))
    this.#checkLoopActive(element);
  }


  setRowActive(event){
    this.controlTarget.innerHTML = ``;

    const element = event.target;
    this.rowTargets.forEach((row) => {
      row.classList.remove('line-active');
    });
    let row = element.closest('tr');

    this.#loadSolo(row)

    row.classList.add('line-active');
    console.log(row.dataset.videoStart);

    this.controlTarget.innerHTML = `
    <div class="d-flex justify-content-around">
      <button type="button" class="btn color-btn btn-lg rounded-btn-nav"  data-video-start="${row.dataset.videoStart}" data-video-end="${row.dataset.videoEnd}" data-action="click->video#playSolo">Start Over</button>

      <button type="button" class="btn btn-dark btn-lg btn-block rounded-btn-nav"  data-video-start="${row.dataset.videoStart}" data-video-end="${row.dataset.videoEnd}" data-action="click->video#loop">Loop</button>
    </div>
    `

    this.#checkLoopActive(row);
  }


  #loadSolo(element){
    this.player.loadVideoById({'videoId': this.slugValue,
    'startSeconds': element.dataset.videoStart,
    'endSeconds': element.dataset.videoEnd,
    'suggestedQuality': 'large'});
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


  #messageSucess(){
    this.messageTarget.innerHTML = `<p>Rock on! 🎸</p>`
    setTimeout(() => {
      this.messageTarget.innerHTML = ''
    }, 3000);
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
