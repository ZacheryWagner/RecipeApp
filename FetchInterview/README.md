#  Fetch Interview Project
## Zachery O Wagner

### Steps to Run the App
1. Command + R

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I really prioritized composition and architecture.  It's my personal favorite part of engineering, and most interviews of this format tend to ignore it, so I thought it was really exciting that Fetch emphasized architecture in the project requirements.  The app functionality overall is very simple, so I figured I might as well spend the additional time laying out infrastructure.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
- **TOTAL: 2ish hours**
- Session One: November 21 6:12 PM - 7:36 PM
    -  Laid out infra: all networking/endpoint/models done.
    - Setup View + View Model and Simple State Machine
    - Recipes load and display, no UI
- Session Two: November 22 1:30PM - 2:05PM 
    - Built Recipe Row (UI Done)
    - Cleanup
    - Updated Readme
- Session Three:
    - Image Caching

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
For the Networking later I chose to return data directly instead of via Combine publisher or Task.  It's a simpler approach and makes view model code cleaner, but inherently limits functionality around Task cancellation.  As for Combine, I'm interested in migrating away from it in general as AsyncSequence develops more functionality.  Overall, though there was a time I loved Combine, it's poor readability has really gotten to me over the years.

There is no advanced Dependency Injection container.  In my view, with proper routing handling, you don't really need an advanced DI framework for a long time.  Considering there is only one view, the level of DI needed didn't justify building some fancy solution for it.

### Weakest Part of the Project: What do you think is the weakest part of your project?
- There is no routing/navigation management.  I decided not to make one for this since it's a single view application.
- There is no Logger.  I would typically leverage Sentry for this to have logs tracks somewhere externally. 

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
No

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I had fun on this!  Looking forward to hearing from you.
