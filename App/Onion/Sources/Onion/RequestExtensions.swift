
import Foundation

extension Request {
    func decode(_ response: Data) throws -> Output {
        let decoder = JSONDecoder()
        return try decoder.decode(Output.self, from: response)
    }
}
