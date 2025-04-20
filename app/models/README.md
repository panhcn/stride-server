# Models

## Purpose
This folder contains all the application's data models that interact with the database and implement business logic related to data entities.

## Contents
- `application_record.rb` - Base class for all models in the application
- `concerns/` - Contains shared modules that can be included in multiple models

## Conventions
1. Model files should follow the `snake_case.rb` naming convention
2. Each model should correspond to a single database table
3. Models should include appropriate validations, associations, and scopes
4. Complex business logic should be extracted to service objects
5. Use Sorbet type annotations for all models with `# typed: strict` minimum

## Dependencies
- ActiveRecord for ORM functionality
- Any gems that extend model functionality should be documented here

## Usage Guidelines
1. Keep models focused on data representation and basic business rules
2. Extract complex queries to scopes for reusability
3. Use concerns for shared functionality across models
4. Document all public methods and attributes using YARD/RDoc style
5. Include type information using Sorbet annotations
