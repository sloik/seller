
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

/// Json Web Token
struct JWT {
    let header: Header
    let payload: Payload
    let signature: Signature
}

extension JWT {

    /// Creates `JWT` from raw strings.
    init?(
        header: String,
        payload: String,
        signature: String
    ) {
        guard
            let (header, payload, signature) = zip(
                Header(string: header),
                Payload(string: payload),
                Signature(signature: signature)
            )
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
        // Can not verify signature, probably because of issue: https://github.com/allegro/allegro-api/issues/686
        // Seems like allegro is using public key that they don't share publicly
        let signature: String
    }
}


