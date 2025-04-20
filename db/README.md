# Database

## Purpose
This folder contains database-related files including migrations, schema definition, and seed data for initializing the database.

## Contents
- `seeds.rb` - Seed data for populating the database
- `schema.rb` - Current database schema (auto-generated)
- `migrations/` - Database migration files (will be created as the application evolves)

## Conventions
1. Migration files should follow Rails naming conventions: `YYYYMMDDHHMMSS_descriptive_name.rb`
2. Migrations should be reversible when possible (include `up` and `down` methods or use `change`)
3. Use appropriate column types and constraints
4. Add indexes for columns used in lookups or joins
5. Include foreign key constraints where appropriate

## Dependencies
- ActiveRecord for database interactions
- Any database-specific gems

## Usage Guidelines
1. Create migrations using `rails generate migration MigrationName`
2. Test migrations in development before applying to production
3. Keep migrations focused on a single responsibility
4. Document complex migrations with comments
5. Use seed data for essential application data, not test data
6. Consider data integrity and performance when designing schema changes
7. For large data migrations, consider using background jobs or batching
8. Always provide a rollback strategy for migrations

## Database Operations
```bash
# Create database
bin/rails db:create

# Run migrations
bin/rails db:migrate

# Rollback last migration
bin/rails db:rollback

# Seed the database
bin/rails db:seed

# Reset database (drop, create, migrate, seed)
bin/rails db:reset

# Prepare test database
bin/rails db:test:prepare
```
