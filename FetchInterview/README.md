#  Fetch Interview Project
## Zachery O Wagner

### Steps to Run the App
1. Command + R

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I really prioritized composition and architecture.  It's my personal favorite part of engineering, and most interviews of this format tend to ignore it, so I thought it was really exciting that Fetch emphasized architecture in the project requirements.  The app functionality overall is very simple, so I figured I would spend most of the time laying out infrastructure.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
- **TOTAL: 6ish hours**
- Session One: 1 Hour
    - Networking/Endpoints/Models Done
    - Setup View + View Model and State Machine
    - Recipes Load and Display with Temp UI
- Session Two: 0.5 Hours
    - Built Recipe Row (Finished UI)
    - Cleanup
- Session Three: 2.5 Hours
    - Image Caching Infra, added caching
    - Logging Infra, added logs
- Session Four: 2 Hours
    - Cache Improvements
    - Testing
    - Final Touches

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
For the Networking layer I chose to return data directly instead of via Combine publisher or Task.  It's a simpler approach and makes view model code cleaner, but inherently limits functionality around Task cancellation.  As for Combine, I'm interested in migrating away from it in general as AsyncSequence develops more functionality.  Overall, though there was a time I loved Combine, it's poor readability has really gotten to me over the years.

For the Caching layer there were a few things.  For one, in production I usually wouldn't solely rely on Disk Caching and would leverage a two tier caching system with NSCache.  This would be much more performant but I wanted to align with the project requests of "Disk Caching".  Next I optimized for performance over simplicity.  What I mean by this is I started with an Actor, and then after hitting some performance issues, refactored to have more manual control of the concurrency.  I did this with GDC but used Async checkedContinuations to make the cache easy to use from an asynchronous context.  Lastly, I prioritized safety and eliminated race conditions through using a queue.

There is no advanced Dependency Injection container/manager.  In my view, with proper routing handling, you don't really need an advanced DI framework for a long time.  Considering there is only one view, the level of DI needed didn't justify building some fancy solution for it.

### Weakest Part of the Project: What do you think is the weakest part of your project?
- There is no routing/navigation management.  I decided not to make one for this since it's a single view application.
- The Cacheing layer could be improved with some more advanced two tier system.
- More testing around networking is needed.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
No

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I had fun on this!  Looking forward to hearing from you.
