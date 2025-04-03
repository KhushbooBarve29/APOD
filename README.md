#  # APODSwift

Astronomy Picture of the Day demo app in SwiftUI.

# About APODSwift

This article shows how to create a simple **Astronomy Picture of the Day** (APOD) app in SwiftUI.
The main features are:
- The app is optimized for iOS and iPadOS, delivering a seamless experience across devices.
- Core logic, viewModel, and views are structured for reusability.
- Fetches Astronomy Picture of the Day (APOD) via an HTTP request to NASA’s public API.
- Presents the APOD image along with detailed descriptions.
- Extracts metadata including image URL, title, explanation, and date.
- User Options – Allows users to:
     - View today's APOD image.
     - Select an APOD image from a specific date.
- Supports Dynamic Type, Dark Mode, and an adaptive SwiftUI layout.
- Ensures previously loaded images and data can be viewed offline.

# Test Scenarios 

Success Responses: Include image/video URLs, media type, and description.
- When APOD provides image.
- When APOD provides video(Date: 1/04/2025)
- When there is no data provided(24/03/2025)

Failure Response 
- Always check the status code (400, 403, 429, 500).
- Display user-friendly messages based on the error type (e.g., "Something went wrong.").

