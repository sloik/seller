# Seller

# Modules

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
│            ││             │   │                                │
└────────────┘└─────────────┘   └────────────────────────────────┘
```

## Hosting Apps (AlleSeller)

Hosting apps for the seller project.

## Seller

All the app logic and use cases.

## Lentil

User login module. Handeles networking and UI.

### Yuca

UI part and zero logic.

### Cumin

Logic, models and networking related to user login.