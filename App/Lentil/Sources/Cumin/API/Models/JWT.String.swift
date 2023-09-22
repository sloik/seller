
import Foundation

extension String {

    var asJWT: JWT? {
        get throws {

            enum E: Error {
                case invalidJWT
            }

            let components = self.components(separatedBy: ".")

            guard components.count == 3 else { throw E.invalidJWT }

            return JWT(
                header: components[0],
                payload: components[1],
                signature: components[2]
            )
        }
    }

}
