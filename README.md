# GMU Course Schedule Builder & Timetable Planner

🔗 **Live Application:** [https://gmu-schedule-builder.vercel.app](https://gmu-schedule-builder.vercel.app)

A full-stack web application designed for George Mason University students to quickly build, filter, and experiment with conflict-free class schedules in real time without the complexity of Patriot Web.

---

## 🖥️ System Overview
The **GMU Schedule Planner** allows students to search, filter, add, and remove courses with a single click, instantly visualizing their weekly schedule on an interactive timetable. Students can explore multiple schedule combinations, detect overlapping time conflicts automatically, and view exact meeting times and room numbers—a vital tool for navigating the first week of classes.

### Core Features
1. **Interactive Course Planner & Multi-Criteria Filter Engine:**
   * Search courses by department/course code (e.g., `CS 310`, `IT 104`) or course title (e.g., `Data Structures`).
   * Refine results using advanced collapsible filters: **Meeting Time Range**, **Days of the Week**, **Modality** (In-Person, Online, Asynchronous), and **GMU Campus** (Fairfax, Arlington, Online).
   * Instant visual plotting on a weekly calendar timetable with automatic time-conflict alerts.
   * Dual **Timetable View** and **Tabular List View** (enabling students to track asynchronous courses, total credits, CRNs, and instructor details).
2. **Administrator Course Loader & Manager (`/admin`):**
   * Enables system administrators to load course listings from the GMU Registrar, add or remove courses, and update course attributes to keep schedule data accurate.

---

## 🛠️ Tech Stack & Layered Architecture
Originally prototyped in vanilla HTML/CSS/JavaScript, the system was refactored into a **modular layered architecture** to separate UI presentation from core business logic and enable persistent cloud storage:

* **Frontend UI Framework:** React 18, React Router
* **Business Logic & Type Safety:** TypeScript (`types.ts`, `ScheduleService.ts`)
* **Database & Persistence:** Firebase (Cloud Firestore) + LocalStorage fallback for offline resilience
* **Styling & Layout:** HTML5, CSS3
* **Build, Containerization & CI/CD:** Vite, Docker (Multi-stage Node 20 Alpine + Nginx build), Docker Compose, Vercel CI/CD

---

## 📦 Running Locally

### Option 1: Run with Docker Compose (Recommended)
```bash
docker compose up --build -d
```
The containerized Nginx production application will be available at `http://localhost:8080`.

### Option 2: Run with Node.js & Vite
```bash
npm install
npm run dev
```
The local development server will start automatically at `http://localhost:3000`.

---

## 👨‍💻 Agile Team Contributions & Design Decisions

| Team Member | Component Ownership | Key Files | Engineering Contributions |
| :--- | :--- | :--- | :--- |
| **Iliess El Kasbi** | **Enhanced Search & Filtering (60%)**, DevOps & Deployment | `Sidebar.tsx`, `FilterDropDown.tsx`, `CourseCard.tsx`, `Dockerfile`, `docker-compose.yml` | Engineered the real-time search and multi-criteria filtering logic; designed Conceptual Class, UML, Sequence, and Filter diagrams; containerized the app with Docker and deployed to Vercel CI/CD. |
| **Bradley Khong** | Architecture & Database Integration (20% across features) | `App.tsx`, `MainContent.tsx`, `Sidebar.tsx`, `CourseListView.tsx`, `ScheduleCalendar.tsx`, `CourseSchedule.tsx` | Transitioned codebase to a layered React + TypeScript architecture; integrated Firebase Firestore as primary database; implemented view-switching logic. |
| **Rayan Qadri** | Course List View (60%) | `CourseListView.tsx`, `CourseSchedule.tsx` | Implemented logic for adding and removing courses in the tabular Course List view and designed Schedule List UML diagrams. |
| **Ariel Zurita** | Weekly Timetable (60%) | `ScheduleCalendar.tsx`, `CourseSchedule.tsx` | Implemented visual timetable rendering and time-block calculation logic; created Calendar UML diagrams. |
| **Evan Reardon** | Time Conflict & Parser Logic (20% across features) | `App.tsx`, `CourseSchedule.tsx` | Assisted with filter logic, time-conflict detection, text-to-minute time parsing, and initial user course loading. |

---

## 📋 Product Discovery & Requirements Gathering

### Source 1: coursicle.com

- Product should have search bar AND large time table
  - <img width="1918" height="916" alt="image" src="https://github.com/user-attachments/assets/941df300-5072-4bbc-9c05-72ce016eff76" />

- Can search via abbreviated course department + number combination (i.e. CS 450)
  - <img width="292" height="385" alt="image" src="https://github.com/user-attachments/assets/0a164f5f-691b-4bdb-b815-d896eb079f60" />

- Can search via name directly (i.e Database Concepts)
  - <img width="302" height="392" alt="image" src="https://github.com/user-attachments/assets/283dd9ae-036e-483b-9a09-5a5311949c4f" />

- Partial searches should also work
  - <img width="296" height="712" alt="image" src="https://github.com/user-attachments/assets/47d64c07-32e6-42fd-b781-af9670b4d703" />

- Time table blocks important information, such as exact stop/start times and room number
  - <img width="282" height="186" alt="image" src="https://github.com/user-attachments/assets/daaae0e1-6d85-45c2-93a3-b5cc2590d77f" />

- Product should have additional filters that can be enabled, but hidden away so users don't get overwhelmed
  - <img width="560" height="261" alt="image" src="https://github.com/user-attachments/assets/854779ee-10c0-4f96-b462-5e9085d410d0" />
  - Filters:
    - Day of the Week
    - Meeting Times
  - **Issues with Coursicle (what our product solves):**
    - No filter for modality (in-person, online, asynchronous)
    - No filter for Campus Location
    - Time filter only works in 30-minute increments, which is inflexible considering many evening classes start at 5:55 PM or 7:10 PM
    - Linked Courses are not indicated

- Product should have that hovering over add button should preview where the class is placed, allowing you to easily see time conflicts
  - <img width="932" height="660" alt="image" src="https://github.com/user-attachments/assets/0302502c-b94e-452a-9beb-76d3ea316f6d" />

- Video Walkthrough of Coursicle: https://www.youtube.com/watch?v=wJJlD9TN6k0

### Source 2: PatriotWeb Planning Tool

- Product should have list of added classes displayed tabularly
  - <img width="952" height="582" alt="image" src="https://github.com/user-attachments/assets/9a885294-ff10-42e8-9b0b-037027e853a3" />
  - This feature (which Coursicle doesn't have) is vital as students can see:
    - Associated course title with course number
    - Planned asynchronous courses
    - Total Credits
    - Credits associated with each class
  - **Issues with tabular listing of classes in PatriotWeb:**
    - Removing course requires two clicks
    - Instructor isn't listed
