# Stride Server

This is the API server for Stride, providing backend services and data management for the Stride application.

## Technology Stack

* Ruby 3.x
* Rails 8.0 (API-only mode)
* PostgreSQL database

## Development Setup

### Prerequisites

* Ruby 3.x
* PostgreSQL
* Bundler

### Installation

1. Clone the repository
   ```bash
   git clone [repository-url]
   cd stride-server
   ```

2. Install dependencies
   ```bash
   bundle install
   ```

3. Setup database
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   bin/rails db:seed  # if you want sample data
   ```

4. Start the server
   ```bash
   bin/rails server
   ```

## Testing

Run the test suite with:
```bash
bin/rails test
```

For more detailed testing information, see the [test/README.md](test/README.md).

## Project Structure

The application follows standard Rails conventions with some specific organization rules:

* `app/` - Application code (models, controllers)
* `config/` - Configuration files
* `db/` - Database migrations and schema
* `lib/` - Library code and custom tasks
* `test/` - Test files

Each major folder contains a README.md with specific guidelines.

## Code Guidelines

This project follows the guidelines specified in the `.augment-guideline` file, which includes:

* Code organization and naming conventions
* Documentation standards
* Testing requirements
* Pull request process
* Type safety with Sorbet
* Development workflow

Please review this file before contributing to the project.

## API Documentation

*API documentation will be added as endpoints are developed.*

## Deployment

*Deployment instructions will be added as the project matures.*

## Contributing

1. Follow the six-phase development workflow outlined in the guidelines
2. Create focused, single-purpose pull requests
3. Include comprehensive tests for all new functionality
4. Ensure proper documentation
5. Maintain type safety with Sorbet
