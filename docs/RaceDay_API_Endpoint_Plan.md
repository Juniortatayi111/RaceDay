# RaceDay API Endpoint Plan — Part 1

Planned for Part 2. No API code is included in Part 1.

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
|---|---|---|---|---|---|
| POST | `/api/auth/register` | Creates a participant account. | None | `{ firstName, lastName, email, password }` | 201 Created; 400 validation error; 409 email exists |
| POST | `/api/auth/login` | Authenticates a user and returns a session/token. | None | `{ email, password }` | 200 OK; 401 invalid credentials |
| GET | `/api/users/me` | Gets the logged-in user's profile. | Any | None | 200 OK; 401 unauthorised |
| PUT | `/api/users/me` | Updates the logged-in user's profile. | Any | `{ firstName, lastName, email }` | 200 OK; 400 validation; 401 unauthorised |
| GET | `/api/events` | Lists upcoming events, with optional filtering. | None | None | 200 OK; event list |
| GET | `/api/events/{id}` | Gets one event and its available categories. | None | None | 200 OK; 404 not found |
| POST | `/api/events` | Creates an event. | Organiser | `{ eventName, description, eventType, eventDate, startTime, location }` | 201 Created; 400 validation; 403 forbidden |
| PUT | `/api/events/{id}` | Edits an event owned by the organiser. | Organiser | Event fields | 200 OK; 403 forbidden; 404 not found |
| DELETE | `/api/events/{id}` | Deletes an event. | Organiser | None | 204 No Content; 403 forbidden; 404 not found |
| GET | `/api/categories` | Lists event categories. | None | None | 200 OK; category list |
| POST | `/api/categories` | Creates a category. | Organiser | `{ categoryName, description }` | 201 Created; 400 validation; 403 forbidden |
| PUT | `/api/categories/{id}` | Updates a category. | Organiser | `{ categoryName, description }` | 200 OK; 403 forbidden; 404 not found |
| DELETE | `/api/categories/{id}` | Deletes a category when it is not in use. | Organiser | None | 204 No Content; 403 forbidden; 404 not found; 409 conflict |
| GET | `/api/events/{eventId}/categories` | Lists categories offered for an event. | None | None | 200 OK; category list |
| POST | `/api/events/{eventId}/categories` | Adds a category to an event. | Organiser | `{ categoryId, entryFee, maximumParticipants }` | 201 Created; 400 validation; 403 forbidden; 404 not found |
| DELETE | `/api/events/{eventId}/categories/{categoryId}` | Removes a category from an event. | Organiser | None | 204 No Content; 403 forbidden; 404 not found; 409 conflict |
| POST | `/api/events/{eventId}/enrolments` | Enrols the logged-in participant in a selected event category. | Participant | `{ eventCategoryId }` | 201 Created; 400 validation; 404 not found; 409 already enrolled/full |
| GET | `/api/enrolments/me` | Lists the logged-in participant's enrolments. | Participant | None | 200 OK; enrolment list |
| GET | `/api/events/{eventId}/enrolments` | Views all enrolments for an event. | Organiser | None | 200 OK; enrolment list; 403 forbidden; 404 not found |
| DELETE | `/api/enrolments/{id}` | Cancels the participant's own enrolment. | Participant | None | 204 No Content; 403 forbidden; 404 not found |
| GET | `/api/results/me` | Lists the logged-in participant's results. | Participant | None | 200 OK; result list |
| POST | `/api/enrolments/{enrolmentId}/result` | Captures a participant result. | Organiser | `{ finishTime, position, resultStatus }` | 201 Created; 400 validation; 403 forbidden; 404 not found |
| PUT | `/api/results/{id}` | Corrects or updates a result. | Organiser | `{ finishTime, position, resultStatus }` | 200 OK; 403 forbidden; 404 not found |
| GET | `/api/events/{eventId}/results` | Views results for an event. | Organiser | None | 200 OK; result list; 403 forbidden; 404 not found |

## Role rules

- **Organiser:** manage events and categories, view event enrolments, and capture/update results.
- **Participant:** register/login, browse events, enrol in a category, view own enrolments, and view own results.
- Public endpoints are intentionally limited to registration, login and event/category browsing.
- Part 2 must enforce these rules at API level.
