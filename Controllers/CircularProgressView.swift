import UIKit

class CircularProgressView: UIView {
    
    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    private let countdownLabel = UILabel()
    private var timer: Timer?
    private var duration: TimeInterval = 0
    private var elapsedTime: TimeInterval = 0
    
    var progressColor = UIColor(hex: "#004643") {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor = UIColor.lightGray {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
        setupLabel()
    }
    
    private func createCircularPath() {
        let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let circularPath = UIBezierPath(arcCenter: center, radius: frame.size.width / 2, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        
        // Track layer
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 10.0
        trackLayer.lineCap = .round
        trackLayer.frame = bounds
        layer.addSublayer(trackLayer)
        
        // Progress layer
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 10.0
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 1.0 // Start from full progress
        progressLayer.frame = bounds
        layer.addSublayer(progressLayer)
    }
    
    private func setupLabel() {
        countdownLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        countdownLabel.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        countdownLabel.textAlignment = .center
        countdownLabel.font = UIFont.systemFont(ofSize: 24)
        addSubview(countdownLabel)
    }
    
    func setProgressWithAnimation(duration: TimeInterval) {
        // Remove any existing animations
        progressLayer.removeAllAnimations()
        
        // Reset the progress layer
        progressLayer.strokeEnd = 1.0 // Start from full progress
        
        // Create the animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 1.0 // Start from full progress
        animation.toValue = 0.0 // Shrink to 0
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        // Use CATransaction to update strokeEnd after the animation completes
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.progressLayer.strokeEnd = 0.0 // Ensure final value is set
        }
        progressLayer.add(animation, forKey: "animateprogress")
        CATransaction.commit()
    }
    
    func startCountdown(duration: TimeInterval) {
        // Stop any existing timer and animation
        stopAnimation()
        
        // Set the duration and reset elapsed time
        self.duration = duration
        self.elapsedTime = 0
        countdownLabel.text = "\(Int(duration))"
        
        // Start the animation
        setProgressWithAnimation(duration: duration)
        
        // Start the timer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.elapsedTime += 1
            let remainingTime = Int(duration) - Int(self.elapsedTime)
            self.countdownLabel.text = "\(remainingTime)"
            
            if remainingTime <= 0 {
                timer.invalidate()
                self.timer = nil
                self.countdownLabel.text = "Time's up!"
            }
        }
    }
    
    func stopAnimation() {
        // Stop the timer
        timer?.invalidate()
        timer = nil
        
        // Remove the current animation
        progressLayer.removeAllAnimations()
        
        // Reset the progress bar to full progress
        progressLayer.strokeEnd = 1.0
        
        // Update the label to show the full duration
        countdownLabel.text = "\(Int(duration))"
    }
}
extension UIColor {
    // Create a UIColor from a hex string
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
