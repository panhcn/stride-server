# Application

## Purpose
This folder contains the core application code following the Model-View-Controller (MVC) architecture. As this is an API-only application, it focuses primarily on models and controllers.

## Contents
- `controllers/` - Contains controllers that handle HTTP requests and responses
  - `application_controller.rb` - Base controller class
  - `concerns/` - Shared controller modules
- `models/` - Contains data models that interact with the database
  - `application_record.rb` - Base model class
  - `concerns/` - Shared model modules
- (Additional directories will be added as the application evolves, such as):
  - `services/` - Service objects for complex business logic
  - `serializers/` - JSON serializers for API responses
  - `jobs/` - Background job classes
  - `validators/` - Custom validation classes

## Conventions
1. Follow the established naming conventions for each file type
2. Keep files focused and single-purpose
3. Use appropriate namespacing for related code
4. Maintain clear separation of concerns between directories
5. Use Sorbet type annotations for all application code

## Dependencies
- Rails framework components
- Any gems that extend application functionality

## Usage Guidelines
1. Follow the Single Responsibility Principle for all classes
2. Extract shared functionality to concerns or service objects
3. Keep controllers thin - business logic belongs in models or services
4. Document all public methods and classes using YARD/RDoc style
5. Include type information using Sorbet annotations
6. Write comprehensive tests for all application code
7. Follow the established folder-specific guidelines in each subdirectory's README
