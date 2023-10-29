# Lentil

This package contains two other packqges: `Yuca` and `Cumin`. It's purpouse is to provide a login functionality to Allegro platform.

## Yuca

This package serves as a contrianer for UI related to login. It has defined views that should be presented to the user for allowing them to connect with allegro account.

`Yuca` uses under the hood `Cumin` package to communicate with Allegro API and geting user `Token`.

## Cumin

This package contains logig logic requried for communitacting with Allegro API and getting user `Token`. Think of it as whole functionaliy without UI. That way one could create their own UI.
