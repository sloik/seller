# Seller

This project is a multipatform (iOS, iPadOS, macOS) app for sellers to manage their offers and messages on [allegro](https://allegro.pl) platform.

# Overall Architecture Diagram

```
╔═══════════════════════════╗
║   Cross cutting modules   ║
╚═══════════════════════════╝

┌────────────┐┌─────────────┐   ┌────────────────────────────────┐
│  [Onion]   ││ [Utilities] │   │         [Alle Seller]          │
│            ││             │   │                                │
│   Common   ││ Common junk │   │    iOS, macOS hosting app.     │
│ Networking ││ module for  │   └────────────────────────────────┘
│   Layer    ││ functionali │   ┌────────────────────────────────┐
│            ││   ty that   │   │            [Seller]            │
│            ││  does not   │   │                                │
│            ││  have its   │   │     Module integrating all     │
│            ││   place.    │   └────────────────────────────────┘
│            ││             │   ┌───────────────┐┌───────────────┐
│            ││             │   │   [Lettuce]   ││   [Tomatos]   │
│            ││             │   │               ││               │
│            ││             │   │   Messages    ││Offers module. │
│            ││             │   │    module.    ││               │
│            ││             │   └───────────────┘└───────────────┘
│            ││             │   ┌────────────────────────────────┐
│            ││             │   │            [Lentil]            │
│            ││             │   │                                │
│            ││             │   │      Login functionality       │
│            ││             │   │      ┌─────────────┐           │
│            ││             │   │      │   [Yuca]    │           │
│            ││             │   │      │             │           │
│            ││             │   │      │  UI part.   │           │
│            ││             │   │      └─────────────┘           │
│            ││             │   │┌───────────────────┐           │
│            ││             │   ││      [Cumin]      │           │
│            ││             │   ││                   │           │
│            ││             │   ││Core functionality.│           │
│            ││             │   │└───────────────────┘           │
│            ││             │   └────────────────────────────────┘
│            ││             │   ┌────────────────────────────────┐
│            ││             │   │       [Keychain Wrapper]       │
│            ││             │   │                                │
│            ││             │   │ Internal Keychain Abstraction  │
└────────────┘└─────────────┘   └────────────────────────────────┘
```

# Modules

Each module has it's own README.md file. Please refer to them for more information. Here is a short description of each module.

Header titles are links so just tap them to read more.

## [Alle Seller](App/AlleSeller/README.md)

This is the hosting app for the Alle Seller project. It's main purpose is to host the main app (Seller).

## [Keychain Wrapper](App/KeychainWrapper/README.md)

Internal Keychain Abstraction

## [Lentil](App/Lentil/README.md)

Login functionality.

## [Lettuce](App/Lettuce/README.md)

Messages module.

## [Onion](App/Onion/README.md)

Basic networking layer for all modules.

## [Seller](App/Seller/README.md)

Module integrating all other modules.

## [Tomatos](App/Tomatos/README.md)

Offers module.

## [Utilities](App/Utilities/README.md)

Common junk module for functionality that does not have its place.

## [Secrets Store](App/SecretsStore/README.md)

Defines secrets that the app needs to function.


