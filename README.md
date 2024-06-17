# Moseeqify: Music Streaming Service

Moseeqify is a music streaming application developed to showcase the principles of database design and management using a three-tier architecture. The project involves the development of a relational database in Microsoft SQL Server, a backend API using Flask, and a React.js frontend to provide a comprehensive full-stack solution with CRUD operations.

This project is created for the 4th semester Database Systems course at Lahore Garrison University.

# Complete Documentation: 
[Moseeqify docs.docx.pdf](https://github.com/user-attachments/files/15872102/Moseeqify.docs.docx.pdf)


## Table of Contents
- [Introduction](#introduction)
- [Screenshots](#screenshots)
- [Architecture](#architecture)
- [Technologies Used](#technologies-used)
- [Database Design](#database-design)
- [Backend API](#backend-api)
- [Frontend Design](#frontend-design)
- [Setup and Installation](#setup-and-installation)
- [Usage](#usage)
- [Contributors](#contributors)


## Introduction
Moseeqify allows users to access a library of songs, create personalized playlists, and enjoy an amazing user interface. The focus is on the database and backend development to ensure a scalable foundation for the application.

## Screenshots:
![2024-06-10 (1)](https://github.com/Musxeto/Moseeqify/assets/138971833/2aa84ca7-ecd0-4ff0-9906-d431ce856ad4)
![2024-06-10 (2)](https://github.com/Musxeto/Moseeqify/assets/138971833/e486fdd7-29e4-4043-abeb-69615c2eae5b)
![2024-06-10 (3)](https://github.com/Musxeto/Moseeqify/assets/138971833/b797534e-3fad-4df2-b110-bb7d42bb6df4)


## Architecture
Moseeqify uses a three-tier architecture for modularity and scalability:

- **Data Layer (Database):** Microsoft SQL Server stores all application data using a well-defined schema.
- **Business Logic Layer (Backend API):** Flask handles user requests and interactions, connecting to the database.
- **Presentation Layer (React JS Frontend):** Provides a user-friendly interface for browsing music, managing playlists, and controlling music playback.

## Technologies Used
**Database:**
- Microsoft SQL Server: For storing and managing all application data.

**Backend:**
- Flask: Micro web framework for Python for the backend API.
- SQLAlchemy: ORM for interacting with the database.
- Flask-Login: Library for user session management.
- Flask-CORS: Library for Cross Origin Resource Sharing.

**Frontend:**
- React JS: JavaScript frontend library for building user interfaces.

**Development Tools:**
- Git/GitHub: Version control system for team collaboration.

## Database Design
The database uses relational tables to store and manage music data, user information, and their interactions with the application. Key tables include:

- User Table
- Artist Table
- Genre Table
- Album Table
- Song Table
- Playlist Table
- UserListeningHistory Table
- user_follows_artists Table
![erd](https://github.com/Musxeto/Moseeqify/assets/138971833/c683e37d-b149-4c31-b74d-db692304dbaf)


**Constraints and Data Integrity:**
- Primary Key Constraints
- Foreign Key Constraints
- Not Null Constraints
- Unique Constraints
- Check Constraints

**Stored Procedures:**
CRUD operations are managed using stored procedures, ensuring efficient data management.

## Backend API
The backend API is built using Flask and includes various routes for managing users, playlists, songs, and more. Key API routes include:

- **User Registration:** `/register` - POST
- **User Login:** `/login` - POST
- **User Logout:** `/logout` - GET
- **Create Playlist:** `/playlists` - POST
- **Add Song to Playlist:** `/playlists/<playlist_id>/add-song/<song_id>` - POST
- **Get Specific Album:** `/albums/<album_id>/` - GET
- **Get All Songs:** `/songs` - GET
- **Get All Albums:** `/albums` - GET
- **Manage Playlists:** `/playlists` - GET
- **Search Songs:** `/search` - POST
- **Follow Artist:** `/follow-artist/<artist_id>` - POST
- **Unfollow Artist:** `/unfollow-artist/<artist_id>` - POST
- **Fetch User Listening History:** `/users/<username>/listening-history` - GET

## Frontend Design
The frontend, built with React JS, includes various components such as:

- **Login/Signup:** User authentication forms.
- **Home:** Displays welcome message and user listening history.
- **Album:** Detailed information about albums.
- **Song:** Details about songs and audio controls.
- **Playlist:** Create and manage playlists.
- **Search:** Search functionality for songs.
- **Player:** Music player component.
- **Navigation Bar:** Links to different sections of the application.

## Setup and Installation
### Prerequisites
- Python 3.x
- Node.js
- Microsoft SQL Server

### Backend Setup
1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/moseeqify.git
    cd moseeqify/backend
    ```
2. Create a virtual environment and activate it:
    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```
3. Install the dependencies:
    ```bash
    pip install -r requirements.txt
    ```
4. Run the Flask server:
    ```bash
    flask run
    ```

### Frontend Setup
1. Navigate to the frontend directory:
    ```bash
    cd ../frontend
    ```
2. Install the dependencies:
    ```bash
    npm install
    ```
3. Run the React development server:
    ```bash
    npm start
    ```

## Usage
1. Open your browser and navigate to `http://localhost:3000`.
2. Register a new user or log in with existing credentials.
3. Explore the music library, create playlists, and enjoy streaming music.

## Contributors
- Ghulam Mustafa Fa-2022/BSCS/188
- Ammad Rasheed Fa-2022/BSCS/199
- Faizan Ali Fa-2022/BSCS/187
- Ahsan Ilahi Fa-2022/BSCS/210

## Note:
This is a 4th semester Project developed for the Database Systems Course.
