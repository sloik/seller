
import SwiftUI

extension DesignSystem {

    public enum Padding {

        case smaller(_ edges: Edge.Set)
        case base   (_ edges: Edge.Set)
        case bigger (_ edges: Edge.Set)

        @available(*, deprecated, message: "👨‍🎨 Design System: Please use any other value!")
        case custom(edges: Edge.Set, length: CGFloat)
    }
}

extension DesignSystem.Padding {
    var length: CGFloat {
        switch self {
        case .smaller:                  return 12
        case .base:                     return 16
        case .bigger:                   return 20
        case .custom(_, let length):    return length
        }
    }

    var edges: Edge.Set {
        switch self {
        case .smaller(let edges):       return edges
        case .base(let edges):          return edges
        case .bigger(let edges):        return edges
        case .custom(let edges, _):     return edges
        }
    }
}
