# RaceDay ERD — Part 1

This ERD is the planned relational data model for RaceDay. The SQL script in
`RaceDay_Database.sql` implements these entities and relationships.

```mermaid
erDiagram
    USERS ||--o{ EVENTS : organises
    EVENTS ||--o{ EVENT_CATEGORIES : offers
    CATEGORIES ||--o{ EVENT_CATEGORIES : contains
    USERS ||--o{ ENROLMENTS : makes
    EVENT_CATEGORIES ||--o{ ENROLMENTS : receives
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

    EVENT_CATEGORIES {
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

- One Organiser can organise many Events; each Event has one Organiser.
- An Event can offer many Categories, and a Category can be offered by many Events.
  `EventCategories` resolves this many-to-many relationship.
- One Participant can have many Enrolments; each Enrolment belongs to one Participant.
- One Event Category can have many Enrolments; each Enrolment selects one Event Category.
- An Enrolment can have zero or one Result, allowing results to be captured after an event.
- `Users.Role` separates the two required roles: `Organiser` and `Participant`.
