
import Foundation

extension Request {

    func decode(
        _ response: Data,
        using decoder: JSONDecoder = .init()
    ) throws -> Output {
        try decoder.decode(Output.self, from: response)
    }
}
