# RaceDay — Part 1: System Planning and Database

RaceDay is a full-stack event management system for South African road running,
walking and cycling events.

## Part 1 deliverables

The `docs` folder contains:

1. `RaceDay\_ERD.md` — full ERD with six entities, keys, and cardinalities.
2. `RaceDay\_API\_Endpoint\_Plan.md` — complete planned REST endpoint table.
3. `RaceDay\_Database.sql` — SQL Server database creation and seed script.

## Required roles

* **Organiser:** create/edit/delete events, manage categories, view event enrolments,
and capture participant results.
* **Participant:** create an account, browse events, enrol by category, view own
enrolments, and track personal results.

## Running the SQL script

1. Open SQL Server Management Studio (SSMS).
2. Connect to the SQL Server instance supplied for the module.
3. Open `docs/RaceDay\_Database.sql`.
4. Execute the complete script.
5. Confirm the verification queries return the seeded records.

The script creates a database named `RaceDay`, creates all tables and constraints,
and inserts sample data.





Part 1 includes:



\- System planning documentation

\- Entity Relationship Diagram

\- API endpoint plan

\- SQL Server database script

\- Seed data

\- GitHub Actions repository validation


## Database

The planned database uses SQL Server and contains Users, Events, Categories, EventCategories, Enrolments and Results.

## API Planning

The API plan covers authentication, user profiles, events, categories, event enrolments and results.

## Continuous Integration

GitHub Actions validates that the required Part 1 documentation and database files exist in the repository.
