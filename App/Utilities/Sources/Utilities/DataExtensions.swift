
import Foundation
import OSLog

private let logger = Logger(subsystem: "Utilities", category: "Data")

public extension Data {

    enum E: Error {
        case unableToConvertToDictionary
    }


    /// Converts data to a dictionary or throws and error.
    var toDictionary: [String:Any] {
        get throws {
            logger.info("Converting data to dictionary")

            do {
                guard
                    let object = try JSONSerialization.jsonObject(with: self, options: []) as? [String:Any]
                else {
                    throw E.unableToConvertToDictionary
                }

                return object
            } catch {
                logger.error("Failed to convert data to dictionary with error: \(error.localizedDescription)")
                throw error
            }
        }
    }
}
