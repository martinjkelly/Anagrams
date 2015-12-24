import UIKit

class HUDView: UIView {
    
    var stopwatch: StopwatchView
    
    //this should never be called
    required init?(coder aDecoder:NSCoder) {
        fatalError("use init(frame:")
    }
    
    override init(frame:CGRect) {
        self.stopwatch = StopwatchView(frame:CGRectMake(ScreenWidth/2-150, 0, 300, 100))
        self.stopwatch.setSeconds(0)
        
        super.init(frame:frame)
        self.addSubview(self.stopwatch)
    }
}