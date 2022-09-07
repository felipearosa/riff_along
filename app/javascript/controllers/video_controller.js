import { Controller } from "@hotwired/stimulus"
import YouTubePlayer from 'youtube-player';

// Connects to data-controller="video"
export default class extends Controller {
  static targets = [ "start", "stop", "list", "row", "control", "message", "soloform", 'master' ]
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
    this.soloNum = 0
    console.log(this. rowTargets)
    // this.rowTargets.forEach((row) => {
    //   this.soloformTargets.forEach((form) => {
    //     form.insertAdjacentHTML('beforeend', `<input value="${row.dataset.videoStart}, ${row.dataset.videoEnd}, ${row.dataset.soloId}" autocomplete="off" type="hidden" name="solos[time${this.soloNum}]" id="list_video_id"></input>`)
    //     this.soloNum += 1
    //   })
    // });

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
    this.messageTarget.innerHTML = `<p class="ms-3 mt-2">Recording your solo <i class="fa-solid fa-microphone-lines"></i></p>`
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
      <td class="container-td master-border text-center"><div> <img data-video-target="master" data-action="click->video#masterToggle" class ="new unmastered" src="../../../assets/mastered_icon.png"></div></td>
                <td class="container-td text-center"><div>${this.startTime} - ${this.endTime}</div></td>
                <td class="time-border" data-action="click->video#deleteRow"><div>❌</div></td>
            `
      this.listTarget.appendChild(row);
      this.soloNum += 1
      this.soloformTargets.forEach((form) => {
        form.insertAdjacentHTML('beforeend', `<input value="${this.exactStart}, ${this.exactEnd}, unmastered" autocomplete="off" type="hidden" name="solos[time${this.soloNum}]" id="list_video_id"></input>`)
      })
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
    this.controlTarget.innerHTML = `
    <div class="d-flex justify-content-around">
      <button type="button" class="btn color-btn btn-lg rounded-btn-nav"  data-video-start="${row.dataset.videoStart}" data-video-end="${row.dataset.videoEnd}" data-action="click->video#playSolo">Start Over</button>

      <button type="button" class="btn btn-dark btn-lg btn-block rounded-btn-nav"  data-video-start="${row.dataset.videoStart}" data-video-end="${row.dataset.videoEnd}" data-action="click->video#loop">Loop</button>
    </div>
    `

    this.#checkLoopActive(row);
  }

  deleteRow(e){
    const element = e.target;
    let row = element.closest('tr');
    console.log(row.dataset.videoStart);

    this.soloformTargets.forEach((form) => {
      let formInput = form.querySelector(`input[value="${row.dataset.videoStart}, ${row.dataset.videoEnd}, unmastered"]`);
      formInput.remove();
    })
    row.remove();
  }


  masterToggle(e){
    const element = e.target;
    console.log(element);
    if(element.className.includes("new")){
      this.#checkMastered(element);
    }
    element.classList.toggle("mastered");
    element.classList.toggle("unmastered");
  }


  #checkMastered(element){
    let row = element.closest('tr');
    if(element.className.includes("unmastered")){
      this.soloformTargets.forEach((form) => {
        let formInput = form.querySelector(`input[value="${row.dataset.videoStart}, ${row.dataset.videoEnd}, unmastered"]`);
        formInput.remove();
        this.soloNum += 1
        form.insertAdjacentHTML('beforeend', `<input value="${row.dataset.videoStart}, ${row.dataset.videoEnd}, mastered" autocomplete="off" type="hidden" name="solos[time${this.soloNum}]" id="list_video_id"></input>`)
      })
    } else {
      this.soloformTargets.forEach((form) => {
        let formInput = form.querySelector(`input[value="${row.dataset.videoStart}, ${row.dataset.videoEnd}, mastered"]`);
        formInput.remove();
        this.soloNum += 1
        form.insertAdjacentHTML('beforeend', `<input value="${row.dataset.videoStart}, ${row.dataset.videoEnd}, unmastered" autocomplete="off" type="hidden" name="solos[time${this.soloNum}]" id="list_video_id"></input>`);
      })

    }
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
    this.messageTarget.innerHTML = `<p class="ms-3 mt-2>Rock on! 🎸</p>`
    setTimeout(() => {
      this.messageTarget.innerHTML = ''
    }, 3000);
  }

  #turnSecIntoMin(seconds){
    let startTime
    if(seconds <60){
      const exactSecond = Math.floor(seconds)
      if(exactSecond <10){
        startTime = `00:0${exactSecond}`

      } else {
        startTime = `00:${exactSecond}`
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
