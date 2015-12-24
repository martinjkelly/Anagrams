import UIKit

class HUDView: UIView {
    
    var stopwatch: StopwatchView
    var gamePoints: CounterLabelView
    
    //this should never be called
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(frame:")
    }
    
    override init(frame:CGRect) {
        self.stopwatch = StopwatchView(frame:CGRectMake(ScreenWidth/2-150, 0, 300, 100))
        self.stopwatch.setSeconds(0)
        
        self.gamePoints = CounterLabelView(font: FontHUD, frame: CGRectMake(ScreenWidth-200, 30, 200, 70))
        self.gamePoints.textColor = UIColor(red: 0.38, green: 0.098, blue: 0.035, alpha: 1)
        self.gamePoints.value = 0
        
        super.init(frame:frame)
        
        // points label
        var pointsLabel = UILabel(frame: CGRectMake(ScreenWidth-340, 30, 140, 70))
        pointsLabel.backgroundColor = UIColor.clearColor()
        pointsLabel.font = FontHUD
        pointsLabel.text = "Points: "
        
        self.addSubview(pointsLabel)

        self.addSubview(self.stopwatch)
        self.addSubview(self.gamePoints)
        
        self.userInteractionEnabled = false
    }
}