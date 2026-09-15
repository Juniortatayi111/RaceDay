# RaceDay — Part 1: System Planning and Database

RaceDay is a full-stack event management system for South African road running,
walking and cycling events.

## Part 1 deliverables

The `docs` folder contains:

1. `RaceDay_ERD.md` — full ERD with six entities, keys, and cardinalities.
2. `RaceDay_API_Endpoint_Plan.md` — complete planned REST endpoint table.
3. `RaceDay_Database.sql` — SQL Server database creation and seed script.

## Required roles

- **Organiser:** create/edit/delete events, manage categories, view event enrolments,
  and capture participant results.
- **Participant:** create an account, browse events, enrol by category, view own
  enrolments, and track personal results.

## Running the SQL script

1. Open SQL Server Management Studio (SSMS).
2. Connect to the SQL Server instance supplied for the module.
3. Open `docs/RaceDay_Database.sql`.
4. Execute the complete script.
5. Confirm the verification queries return the seeded records.

The script creates a database named `RaceDay`, creates all tables and constraints,
and inserts sample data.

## ERD

The Mermaid ERD in `RaceDay_ERD.md` can be rendered to a PNG/PDF using a Mermaid
editor or recreated in draw.io/Word for the final submission if the lecturer
requires a standalone image file.

## GitHub / CI/CD

Part 1 requires a GitHub Actions workflow that validates the repository structure.
The workflow should be added to `.github/workflows/validate-part1.yml` and a
successful green run should be captured for the README before submission.

## Video

Add the student's unlisted YouTube Part 1 presentation link here:

`VIDEO_LINK_TO_BE_ADDED`

The presentation must use the student's own voice and demonstrate the planning
documents and the SQL script live, as required by the brief.

## AI disclosure

The assignment brief says AI use must be disclosed. If AI assistance was used,
replace this line with an accurate short disclosure describing what assistance
was used and what was independently reviewed/changed.
