# RaceDay ERD — Part 1

This ERD is the planned relational data model for RaceDay. The SQL script in
`RaceDay\\\_Database.sql` implements these entities and relationships.

```mermaid
erDiagram
    USERS ||--o{ EVENTS : organises
    EVENTS ||--o{ EVENT\\\_CATEGORIES : offers
    CATEGORIES ||--o{ EVENT\\\_CATEGORIES : contains
    USERS ||--o{ ENROLMENTS : makes
    EVENT\\\_CATEGORIES ||--o{ ENROLMENTS : receives
    ENROLMENTS ||--o| RESULTS : has

    USERS {
        int UserId PK
        string FirstName
        string LastName
        string Email UK
        string PasswordHash
        string Role
        datetime CreatedAt
    }

    EVENTS {
        int EventId PK
        int OrganiserId FK
        string EventName
        string Description
        string EventType
        date EventDate
        time StartTime
        string Location
        datetime CreatedAt
    }

    CATEGORIES {
        int CategoryId PK
        string CategoryName UK
        string Description
    }

    EVENT\\\_CATEGORIES {
        int EventCategoryId PK
        int EventId FK
        int CategoryId FK
        decimal EntryFee
        int MaximumParticipants
    }

    ENROLMENTS {
        int EnrolmentId PK
        int ParticipantId FK
        int EventCategoryId FK
        datetime EnrolmentDate
        string Status
    }

    RESULTS {
        int ResultId PK
        int EnrolmentId FK UK
        time FinishTime
        int Position
        string ResultStatus
        datetime RecordedAt
    }
```

## Relationship decisions

* One Organiser can organise many Events; each Event has one Organiser.
* An Event can offer many Categories, and a Category can be offered by many Events.
`EventCategories` resolves this many-to-many relationship.
* One Participant can have many Enrolments; each Enrolment belongs to one Participant.
* One Event Category can have many Enrolments; each Enrolment selects one Event Category.
* An Enrolment can have zero or one Result, allowing results to be captured after an event.
* `Users.Role` separates the two required roles: `Organiser` and `Participant`.
* \## Relationship Summary
* 
* \- One organiser can create many events.
* \- One event can contain many categories.
* \- One category can belong to many events.
* \- EventCategories resolves the many-to-many relationship between Events and Categories.
* \- One participant can have many enrolments.
* \- One event-category can have many enrolments.
* \- An enrolment can have zero or one result.

\## Data Dictionary



\### Users

Stores system users and their roles.



\### Events

Stores event information created by organisers.



\### Categories

Stores the race categories available in the system.



\### EventCategories

Connects events to their available categories.



\### Enrolments

Stores participant registrations for event categories.



\### Results

Stores finishing/result information for completed enrolments.


## Design Assumptions

- Each event has one organiser.
- Participants register through enrolments.
- Categories are reusable across events through EventCategories.
- Results are associated with completed enrolments.
