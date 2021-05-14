import PromiseKit

class GlobalTimer: NSObject {

    static let shared = GlobalTimer()

    var internalTimer: Timer?
    var startDate: Date?

    private override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(checkExpiredTime), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    func startTimer(withInterval interval: Double) {
        print("start timer")

        startDate = Date()
        internalTimer?.invalidate()

        internalTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(fireTimerAction), userInfo: nil, repeats: false)
    }

    func resetTimer() {
        guard internalTimer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }

        var dateDelta = 0.0

        if let startDate = self.startDate {
            dateDelta = Date().timeIntervalSince(startDate)
        }

        if dateDelta > 5 {
            internalTimer?.invalidate()
            self.startTimer(withInterval: AppConstants.sessionDuration)
        }
    }

    func stopTimer() {
        startDate = nil
        internalTimer?.invalidate()
        internalTimer = nil
    }
    
    @objc func fireTimerAction(sender: AnyObject?) {
        expireSession()
    }

    func expireSession() {
        stopTimer()

        LoadingLayer.shared.stopAnimating()

        print("Session Expired")

        //Action for session expiring
    }

    @objc func checkExpiredTime() {
        guard let startDate = startDate else {
            return
        }

        let dateDelta = Date().timeIntervalSince(startDate)
        print("Session time duration is: \(dateDelta)")

        let loggedIn = false
        
        if dateDelta >= AppConstants.sessionDuration || !loggedIn {
            fireTimerAction(sender: nil)
        } else {
            resetTimer()
        }
    }

}
