import Foundation

extension CGFloat {
  var radians: CGFloat {
    return self * CGFloat(2 * CGFloat.pi / 360)
  }

  var degrees: CGFloat {
    return 360.0 * self / (CGFloat.pi * 2)
  }
}
