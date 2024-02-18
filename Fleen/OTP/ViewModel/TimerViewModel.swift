//
//  OTPViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 15/01/2024.
//

import Foundation

protocol TimerViewModelDelegate : AnyObject {
    func timeDidUpdate(timeString : String)
    func timerDidFinish(buttonEnabled: Bool)
}

class TimerViewModel {
    weak var delegate : TimerViewModelDelegate?
    
    var countdownTimer: Timer?
    var totalTimeInSeconds: TimeInterval = 120
    var timeRemaining: TimeInterval = 0
    private var isButtonEnabled: Bool = true
    
    func startTimer(){
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timeRemaining = totalTimeInSeconds
    }
    
    @objc func updateTimer(){
        if timeRemaining > 0 {
            timeRemaining -= 1
            let timeString = formatTime(timeRemaining)
            isButtonEnabled.toggle()
            delegate?.timeDidUpdate(timeString: timeString)
        } else {
            countdownTimer?.invalidate()
            delegate?.timerDidFinish(buttonEnabled: isButtonEnabled)
            startTimer()
        }
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
           let minutes = Int(time) / 60
           let seconds = Int(time) % 60
           return String(format: "%02d:%02d", minutes, seconds)
       }
    
    func stopTimer() {
           countdownTimer?.invalidate()
       }
       
       deinit {
           stopTimer()
       }
    
}
