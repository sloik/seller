
import SwiftUI

extension DesignSystem {

    public enum Padding {

        /// 6
        case tiny   (_ edges: Edge.Set)
        /// 8
        case smaller(_ edges: Edge.Set)
        /// 12
        case smal   (_ edges: Edge.Set)
        /// 16
        case base   (_ edges: Edge.Set)
        /// 20
        case big    (_ edges: Edge.Set)
        /// 24
        case bigger (_ edges: Edge.Set)
        /// 28
        case large  (_ edges: Edge.Set)
        ///32
        case larger (_ edges: Edge.Set)
        /// 36
        case huge   (_ edges: Edge.Set)
        /// 40
        case hugger (_ edges: Edge.Set)

        @available(*, deprecated, message: "👨‍🎨 Design System: Please use any other value!")
        case custom(edges: Edge.Set, length: CGFloat)
    }
}

extension DesignSystem.Padding {
    public var length: CGFloat {
        switch self {
        case .tiny:                     return 6
        case .smaller:                  return 8
        case .smal:                     return 12
        case .base:                     return 16
        case .big:                      return 20
        case .bigger:                   return 24
        case .large:                    return 28
        case .larger:                   return 32
        case .huge:                     return 36
        case .hugger:                   return 40

        @available(*, deprecated, message: "👨‍🎨 Design System: Please use any other value!")
        case .custom(_, let length):    return length
        }
    }

    public var edges: Edge.Set {
        switch self {
        case .tiny(let edges):          return edges
        case .smaller(let edges):       return edges
        case .smal(let edges):          return edges
        case .base(let edges):          return edges
        case .big(let edges):           return edges
        case .bigger(let edges):        return edges
        case .large(let edges):         return edges
        case .larger(let edges):        return edges
        case .huge(let edges):          return edges
        case .hugger(let edges):        return edges

        @available(*, deprecated, message: "👨‍🎨 Design System: Please use any other value!")
        case .custom(let edges, _):     return edges
        }
    }
}
