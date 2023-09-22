
// system
import Foundation
import OSLog

// local
import Utilities

// 3rd party
import AliasWonderland
import OptionalAPI
import SweetURL
import Zippy

struct JWT {
    let header: Header
    let payload: Payload
    let signature: Signature
}

extension JWT {

    init?(
        header: String,
        payload: String,
        signature: String
    ) {
        guard
            let (header, payload, signature) = zip( Header(string: header), Payload(string: payload), Signature() )
        else {
            return nil
        }

        self.header = header
        self.payload = payload
        self.signature = signature
    }
}

extension JWT {
    struct Header {
        let dictionary: [String:Any]

        init?(string: String) {
            guard
                let data = string.base64UrlDecode,
                let dictionary = try? data.toDictionary
            else {
                return nil
            }

            self.dictionary = dictionary
        }
    }
}

extension JWT {
    struct Payload {
        let dictionary: [String:Any]

        init?(string: String) {
            guard
                let data = string.base64UrlDecode,
                let dictionary = try? data.toDictionary
            else {
                return nil
            }

            self.dictionary = dictionary
        }
    }
}

extension JWT {
    struct Signature {

    }
}


