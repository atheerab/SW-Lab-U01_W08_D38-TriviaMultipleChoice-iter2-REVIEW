//
//  ViewController.swift
//  TriviaMultipleChoice-AtheerAbdullalhAlatawi
//
//  Created by Atheer abdullah on 19/04/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  
  @IBOutlet weak var valueScoreLabel: UILabel!
  
  @IBOutlet weak var questionLabel: UILabel!
  
  
  @IBOutlet weak var optionFirstButton: UIButton!
  
  @IBOutlet weak var optionSecondButten: UIButton!
  
  @IBOutlet weak var optionThirdButten: UIButton!
  
  @IBOutlet weak var optionFourthButten: UIButton!
  
  @IBOutlet weak var progressBar: UIProgressView!
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    update()
    configureButtons()
    progressBar.progress = 0.0
  }
  var quiz = Quiz()
  var player: AVAudioPlayer?
  
  @IBAction func answerButton(_ sender: UIButton) {
    let selectedChoice = sender.currentTitle!
    if quiz.checkAnswer(selectedChoice){
      sender.backgroundColor = UIColor.systemGreen
    }else{
      sender.backgroundColor = UIColor.systemRed
    }
    
    Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {sender.backgroundColor = UIColor.clear })
    
    if quiz.nextQuestion() {
      
    }else{
      showAlertMessage()
    }
    
  }
  
  
  func startGame(action: UIAlertAction! = nil){
    quiz.score = 0
    update()
  }
  
  
  func showAlertMessage(){
    hasUserGoodScore()
    let alert = UIAlertController(title: "Game over", message: "Your score is \(quiz.getScore())", preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Play again ?", style: .default , handler: startGame ))
    
    present(alert, animated: true )
  }
  
  
  @objc func update(){
    valueScoreLabel.text = "\(quiz.getScore())"
    questionLabel.text = quiz.getQuestion()
    progressBar.progress = quiz.getProgress()
    
    optionFirstButton.setTitle(quiz.getChoices()[0],for: .normal)
    optionSecondButten.setTitle(quiz.getChoices()[1],for: .normal)
    optionThirdButten.setTitle(quiz.getChoices()[2],for: .normal)
    optionFourthButten.setTitle(quiz.getChoices()[3],for: .normal)
  }
  
  
  func configureButtons(){
    
    optionFirstButton.layer.borderColor = UIColor.white.cgColor
    optionFirstButton.layer.borderWidth = 3
    optionFirstButton.layer.cornerRadius = 30
    optionFirstButton.layer.masksToBounds = true
    
    optionSecondButten.layer.borderColor = UIColor.white.cgColor
    optionSecondButten.layer.borderWidth = 3
    optionSecondButten.layer.cornerRadius = 30
    optionSecondButten.layer.masksToBounds = true
    
    optionThirdButten.layer.borderColor = UIColor.white.cgColor
    optionThirdButten.layer.borderWidth = 3
    optionThirdButten.layer.cornerRadius = 30
    optionThirdButten.layer.masksToBounds = true
    
    optionFourthButten.layer.borderColor = UIColor.white.cgColor
    optionFourthButten.layer.borderWidth = 3
    optionFourthButten.layer.cornerRadius = 30
    optionFourthButten.layer.masksToBounds = true
    
  }
  
  
  func hasUserGoodScore() {
    Double(quiz.getScore()) >= 17.5 ? playSound() : stopSound()
  }
  
  
  func playSound() {
    guard let url = Bundle.main.url(forResource: "winner", withExtension: "mp3") else { return }
    
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      
      /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      
      /* iOS 10 and earlier require the following line:
       player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
      
      guard let player = player else { return }
      
      player.play()
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  
  func stopSound(){
    player?.stop()
  }
  
}





