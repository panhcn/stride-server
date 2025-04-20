# Library

## Purpose
This folder contains application-specific libraries, modules, and tasks that don't fit into the standard MVC structure but are used throughout the application.

## Contents
- `tasks/` - Custom Rake tasks for the application
- (Additional libraries will be added as the application evolves)

## Conventions
1. Code in this directory should be organized into modules and classes
2. Files should follow the `snake_case.rb` naming convention
3. Each file should have a single responsibility
4. Use namespaces to organize related functionality
5. Use Sorbet type annotations for all library code with `# typed: strict` minimum

## Dependencies
- Any gems that support the functionality in this directory

## Usage Guidelines
1. Place reusable code that doesn't belong in models, controllers, or concerns here
2. Create namespaced modules for related functionality
3. Document all public methods and classes using YARD/RDoc style
4. Include unit tests for all library code
5. Consider extracting widely used libraries to gems if appropriate
6. Use autoloading by placing code in the proper directory structure
7. Avoid direct dependencies on application models when possible
8. Include type information using Sorbet annotations

## Custom Rake Tasks
Custom Rake tasks should be placed in `lib/tasks/` with the `.rake` extension. Each task should include a description and be properly namespaced.

Example:
```ruby
namespace :data do
  desc "Import data from external source"
  task import: :environment do
    # Task implementation
  end
end
```

Run custom tasks with:
```bash
bin/rails data:import
```
