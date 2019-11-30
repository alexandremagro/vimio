# Vimio

Vimio is a video-sharing platform.

## Getting Started

### Configuration

Create a `.env` file in root and set following variables:

- DATABASE_USERNAME
- DATABASE_PASSWORD

### Prerequisites

- RVM
- Ruby 2.6.5

### Installation

Install gems:

```
bundle install
```

Install local databases and run migrations:

```
rails db:create
rails db:migrate
```

## Development

### Running locally

```
rails s
```

### Running the tests

Lint code:
```
rubocop
```

Unit test:
```
rails test
```

Acceptance test:
```
rails test:system
```

## Authors

Alexandre Magro (alx.magro@gmail.com)
