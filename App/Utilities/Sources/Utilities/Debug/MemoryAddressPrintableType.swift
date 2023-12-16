
import Foundation

public protocol MemoryAddressPrintableType: AnyObject {

    #if DEBUG
    var memoryAddress: String { get }
    #endif
}

#if DEBUG
extension MemoryAddressPrintableType {
    public var memoryAddress: String {
        String(describing: Unmanaged.passUnretained(self).toOpaque())
    }
}
#endif
