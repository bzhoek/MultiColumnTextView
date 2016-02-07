import UIKit

class MultiColumnTextView: UIView {

  var storage: NSTextStorage! {
    didSet {
      self.storage.addLayoutManager(layout)
      self.setNeedsDisplay()
      self.createColumns()
    }
  }

  var layout: NSLayoutManager!
  
  var containers: [(NSTextContainer, CGPoint)] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.layout = NSLayoutManager()
    
    if let url = NSBundle.mainBundle().URLForResource("content", withExtension:"txt") {
      do {
        try self.storage = NSTextStorage(URL: url, options: [NSDocumentTypeDocumentAttribute:NSPlainTextDocumentType], documentAttributes: nil)
      } catch let error as NSError {
        print(error)
      }
    } else {
      self.storage = NSTextStorage(string: "Ad corpus diceres pertinere-, sed ea, quae dixi, ad corpusne refers? Quid igitur dubitamus in tota eius natura quaerere quid sit effectum? Ab his oratores, ab his imperatores ac rerum publicarum principes extiterunt. Tu vero, inquam, ducas licet, si sequetur; Nummus in Croesi divitiis obscuratur, pars est tamen divitiarum. Itaque hoc frequenter dici solet a vobis, non intellegere nos, quam dicat Epicurus voluptatem.", attributes: [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleBody)])
    }
  }
  
  func createColumns() {
    for _ in layout.textContainers {
      layout.removeTextContainerAtIndex(0)
    }
    
    self.containers.removeAll()
    
    let bounds = self.bounds
    
    let columns = 2
    let margin: CGFloat = 10
    
    let columnsMargin = margin * (CGFloat(columns) - 1)
    let columnWidth = (bounds.size.width - columnsMargin) / CGFloat(columns)
    let rowHeight = (bounds.size.height - margin) / 2
    
    let container = NSTextContainer(size: CGSizeMake(bounds.width, rowHeight))
    self.layout.addTextContainer(container)
    
    containers.append((container, bounds.origin))
    
    let columnSize = CGSizeMake(columnWidth, rowHeight)
    var x = bounds.origin.x
    let y = rowHeight + margin
    
    for _ in 0...columns {
      let container = NSTextContainer(size: columnSize)
      self.layout.addTextContainer(container)
      
      containers.append((container, CGPointMake(x, y)))
      x += columnWidth + margin
    }
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
