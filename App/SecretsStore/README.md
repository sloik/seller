# SecretsStore

Some packages require some sectet information that should not be a part of the the repository. Trust me as you do not want to have your creadentials commited to the repository.

# `SecretsStoreType` protocol

This protocol defines an interface for getting secret information.

# Implementation

Somehere in your codde you need to add some implementation of `SecretsStoreType`. This file should not be commited to the repository (use git ignore for this).

Thanks to this you can have your secrets in one place and not worry about them being commited to the repository.

## Example

Before adding this file please be sure that you do not commit it to the repository by acident. For eg. this repository has this file in `.gitignore` file with lines:

```
Sources/Secrets/**/*
**/_Secrets/
```

Example implementation of `SecretsStoreType` can look like this:

```swift

// Secrets.swift

struct ProductionSecretsStore: SecretsStoreType {
    func value(for key: SecretsStore.Keys.DeveloperPortal) -> String {
        switch key {
        case .clientId: "client id from developer portal"
        case .clientSecret: "client secret from developer portal"
        case .oauthRedirectUri: "redirect uri from developer portal"
        case .authenticationString: "authentication string from developer portal"
        case .callbackScheme: "callback scheme from developer portal"
    }
}

```