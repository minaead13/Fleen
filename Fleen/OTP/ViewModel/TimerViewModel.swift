//
//  OTPViewModel.swift
//  Fleen
//
//  Created by Mina Eid on 15/01/2024.
//

import UIKit

protocol TimerViewModelDelegate : AnyObject {
    func timerDidUpdate(timeString : String)
    func timerDidFinish(buttonEnabled: Bool)
}

class TimerViewModel {
    
    weak var delegate : TimerViewModelDelegate?
    
    var isLoading : Observable<Bool> = Observable(false)
    var dataSource : VerifyCodeModel?
    
    var countdownTimer: Timer?
    var totalTimeInSeconds: TimeInterval = 120
    var timeRemaining: TimeInterval = 0
    private var isButtonEnabled: Bool = false
    var isValidOTP : Bool = false

    init() {
        startTimer()
    }
    
    func sendMobileNumber(viewController : UIViewController, phone : String, code : String , successCallback: (() -> Void)? = nil ){
        
        self.isLoading.value = true
        
        let parameters: [String: Any] = [
            "phone": phone ,
            "code" : code
        ]
       
        NetworkManager.instance.request(Endpoints.verifyCodeURL, parameters: parameters, method: .post, type: VerifyCodeModel.self, viewController: viewController) { [weak self] (data) in
            
            self?.success(data: data, successCallback: successCallback)
        
        }
    }
    
    private func success(data: BaseModel<VerifyCodeModel>? , successCallback: (() -> Void)?) {
        if data != nil {
            self.isLoading.value = false
            successCallback?()
            UserDefaults.standard.setValue(data?.data?.token, forKey: "token")
        } else {
            self.isLoading.value = false
          
            
            if let message = data?.message {
                //self.swiftMessage(title: "Error", body: message, color: .error, layout: .messageView, style: .bottom)
            }
        }
    }
    
    
    func startTimer(){
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timeRemaining = totalTimeInSeconds
    }
    
    @objc private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            let timeString = formatTime(timeRemaining)
            delegate?.timerDidUpdate(timeString: timeString)
        } else {
            countdownTimer?.invalidate()
            isButtonEnabled = true
            delegate?.timerDidFinish(buttonEnabled: isButtonEnabled)
        }
    }

    func restartTimer() {
        isButtonEnabled = false
        delegate?.timerDidFinish(buttonEnabled: isButtonEnabled)
        startTimer()
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
    
    func checkOTP(_ otpText: String){
        isValidOTP = validateOTP(otpText)
    }
    
    private func validateOTP(_ value : String) -> Bool{
        return !value.isEmpty
    }
    
}
