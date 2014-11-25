# Skoogle Docs

A library for requesting and transforming Google Docs.

## Usage

* `TODO` put onto RubyGems
* Document usage

## Contributing

* `TODO` write Contributing.md

You need a few environment variables set. Namely, you will need to set up a
Google Drive client ID and secret, or use basic auth.

We use `[dotenv](https://github.com/bkeepers/dotenv)` to load our project
environment variables as needed.

```
# .env

# for oauth (preferred)
GOOGLE_DRIVE_CLIENT_ID="my_private_key"
GOOGLE_DRIVE_CLIENT_SECRET="my_secret"

# for basic auth
GOOGLE_DRIVE_USER="your_email@gmail.com"
GOOGLE_DRIVE_password="logmein"
```

## Getting Started

* `git clone git@github.com:Skookum/skoogle-docs.git`
* `cd skoogle-docs` * [...code, code, code...]
* `dotenv rspec`

## License
 
Copyright 2014 Skookum Digital Works.
`TODO` License selection



