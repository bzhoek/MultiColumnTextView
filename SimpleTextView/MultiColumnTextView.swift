import UIKit

class MultiColumnTextView: UIView {

  var storage: NSTextStorage! {
    didSet {
      self.storage.addLayoutManager(layout)
      self.setNeedsDisplay()
      self.createColumns()
    }
  }

  var origins: [CGPoint] = []
  var layout: NSLayoutManager!
  
  var containers: [(NSTextContainer, CGPoint)] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.layout = NSLayoutManager()
    self.storage = NSTextStorage(string: "The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. ", attributes: [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleBody)])
  }
  
  func createColumns() {
    for _ in layout.textContainers {
      layout.removeTextContainerAtIndex(0)
    }
    
    self.containers = []
    
    let bounds = self.bounds
    
    let columns = 2
    let margin: CGFloat = 10
    
    let totalMargin = margin * (CGFloat(columns) - 1)
    let columnWidth = (bounds.size.width - totalMargin) / CGFloat(columns)
    
    let columnSize = CGSizeMake(columnWidth, bounds.size.height)
    
    var origins: [CGPoint] = []
    
    var x = bounds.origin.x
    let y = bounds.origin.y
    for _ in 0...columns {
      let container = NSTextContainer(size: columnSize)
      self.layout.addTextContainer(container)
      
      containers.append((container, CGPointMake(x, y)))
      origins.append(CGPointMake(x, y))
      x += columnWidth + margin
    }
    self.origins = origins
  }
  
  override func drawRect(rect: CGRect) {
    for (container, point) in containers {
      let range = layout.glyphRangeForTextContainer(container)
      layout.drawGlyphsForGlyphRange(range, atPoint: point)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.createColumns()
    self.setNeedsDisplay()
  }
  
}
