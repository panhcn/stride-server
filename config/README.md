# Configuration

## Purpose
This folder contains all configuration files for the application, including environment-specific settings, initializers, and routing definitions.

## Contents
- `application.rb` - Main application configuration
- `boot.rb` - Bootstrap file for Rails
- `database.yml` - Database connection configuration
- `routes.rb` - Application routing definitions
- `credentials.yml.enc` - Encrypted credentials (requires master.key to decrypt)
- `environments/` - Environment-specific configurations
  - `development.rb` - Development environment settings
  - `test.rb` - Test environment settings
  - `production.rb` - Production environment settings
- `initializers/` - Files that run during application startup
- `locales/` - Internationalization files

## Conventions
1. Keep sensitive information in encrypted credentials
2. Environment-specific configuration should be in the appropriate environment file
3. Use initializers for configuring gems and application components
4. Routes should be organized logically, with comments for clarity

## Dependencies
- Rails configuration system
- Any gems that require specific configuration

## Usage Guidelines
1. When adding new configuration, consider which environment(s) it applies to
2. Document non-obvious configuration settings with comments
3. Use environment variables for values that change between deployments
4. Keep initializers focused and single-purpose
5. When adding credentials, use `rails credentials:edit` to maintain encryption
6. Avoid hardcoding values that should be configurable
7. Consider performance implications of configuration changes
