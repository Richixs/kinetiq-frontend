# Kinetiq Frontend

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE.md)
![Status](https://img.shields.io/badge/status-in%20development-blue)
![Vue 3](https://img.shields.io/badge/Vue-3.x-42b883)
[![Backend API](https://img.shields.io/badge/API-FastAPI-009688)](https://github.com/Richixs/kinetiq-backend)

Frontend for an interactive kinematics simulator built with Vue.js. The project allows users to visualize physics simulations and consume data from a FastAPI backend API.

This repository is part of an academic project for the General Physics course in the Computer Science program at Universidad Mayor de San Simon (UMSS), Bolivia.

## Table of contents

- [Quick start (full stack)](#quick-start-full-stack)
- [Deployments](#deployments)
- [Installation](#installation)
- [Usage](#usage)
- [Project structure](#project-structure)
- [Available scripts](#available-scripts)
- [Contributing](#contributing)
- [License](#license)

## Quick start (full stack)

The frontend needs the backend API running to render simulations. Open two terminals:

**Terminal 1 — Backend** (see [kinetiq-backend](https://github.com/Richixs/kinetiq-backend) for full setup):

```bash
cd kinetiq-backend
uv sync
uv run uvicorn app.main:app --reload
```

**Terminal 2 — Frontend:**

```bash
cd kinetiq-frontend
npm install
npm run dev
```

Open `http://localhost:5173`, configure moviles and parameters, click **Simular**, and wait ~15 seconds for the Manim-rendered animation.

## Deployments

- Development: [https://develop.kinetiq.scesi.dev](https://develop.kinetiq.scesi.dev)
- Production: [https://kinetiq.scesi.dev](https://kinetiq.scesi.dev)

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/your-org/kinetiq-frontend.git
cd kinetiq-frontend
```

### 2. Verify Node.js version

Use a version compatible with the engines field in `package.json`:

- Node.js: `^20.19.0 || >=22.12.0`

### 3. Install dependencies

```bash
npm install
```

### 4. Configure environment variables

```bash
cp .env.example .env
```

Available mode-specific environment files:

- `.env.development` -> `VITE_API_URL=http://127.0.0.1:8000`
- `.env.develop` -> `VITE_API_URL=https://api.develop.kinetiq.scesi.dev`
- `.env.production` -> `VITE_API_URL=https://api.kinetiq.scesi.dev`

### 5. Run the development environment

```bash
npm run dev
```

The frontend will be available at the URL printed by Vite (default: `http://localhost:5173`).

## Backend dependency

This frontend communicates with the [kinetiq-backend](https://github.com/Richixs/kinetiq-backend) API. The API base URL is configured through `VITE_API_URL` and loaded by Vite mode (`local`, `develop`, `production`).

Local mode uses a direct backend URL (`http://127.0.0.1:8000`), so CORS must be enabled in the backend for your frontend origin.

Without the backend running, the simulation form will submit but return a network error.

## Usage

1. Start the FastAPI backend on port 8000.
2. Start the frontend with `npm run dev`.
3. Open the web interface at `http://localhost:5173`.
4. Set the total simulation time (t_max).
5. Add up to 3 moviles with their parameters (position, velocity, start time, color).
6. Click **Simular** and wait for the Manim render (~15–25 seconds).
7. Watch the resulting animation in the embedded video player.

## Project structure

Current structure (summary):

```text
.
|-- public/
|-- src/
|   |-- assets/
|   |-- components/
|   |   `-- MovilCard.vue     # Editable card for a single movil's parameters
|   |-- router/
|   |-- views/
|   |   `-- HomeView.vue      # Main simulator view (form + video player)
|   |-- types.ts              # Shared TypeScript interfaces (Movil)
|   |-- App.vue
|   `-- main.ts
|-- Dockerfile
|-- docker-compose.yml
|-- nginx.conf
`-- package.json
```

## Available scripts

| Script                     | Description                                          |
| -------------------------- | ---------------------------------------------------- |
| `npm run dev`              | Starts Vite in development mode (`.env.development`) |
| `npm run dev:develop`      | Starts Vite in develop mode (`.env.develop`)         |
| `npm run dev:production`   | Starts Vite in production mode (`.env.production`)   |
| `npm run build`            | Runs type-check and production build                 |
| `npm run build:develop`    | Builds with develop mode                             |
| `npm run build:production` | Builds with production mode                          |
| `npm run build-only`       | Creates a production build without extra type-check  |
| `npm run preview`          | Serves the built app locally                         |
| `npm run type-check`       | Runs type checking with `vue-tsc`                    |
| `npm run lint`             | Runs lint pipeline (`oxlint` + `eslint`)             |
| `npm run lint:oxlint`      | Runs fast linting with oxlint                        |
| `npm run lint:eslint`      | Runs ESLint                                          |
| `npm run format`           | Formats source files with Prettier                   |
| `npm run format:check`     | Checks formatting without changing files             |

## Contributing

Contributions are welcome, especially in academic and open-source contexts. To contribute:

1. Read [CONTRIBUTING.md](CONTRIBUTING.md).
2. Follow [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).
3. Open an Issue before implementing large changes.

## License

This project is licensed under the MIT License.

See [LICENSE.md](LICENSE.md) for the full text.
