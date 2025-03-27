# Intuitive Code Challenge

This project involves data scraping, database setup, and running a frontend application. Follow the steps below to set up and run the project.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Setup Instructions](#setup-instructions)
   - [1. Configure Environment Variables](#1-configure-environment-variables)
   - [2. Run the Scraping Scripts](#2-run-the-scraping-scripts)
   - [3. Set Up the Database](#3-set-up-the-database)
   - [4. Start the API](#4-start-the-api)
3. [Frontend Setup](#frontend-setup)
   - [1. Install Dependencies](#1-install-dependencies)
   - [2. Start the Development Server](#2-start-the-development-server)
4. [Notes](#notes)

---

## Prerequisites

1. **Python Environment**: Ensure you have Python 3.8+ installed and create a virtual environment.
2. **Node.js**: Install Node.js (v14 or later) and npm for the frontend application.
3. **Database**: Set up a MySQL or MariaDB database and ensure it is running.

---

## Setup Instructions

### 1. Configure Environment Variables

Create a `.env` file in the root directory with the following variables:

```
DB_USER=<your_database_user>
DB_PASSWORD=<your_database_password>
DB_HOST=<your_database_host>
DB_PORT=<your_database_port>
DB_NAME=<your_database_name>
```

Replace the placeholders (`<...>`) with your actual database credentials.

### 2. Run the Scraping Scripts

Execute the scraping scripts to gather and prepare the data:

```bash
python run_scraping_scripts.py
```

> **Note:** Ensure that the required dependencies are installed in your Python environment before running the script.

### 3. Set Up the Database

Manually execute the `scripts.sql` file in your database client to create tables and load initial data:

```bash
mysql -u <your_database_user> -p <your_database_name> < scripts.sql
```

Replace `<your_database_user>` and `<your_database_name>` with your database credentials.

> **Note:** This process may take some time. Please wait until it completes.

### 4. Start the API

Run the API server to expose the backend endpoints:

```bash
python api.py
```

> **Tip:** The API will be available at `http://localhost:5000` by default.

---

## Frontend Setup

### 1. Install Dependencies

Navigate to the `operadoras_app` directory and install the required dependencies:

```bash
cd operadoras_app
npm install
```

### 2. Start the Development Server

Run the development server to start the frontend application:

```bash
npm run dev
```

The application will be available at `http://localhost:3000` by default.

---

## Notes

- Ensure the database server allows `LOCAL INFILE` if using the `LOAD DATA LOCAL INFILE` command. If not, you may need to enable it or use an alternative method for data loading.
- Check the logs for any missing files or errors during execution.
- For additional details, refer to the comments in the respective scripts.
- If you encounter issues, ensure all dependencies are installed and the database is properly configured.