//
//  SpeechViewController.swift
//  GoT - My House
//
//  Created by Erin Gaughan on 11/28/17.
//  Copyright © 2017 Erin Gaughan. All rights reserved.
//

import UIKit
import Speech

class SpeechViewController: UIViewController, SFSpeechRecognizerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var textView: UILabel!
    @IBOutlet var microphoneButton: UIButton!
    @IBOutlet var nowPlayingAnimationImageView: UIImageView!
    @IBOutlet var pickerView: UIPickerView!
    
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    
    var resultSpeech = ""
    var charPicked = ""
    
    let characters = ["Random", "Bronn", "Brynden Tully", "Cersei", "The Hound", "Jaime Lannister", "Littlefinger", "Olenna Tyrell", "Renly Baratheon", "Tyrion", "Varys"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Now Playing Animation Bar Item on the navigation Bar
        createNowPlayingAnimation()
        
        microphoneButton.isEnabled = false
        
        speechRecognizer?.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func microphoneTapped(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            microphoneButton.isEnabled = false
            
            // Stop NowPlaying Animation
            stopNowPlayingAnimation()
            
            microphoneButton.setTitle("Start Recording", for: .normal)
            //print(resultSpeech)
            if self.resultSpeech.lowercased() == "give me a quote" {
                performSegue(withIdentifier: "SpeechResults", sender: self)
            }
            else {
                self.textView.text = "I couldn't understand what you said. Can you please say it again?"
            }
        } else {
            let indexNumber: Int = pickerView.selectedRow(inComponent: 0)
            charPicked = characters[indexNumber]
            
            resultSpeech = ""
            self.textView.text = ""
            
            startRecording()
            microphoneButton.setTitle("Stop Recording", for: .normal)
            
            // Start NowPlaying Animation
            startNowPlayingAnimation()
        }
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.resultSpeech = (result?.bestTranscription.formattedString)!
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            microphoneButton.isEnabled = true
        } else {
            microphoneButton.isEnabled = false
        }
    }
    
    /*
     -----------------------------------------------
     MARK: - UIPickerViewDataSource Protocol Methods
     -----------------------------------------------
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return characters.count
    }
    
    /*
     --------------------------------------------
     MARK: - UIPickerViewDelegate Protocol Method
     --------------------------------------------
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return characters[row]
    }
    
    /*
     -----------------------------
     MARK: - Now Playing Animation
     -----------------------------
     */
    
    func createNowPlayingAnimation() {
        
        /*
         The animationImages property of UIImageView object is an array of UIImage objects
         to use for animating now playing.
         
         The array of UIImage objects used for animation is created and returned by the
         class method createNowPlayingAnimatedBarImages() of the NowPlayingAnimation class.
         */
        
        nowPlayingAnimationImageView!.animationImages = NowPlayingAnimation.createNowPlayingAnimatedBarImages()
        nowPlayingAnimationImageView!.animationDuration = 0.7
        
    }
    
    func startNowPlayingAnimation() {
        nowPlayingAnimationImageView!.startAnimating()
    }
    
    func stopNowPlayingAnimation() {
        nowPlayingAnimationImageView!.stopAnimating()
    }
    
    /*
     -------------------------
     MARK: - Prepare For Segue
     -------------------------
     */
    
    // This method is called by the system whenever you invoke the method performSegue
    // You never call this method. It is invoked by the system.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SpeechResults" {
            
            // Obtain the object reference of the destination view controller
            let speechResultViewController: SpeechResultViewController = segue.destination as! SpeechResultViewController
            //print(charPicked)
            // Pass the data object to the destination view controller
            speechResultViewController.charPicked = charPicked
        }
    }
}

