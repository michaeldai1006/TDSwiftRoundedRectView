  import Foundation
  import UIKit
  
  public class TDSwiftRoundedRectView: UIView {
    // Rect properties
    var strokeWidth: CGFloat = 5.0 { didSet { self.setNeedsDisplay() } }
    var strokeColor: CGColor = UIColor.gray.cgColor { didSet { self.setNeedsDisplay() } }
    var cornerRadius: CGFloat = 12.0 { didSet { self.setNeedsDisplay() } }
    var cornersRounded: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight] { didSet { self.setNeedsDisplay() } }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = .clear
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let drawingRect = calculateDrawingRect(baseOnRect: rect, strokeWidth: strokeWidth)
        
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        defer { context.restoreGState() }
        
        let path = UIBezierPath(roundedRect: drawingRect, byRoundingCorners: cornersRounded, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        context.addPath(path.cgPath)
        context.closePath()
        
        context.setLineWidth(strokeWidth)
        context.setStrokeColor(strokeColor)
        context.strokePath()
    }
    
    // Rect to draw base on view rect and stroke width
    private func calculateDrawingRect(baseOnRect rect: CGRect, strokeWidth width: CGFloat) -> CGRect {
        return CGRect(x: strokeWidth / 2, y: strokeWidth / 2, width: rect.width - width, height: rect.height - width)
    }
  }
