# Onion

Basic networking layer for all modules.

# `ContentType` protocol

Marker protocol for content types. Anything returned form the network layer should conform to this protocol.

# `Request<Output>` protocol

This protocol defines an interface for making requests. It's generic over the type of output that it returns.

## `Outout` associated type

This is the type of the output that the request returns. It should conform to `ContentType` protocol.

## `path` property

This is the path of the request. It should be relative to the base url of the request.

## `headerFields` property

This is the header fields of the request. It should contain all the header fields that should be sent with the request.

## `method` property

This is the method of the request.

# `APIClientType` protocol

This protocol defines an interface for making requests.

## `baseURL` property

This is the base url of the client. All requests should be relative to this url.

## `get<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse)` method

This method makes a request and returns the output of the request and the response of the request.

# `APIClient` class

Default implementation that makes actual API calls. It uses `URLSession` to make requests.

# Example

Example below shows how to get a token.

```swift

struct GetToken: Request {
    typealias Output = Token

    var path: String {
        "/auth/oauth/token?grant_type=authorization_code&code=\(code)&redirect_uri=\(redirectURI)"
    }

    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : "Basic \(encodedCredentials)"
        ]
    }

    let code: String
    let encodedCredentials: String
    let redirectURI: String
}

```

Please not that all dependecies are properties of the reaquest.

Path is relative to the base url of the client. Thanks to that you can have multiple clients for different environments.
