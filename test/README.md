# Tests

## Purpose
This folder contains all test files for the application, organized by test type. The application uses the default Rails testing framework.

## Contents
- `controllers/` - Controller tests
- `models/` - Model tests
- `integration/` - Integration tests
- `fixtures/` - Test data fixtures
  - `files/` - File fixtures for testing file uploads/processing

## Conventions
1. Test files should follow the `snake_case_test.rb` naming convention
2. Tests should be organized to mirror the application structure
3. Use fixtures or factories for test data
4. Follow the Arrange-Act-Assert pattern for test structure
5. Use descriptive test method names that explain the behavior being tested
6. Use Sorbet type annotations for test code with `# typed: true` minimum

## Dependencies
- Rails default testing framework
- Any additional testing gems

## Usage Guidelines
1. Write tests for all new functionality
2. Maintain high test coverage (minimum 95%)
3. Test both success and failure scenarios
4. Mock external services in tests
5. Keep tests focused and isolated
6. Use meaningful test descriptions
7. Clean up test data after each run
8. Avoid test interdependence

## Running Tests
```bash
# Run all tests
bin/rails test

# Run specific test file
bin/rails test test/models/user_test.rb

# Run specific test by line number
bin/rails test test/models/user_test.rb:42

# Run tests with specific name pattern
bin/rails test -n /create/

# Run tests with verbose output
bin/rails test -v
```

## Test Categories to Include
1. Data Validation
2. Business Logic
3. Error Handling
4. Edge Cases
5. Authorization
6. Authentication
7. API Contracts
8. Database Operations
