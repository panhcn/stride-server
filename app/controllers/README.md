# Controllers

## Purpose
This folder contains all the application's controllers that handle HTTP requests, process input parameters, interact with models, and return appropriate responses. As this is an API-only application, controllers focus on JSON responses rather than view rendering.

## Contents
- `application_controller.rb` - Base controller class that all other controllers inherit from
- `concerns/` - Contains shared modules that can be included in multiple controllers

## Conventions
1. Controller files should follow the `snake_case_controller.rb` naming convention
2. RESTful actions should be preferred (index, show, create, update, destroy)
3. Controllers should be organized by resource or domain
4. API versioning should be handled through namespacing (e.g., `Api::V1::ResourceController`)
5. Use Sorbet type annotations for all controllers with `# typed: strict` minimum

## Dependencies
- ActionController for request handling
- Any authentication/authorization libraries used

## Usage Guidelines
1. Keep controllers thin - business logic should be in models or service objects
2. Use strong parameters for input validation
3. Return appropriate HTTP status codes
4. Document expected request formats and response structures
5. Include error handling for expected failure cases
6. Use concerns for shared controller functionality
7. Document all public methods using YARD/RDoc style
8. Include comprehensive integration tests for all endpoints
