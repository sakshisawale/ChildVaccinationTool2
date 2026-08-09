# 👶 Child Vaccination Tool

A full Java web application (Servlets + JSP + JDBC + PostgreSQL) to help
parents and admins track and manage child vaccination schedules.

---

## 1. Modules included

**Admin**
- Admin login (secure, session-based)
- Add / View / Delete vaccines
- Update vaccine price
- View upcoming vaccines (next 30 days) across **all** children
- Change password

**User (Parent)**
- Register / Login
- Add child record (name, DOB, gender)
- View my children
- View upcoming vaccines (auto-calculated from child's DOB + vaccine schedule)
- Add vaccine log (mark a vaccine as given, with date + notes)
- View vaccine log / history
- Change password

All passwords are stored as **BCrypt hashes** — never plain text.
All forms are validated **both** in the browser (JS) and again on the
server (Servlets) — the server check is the one that actually matters,
the JS one is just for a nicer experience.

---

## 2. Tech stack

| Layer      | Technology                          |
|------------|--------------------------------------|
| Backend    | Java 17, Servlets 4.0, JDBC          |
| Frontend   | JSP, JSTL, HTML/CSS, vanilla JS      |
| Database   | PostgreSQL 15                        |
| Build tool | Maven                                |
| Server     | Apache Tomcat 9                      |

---

## 3. Project structure

```
ChildVaccinationTool/
├── pom.xml                     Maven config (dependencies + build)
├── Dockerfile                  Used for Render/Railway deployment
├── database/schema.sql         Run this once to create tables + seed vaccines
└── src/main/
    ├── java/com/cvt/
    │   ├── model/               Plain Java objects (Admin, User, Child, Vaccine, VaccineLog...)
    │   ├── dao/                 All database queries live here (PreparedStatements only)
    │   ├── util/                DBConnection, PasswordUtil (BCrypt), ValidationUtil
    │   ├── filter/               AdminAuthFilter, UserAuthFilter, AppInitListener
    │   └── servlet/              All request handlers (login, CRUD, etc.)
    └── webapp/
        ├── WEB-INF/web.xml
        ├── css/style.css
        ├── js/validate.js
        ├── index.jsp, admin-login.jsp, user-login.jsp, user-register.jsp
        ├── admin/*.jsp
        └── user/*.jsp
```

---

## Security note

This README intentionally does **not** contain real admin passwords or
database credentials. Before publishing the project, make sure there are no
hardcoded secrets in Java source files, SQL seed files, `.env` files, or
configuration files. Use environment variables or a secret manager for
production credentials.

## 4. Database setup — kahan aur kaise store hota hai

The app uses **PostgreSQL**. Nothing is stored in files — every record
(admins, users, children, vaccines, vaccine logs) lives in Postgres
tables, accessed only through JDBC `PreparedStatement`s (so it's
protected against SQL injection).

### Step-by-step (local Postgres, for VS Code):

1. Install PostgreSQL (if not already) — https://www.postgresql.org/download/
2. Create the database (Postgres doesn't create it from inside the
   script the way MySQL does):
   ```
   createdb child_vaccination_db
   ```
   (or via pgAdmin: right-click "Databases" → Create → Database →
   name it `child_vaccination_db`)
3. Run the schema file to create the 5 tables (`admin`, `users`,
   `vaccines`, `children`, `vaccine_log`) and seed 14 standard vaccines:
   ```
   psql -U postgres -d child_vaccination_db -f database/schema.sql
   ```
4. That's it — you do **not** need to manually insert an admin row.
   The app creates a default admin automatically the first time it starts
   (see `AppInitListener.java`):
   - **username:** `admin`
   - **password:** **not documented in this README**
   (change it immediately after first login, using "Change Password"). Do not publish the password in the repository.

### How the app finds your database

`DBConnection.java` supports two ways to configure the connection —
whichever is set is used:

**Option A — a single `DATABASE_URL`** (this is the format Render gives
you for its managed Postgres, e.g. its "External Database URL"):
```
postgres://user:password@host:5432/dbname
```
Just set one environment variable, `DATABASE_URL`, to that exact string
and everything else is parsed out of it automatically (SSL is enabled
automatically too, since Render requires it).

**Option B — individual variables** (handy for local dev, used only if
`DATABASE_URL` is not set). If you don't set them, these defaults are
used, so local dev works with zero configuration as long as Postgres is
running on `localhost:5432` with user `postgres` and no password:

| Variable      | Default                  |
|---------------|---------------------------|
| `DB_HOST`     | `localhost`               |
| `DB_PORT`     | `5432`                    |
| `DB_NAME`     | `child_vaccination_db`    |
| `DB_USER`     | `postgres`                |
| `DB_PASSWORD` | *(empty)*                 |

If your local Postgres has a different username/password, set these as
environment variables before running, or edit the defaults directly in
`DBConnection.java`.

---

## 5. Running the project in VS Code

1. **Install extensions** (VS Code → Extensions panel):
   - `Extension Pack for Java` (by Microsoft)
   - `Community Server Connectors` (adds Tomcat support) — or install
     `Tomcat for Java` extension instead, either works.
   - `Maven for Java` (usually bundled with the Java extension pack)

2. **Install Apache Tomcat 9** on your machine:
   https://tomcat.apache.org/download-90.cgi — unzip it anywhere, e.g.
   `C:\tomcat9` or `~/tomcat9`.

3. **Open the `ChildVaccinationTool` folder** in VS Code (File → Open Folder).

4. **Register the Tomcat server** in VS Code:
   - Open the "Servers" panel in the sidebar (added by the Tomcat/Community
     Server Connectors extension)
   - Click `+` → choose Tomcat → point it to the folder where you unzipped Tomcat

5. **Build the project** (VS Code terminal, inside the project folder):
   ```
   mvn clean package
   ```
   This produces `target/ChildVaccinationTool.war`.

6. **Deploy & run**:
   - Right-click your Tomcat server in the Servers panel → "Add Deployment"
     → select `target/ChildVaccinationTool.war`
   - Start the server (▶ icon)
   - Open your browser at: **http://localhost:8080/**

7. Login as admin (`admin` / **private password configured for the environment**) or register a new parent account.

> If you'd rather not install the VS Code Tomcat extension, you can also
> just copy `target/ChildVaccinationTool.war` into Tomcat's own
> `webapps/` folder (rename it to `ROOT.war` to serve it at `/`) and run
> `bin/startup.sh` (or `startup.bat` on Windows) from the Tomcat folder directly.

---

## 6. Deploying to Render (since Vercel can't run Java)

Vercel only supports static sites / Node / Python / Go serverless
functions — it **cannot** run a Java Servlet/Tomcat app. The
`Dockerfile` included here lets you deploy the exact same app to
**Render**, which also happens to offer managed PostgreSQL natively —
so your whole app + database can live on one platform.

### 6a. Create a PostgreSQL database on Render
1. Render dashboard → **New +** → **PostgreSQL**
2. Give it a name, pick the free plan, create it.
3. Once it's ready, open it → copy the **"External Database URL"**
   shown there (looks like `postgres://user:password@host:5432/dbname`).

### 6b. Load the schema into it
From your machine (you need the `psql` client installed, or use a GUI
tool like TablePlus/DBeaver/pgAdmin with the same connection details):
```
psql "<paste the External Database URL here>" -f database/schema.sql
```
This creates the 5 tables and seeds the 14 standard vaccines.

### 6c. Deploy the app
1. Push this project to a GitHub repository (if not done already):
   ```
   git init
   git add .
   git commit -m "Child Vaccination Tool"
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git branch -M main
   git push -u origin main
   ```
2. Render dashboard → **New +** → **Web Service** → connect your repo.
   Render detects the `Dockerfile` automatically → choose **Docker** as
   the environment.
3. Under **Environment**, add one variable:
   - `DATABASE_URL` = the same External Database URL from step 6a
4. Deploy. Watch the **Logs** tab until it's live, then open the public
   URL Render gives you.

The **first request** to the live app triggers `AppInitListener`, which
creates the default admin account (`admin` / **private password configured for the environment**) in your Render
Postgres database automatically, exactly like it does locally. Log in
and change that password right away.

---

## 7. Default login (change immediately after first login)

| Role  | Username / Email     | Password    |
|-------|------------------------|-------------|
| Admin | `admin`                 | Admin@123 |  //for testing
| User  | *(register your own)*  | —           |

---

## 8. Validation summary

- **Email:** standard format check
- **Phone:** 10-digit Indian mobile number
- **Password:** min 8 characters, at least 1 letter + 1 number
- **Child DOB:** cannot be in the future, cannot be older than 18 years
- **Vaccine date given:** cannot be in the future
- **Duplicate vaccine log:** a vaccine can only be logged once per child
- **Ownership checks:** a parent can only ever view/log vaccines for
  their *own* children (enforced server-side, not just hidden in the UI)
- Admin-only and User-only areas (`/admin/*`, `/user/*`) are protected
  by servlet filters — direct URL access without login redirects to the
  login page.

---

## 9. Troubleshooting

- **"Connection refused" / can't connect to DB** → Postgres isn't
  running locally, or `DATABASE_URL` / `DB_HOST` / `DB_PORT` /
  `DB_PASSWORD` are wrong. On Render, double-check you copied the
  **External** Database URL (not Internal) if connecting from outside
  Render, and that SSL isn't being blocked.
- **404 on every page** → make sure the WAR deployed as `ROOT.war` (so
  it serves at `/` instead of `/ChildVaccinationTool`), or adjust the
  context path you're browsing to accordingly.
- **Admin login fails with correct password** → check the server logs
  for the "Default admin created" message; if your DB already had an
  `admin` row from an older run with a different password, either
  delete that row and restart the app, or use that old password.
