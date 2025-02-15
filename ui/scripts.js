const { createApp } = Vue;

createApp({
    data() {
        return {
            projectName: '',
            
            // Subtitles and Quest 1 Values
            showSubtitle: null,
            showHit: null,
            currentHits: 0,
            requirement: 0,
            hits: [
                {value: null},
                {value: null},
                {value: null}
            ],
            showQuest: null,
            showProgress : null,
            questTip: '',
            currentPumkins: 0,
            targetPumpkins: 0,
			currentSubtitle: "",
            subtitles: [
				{text: "Bine ai venit drag prieten!", duration: 1500, soundName: "first.mp3"}, // 2100 sunetul - 3150 cu delay
				{text: "Eu sunt Nae Moraru, șeful departamentului de protecție civilă.", duration: 4900, soundName: "second.mp3"}, // 4850 sunetul - 5900 cu delay
				{text: "Și de curând, Magul Suprem a început să-și planteze dovlecii bombă prin zonele cu tehnologie.", duration: 7180, soundName: "third.mp3"}, // 7130 sunetul - 8180 cu delay
				{text: "Acesta având scopul de a distruge serverele orașului nostru!", duration: 5000, soundName: "fourth.mp3"}, //4903 sunetul - 6000 cu delay
				{text: "Scopul tău este să distrugi acești dovleci bombă.", duration: 4250, soundName: "fifth.mp3"}, // 4111 sunetul - 5250 cu delay
				{text: "Iată, aici este primul dovleac!", duration: 3100, soundName: "sixth.mp3"}, // 3050 sunetul - 4100 cu delay
				{text: "Îți urez noroc!", duration: "1700", soundName: "seventh.mp3"} // 1684 sunetu - 2700 cu delay
			],
            secondSubtitles: [
                {text: "Bine ai revenit!", duration: 1450, soundName: "first_2.mp3"}, // 1412 sunetul - 2450 cu delay
				{text: "După cum deja știi Magul suprem tot încearcă să ne saboteze orașul.", duration: 5050, soundName: "second_2.mp3"}, // 5028 sunetul - 6050 cu delay
				{text: "Scopul tău de data aceasta este să te infiltrezi în locația acestuia!", duration: 5300, soundName: "third_2.mp3"}, // 5264 sunetul - 6300 cu delay
				{text: "Infiltrat în locația acestuia va trebuii să îi furi secretele și să le ștergi!", duration: 6150, soundName: "fourth_2.mp3"}, // 6127 sunetul - 7150 cu delay
				{text: "După ce ai furat secretele, eu te voi aștepta înapoi pentru a mi le înmâna.", duration: 5150, soundName: "fifth_2.mp3"}, // 5104 sunetul - 6150 cu delay
                {text: "Îți urez noroc!", duration: "1700", soundName: "seventh.mp3"} // 1684 sunetu - 2700 cu delay
            ],

            // Mind Game Values
            showMindGame: null,
            showMindGameWrapper: null,
            showMindGameTitle: null,
            mindGameTitle: '',
            showMindGameNumber: null,
            mindGameNumber: 0,
            showMindGameInput: null,
            mindGameInput: null,

            // Mini Game Values
            showMinigame: null,
            clockInterval: 0,
            currentTime: 0,
            openApps: [],
            apps:[
                {name: "Terminal", picture: "terminal.png", selected: false, type: "terminal"},
                {name: "Secretele mele", picture: "folder.png", selected: false, type: "folder"},
                {name: "External Drive", picture: "usb.png", selected: false, type: "folder"}
            ],
            showAuth: null,
            originalText: 'NFRDevelopment69',
            displayedText: '',
            characters: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{};:,.<>?',
            speed: 50,
            currentIndex: 0,
            iterations: 8,
            currentIteration: 0,
            showProceedButton: null,
            showTerminal: null,
            openTerminal: null,
            showFolder: null,
            openFolder: null,
            showApps: null,
            terminalCommands: [
                {text: "If you want to move Folder 'Secretele_mele' to /media press Y"},
                {text: "root@magulsuprem69 > cp -r 'Secretele_mele' /media > Press enter to proceed"},
                {text: "Transfering 'Secretele_mele' to /media ▒▒▒▒▒▒▒▒▒▒ 0%"},
                {text: "Transfer complete, would you like to delete Folder 'Secretele_mele' permanently? If so press Y."},
                {text: "Deleting Folder 'Secretele_mele' ▒▒▒▒▒▒▒▒▒▒ 0%"},
                {text: "Folder deleted, you will now be signed out! > Press enter to proceed"}
            ],
            ranCommands: [],

            // Quest Selector values
            showQuestSelector: null,
            showHandleSecrets: null,

            // Roulette values
            rewards: [
                { title: "Candy", picture: "candy.png", chance: 30 }, 
                { title: "Car", picture: "car.png", chance: 5 }, 
                { title: "Cash", picture: "cash.png", chance: 30 }, 
                { title: "Money Bag", picture: "moneybag.png", chance: 20 }, 
                { title: "Gift", picture: "gift.png", chance: 15 }, 
              ], // Array of rewards with their chances
              currentSector: 0, // the sector currently highlighted
              spinning: false, // flag to prevent multiple spins
              winner: null, // the final result
              spinInterval: null, // interval ID for the spinning effect
              startSpin: null,
              showRewardsList: null,
              roulettePrice: 50,
        };
    },
    methods: {
        toggleSubtitle(text, duration, soundName) {
            this.currentSubtitle = text
            this.showSubtitle = true;
			const audio = new Audio(`${soundName}`);
            audio.play().catch(error => {
                console.error("Error playing sound:", error);
            });
			audio.play();
            return new Promise((resolve) => {
                setTimeout(() => {
                    this.showSubtitle = false;
					setTimeout(() => {
						resolve(true);
					}, 1000);
                }, duration);
            });
        },
		async startSubtitles(quest){
            if(quest === 1){
                for (const [index, subtitle] of this.subtitles.entries()) {
                    await this.toggleSubtitle(this.subtitles[index].text, this.subtitles[index].duration, this.subtitles[index].soundName);
                }
            }else if(quest === 2){
                for (const [index, subtitle] of this.secondSubtitles.entries()) {
                    await this.toggleSubtitle(this.secondSubtitles[index].text, this.secondSubtitles[index].duration, this.secondSubtitles[index].soundName);
                }
            }
		},
        updateTime(){
            this.currentTime = new Date().toLocaleTimeString();
        },
        startHackingEffect() {
            const randomizeText = () => {
              this.displayedText = this.originalText
                .split('')
                .map((char, index) => (index < this.currentIndex ? char : this.characters[Math.floor(Math.random() * this.characters.length)]))
                .join('');
            };
      
            const updateText = () => {
              if (this.currentIndex < this.originalText.length) {
                if (this.currentIteration < this.iterations) {
                  this.currentIteration++;
                  randomizeText();
                } else {
                  this.currentIteration = 0;
                  this.currentIndex++;
                }
                setTimeout(updateText, this.speed);
              } else {
                this.displayedText = this.originalText;
                this.showProceedButton = true;
              }
            };
            updateText();
        },
        closeAuth(){
            if(this.showProceedButton){
                this.showAuth = !this.showAuth
                this.showApps = true
            }
        },
        clickApp(app){
            if(app.selected){
                if(app.name === "Terminal" && !this.openTerminal){
                    this.startTerminal()
                    this.openTerminal = true
                    this.openApps.push(app)
                }else if(app.name === "Secretele mele" && !this.openFolder || app.name === "External Drive" && !this.openFolder){
                    if(!this.showFolder){
                        this.showFolder = true
                        this.openFolder = true
                        this.openApps.push({name: 'folder', picture: 'folder.png', type: 'folder'})
                    }
                }
            }else{
                this.apps.forEach((apps, index) => {
                      apps.selected = false;
                });
                app.selected = true
            }
        },
        updateProgress(text, interval = 1000, index, callback) {
            let progress = 0;
            const totalBlocks = 10;
            const timer = setInterval(() => {
              progress += 10;
              const filledBlocks = Math.floor(progress / 10);
              const emptyBlocks = totalBlocks - filledBlocks;
          
              const updatedText = text.replace(/▒+/g, '█'.repeat(filledBlocks) + '▒'.repeat(emptyBlocks))
                                      .replace(/\d+%/, `${progress}%`);
          
              this.ranCommands[index].text = updatedText
          
              if (progress >= 100) {
                clearInterval(timer);
                callback(true);
              }
            }, interval);
        },
        startTerminal(){
            if(!this.showTerminal){
                this.showTerminal = true
                setTimeout(() => {
                    this.ranCommands.push(this.terminalCommands[0])
                    const firstCommand = (first) => {
                        if (first.key === 'y' || first.key === 'Y') {
                            window.removeEventListener('keydown', firstCommand);
                            this.ranCommands.push(this.terminalCommands[1])
                            const secondCommand = (second) => {
                                if(second.key === 'Enter'){
                                    window.removeEventListener('keydown', secondCommand);
                                    this.ranCommands.push(this.terminalCommands[2])
                                    const onFirstComplete = (isFinished) => {
                                        if (isFinished) {
                                            this.ranCommands.push(this.terminalCommands[3])
                                            const thirdCommand = (third) => {
                                                if(third.key === 'y' || third.key === 'Y'){
                                                    window.removeEventListener('keydown', thirdCommand);
                                                    this.ranCommands.push(this.terminalCommands[4])
                                                    const onSecondComplete = (isFinished) => {
                                                        this.apps.splice(1, 1)
                                                        this.ranCommands.push(this.terminalCommands[5])
                                                        const fourthCommand = (fourth) => {
                                                            if(fourth.key === 'Enter'){
                                                                this.showMinigame = false
                                                                $.post(`https://${this.projectName}/stoleSecrets`, JSON.stringify({}), function(x){});
                                                            }
                                                        }
                                                        window.addEventListener('keydown', fourthCommand);
                                                    }
                                                    this.updateProgress(this.terminalCommands[4].text, 1000, 4, onSecondComplete);
                                                }
                                            }
                                            window.addEventListener('keydown', thirdCommand);
                                        }
                                    }
                                    this.updateProgress(this.terminalCommands[2].text, 1000, 2, onFirstComplete);
                                }
                            } 
                            window.addEventListener('keydown', secondCommand);
                        }
                      };
                    window.addEventListener('keydown', firstCommand);
                }, 1500);
            }
        },
        controlApp(type, appType){
            if(type === 'close'){
                if(appType === 'folder'){
                    this.showFolder = false
                    this.openFolder = false

                    const index = this.openApps.findIndex(app => app.name === "Folder")
    
                    if(index !== 1){
                        this.openApps.splice(index, 1)
                    }
                }
            }else if(type === 'minimize'){
                if(appType === 'folder'){
                    this.showFolder = false
                }else if(appType === 'terminal'){
                    this.showTerminal = false
                }
            }
        },
        showApp(type){
            if(type === "terminal"){
                this.showTerminal = true
            }else if(type === "folder"){
                this.showFolder = true
            }
        },
        startQuest(quest){
            if(quest === 1 && this.showQuestSelector){
                $.post(`https://${this.projectName}/startQuest`, JSON.stringify({ quest: 1 }), function(x){});
                this.showQuestSelector = false
            }else if(quest === 2 && this.showQuestSelector){
                $.post(`https://${this.projectName}/startQuest`, JSON.stringify({ quest: 2 }), function(x){});
                this.showQuestSelector = false
            }
        },
        startMindGame(){
            console.log(this.showMindGame)
            console.log(this.showMindGameTitle)
            console.log(this.mindGameTitle)
            console.log(this.showMindGameNumber)
            console.log(this.mindGameNumber)
            console.log(this.showMindGameInput)
            console.log(this.mindGameInput)
            this.showMindGame = true
            this.showMindGameWrapper = true
            this.mindGameTitle = 'Memorează numarul următor!'
            const minCeiled = Math.ceil(100000);
            const maxFloored = Math.floor(999999);
            this.mindGameNumber = Math.floor(Math.random() * (maxFloored - minCeiled) + minCeiled);
            setTimeout(() => {
                console.log('here')
                this.showMindGameTitle = 1
                setTimeout(() => {
                    console.log('here2')
                    this.showMindGameTitle = 2
                    this.showMindGameNumber = true
                    setTimeout(() => {
                        console.log('here3')
                        this.showMindGameNumber = false
                        this.showMindGameTitle = 1
                        this.mindGameTitle = 'Scrie codul anterior mai jos!'
                        setTimeout(() => {
                            console.log('here4')
                            this.showMindGameTitle = 2
                            this.showMindGameInput = true
                            setTimeout(() => {
                                console.log('here5')
                                if(parseInt(this.mindGameInput) === this.mindGameNumber){
                                    this.showMindGameWrapper = false
                                    setTimeout(() => {
                                        this.showMindGame = null
                                        $.post(`https://nfr_halloween/mindGameResult`, JSON.stringify({ result: 1 }), function(x){});
                                    }, 1000)
                                }else{
                                    this.showMindGameWrapper = false
                                    setTimeout(() => {
                                        this.showMindGame = null
                                        this.showMindGameTitle = null
                                        this.mindGameTitle = ''
                                        this.showMindGameNumber = null
                                        this.mindGameNumber = 0
                                        this.showMindGameInput = null
                                        this.mindGameInput = null
                                        $.post(`https://nfr_halloween/mindGameResult`, JSON.stringify({ result: 0 }), function(x){});
                                    }, 1000)
                                }
                            }, 10000);
                        }, 1000);
                    }, 10000);
                }, 1000);
            }, 1000);
        },
        finishQuest(){
            if(this.showQuestSelector && this.showHandleSecrets){
                this.showQuestSelector = false
                this.showHandleSecrets = false
                $.post(`https://nfr_halloween/finishQuest`, JSON.stringify({}), function(x){});
            }
        },
        spinRoulette() {
            if (this.spinning) return; // prevent another spin while one is active
      
            this.spinning = true;
            this.winner = null;
            this.currentSector = 0; // reset to start
            this.startSpin = true
            setTimeout(() => {
                this.startSpin = null
            }, 1000);

      
            // Calculate the winner
            this.winner = this.calculateWinner();
            const winnerIndex = this.rewards.findIndex(reward => reward.title === this.winner.title);
      
            // Total spins (to give it a more exciting effect)
            const totalSpins = 25; // Total spins to make it look exciting
            let spinCount = 0; // Counter for spins
            let speed = 100; // Starting speed in milliseconds
      
            const spin = () => {
              this.currentSector = (this.currentSector + 1) % this.rewards.length; // Move to next sector
              spinCount++;
      
              // Gradually slow down towards the end
              if (spinCount >= totalSpins - 5) { // Adjust the last 5 spins to slow down
                speed += 20; // Increase delay towards the end for smoother stop
              }
      
              // Continue spinning until we reach the total spins
              if (spinCount < totalSpins) {
                this.spinInterval = setTimeout(spin, speed); // Continue spinning
              } else {
                clearTimeout(this.spinInterval); // Stop spinning
                this.spinning = false;
                this.currentSector = winnerIndex; // Land on the winning sector
              }
            };
      
            // Start spinning
            spin();
          },
          calculateWinner() {
            // Create a cumulative chance array
            const cumulativeChances = [];
            let total = 0;
      
            for (const reward of this.rewards) {
              total += reward.chance;
              cumulativeChances.push(total);
            }
      
            const randomValue = Math.random() * total; // Get a random value between 0 and total
            // Determine which reward corresponds to the random value
            for (let i = 0; i < cumulativeChances.length; i++) {
              if (randomValue < cumulativeChances[i]) {
                return this.rewards[i]; // Return the corresponding reward
              }
            }
      
            return null; // Fallback in case no winner is determined (shouldn't happen)
          },
          toggleRewardsList() {
            if (this.showRewardsList){
                this.showRewardsList = false
            }else {
                this.showRewardsList = true
            }
          }
    },
	mounted() {
        window.addEventListener('message', (event) => {
            var data = event.data;
            if (data.type === "startSubtitles") {
                this.startSubtitles(data.quest)
            }else if(data.type === "projectName"){
                this.projectName = data.projectName
            }else if(data.type === "updateHit"){

                this.requirement = data.requirement
                this.currentHits = data.currentHits
                this.currentPumpkins = data.currentPumpkins
                this.targetPumpkins = data.targetPumpkins
                const index = data.currentHits - 1
                if(this.requirement === 1){
                    this.hits[2].value = true
                }else if(this.requirement === 2){
                    if(this.currentHits === 1){this.hits[1].value = true}else if(this.currentHits === 2){this.hits[2].value = true}
                }else if(this.requirement === 3){
                    this.hits[index].value = true
                }
                
                this.showHit = true
                setTimeout(() => {
                    this.showHit = false
                    this.hits[0].value = false
                    this.hits[1].value = false
                    this.hits[2].value = false
                }, 2500);
            }else if(data.type === "toggleQuest"){
                this.currentPumpkins = data.currentPumpkins
                this.targetPumpkins = data.targetPumpkins
                this.showQuest = !this.showQuest
                this.showProgress = !this.showProgress
            }else if(data.type === "toggleQuestSelector"){
                this.showQuestSelector = !this.showQuestSelector
                this.showHandleSecrets = data.hasSecrets

            }else if(data.type === "startMindGame"){
                this.startMindGame();
            }else if(data.type === "startMiniGame"){
                this.clockInterval = setInterval(this.updateTime, 1000)
                this.showMinigame = true
                setTimeout(() => {
                    this.showAuth = true
                    setTimeout(() => {
                        this.startHackingEffect();
                    }, 1000);
                }, 1000);
            }else if(data.type === "updateQuest"){
                if(data.hide === true){
                    if(this.showQuest){this.showQuest = false}
                }else{
                    if(this.showQuest){this.showQuest = false}
                    this.showProgress = false
                    setTimeout(() => {
                        this.showQuest = true
                        this.questTip = data.tip
                    }, 1000);
                }
            }
        });
    },
    unmounted(){
        clearInterval(this.clockInterval)
    }
}).mount('#app');
