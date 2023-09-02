# Seller

# Modules

```
┌─────────────────────────────┐
│        Hosting Apps         │
│                             │
│    iOS, macOS, CLI etc.     │
└─────────────────────────────┘
          ┌───────────────────┐
          │      Seller       │
          │                   │
          │  Use cases etc.   │
          └───────────────────┘
┌─────────────────────────────┐
│           Lentil            │
│                             │
│     Login functionality     │
│                             │
│          ┌─────────────────┐│
│          │      Yuca       ││
│          │                 ││
│          │UI only part for ││
│          │     login.      ││
│          └─────────────────┘│
│┌───────────────────────────┐│
││           Cumin           ││
││                           ││
││  Domain / NO UI part of   ││
││          login.           ││
│└───────────────────────────┘│
└─────────────────────────────┘
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