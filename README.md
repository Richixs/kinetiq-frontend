# Kinetiq Frontend

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE.md)
![Status](https://img.shields.io/badge/status-in%20development-blue)
![Vue 3](https://img.shields.io/badge/Vue-3.x-42b883)
[![Backend API](https://img.shields.io/badge/API-FastAPI-009688)](https://github.com/Richixs/kinetiq-backend)

Frontend for an interactive kinematics simulator built with Vue.js. The project allows users to visualize physics simulations and consume data from a FastAPI backend API.

This repository is part of an academic project for the General Physics course in the Computer Science program at Universidad Mayor de San Simon (UMSS), Bolivia.

## Table of contents

- [Deployments](#deployments)
- [Installation](#installation)
- [Usage](#usage)
- [Project structure](#project-structure)
- [Available scripts](#available-scripts)
- [Contributing](#contributing)
- [License](#license)

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

### 5. Run the development environment

```bash
npm run dev
```

The frontend will be available at the URL printed by Vite (default: `http://localhost:5173`).

## Usage

1. Start the FastAPI backend.
2. Start the frontend with `npm run dev`.
3. Open the web interface.
4. Configure simulation parameters (for example: initial position, velocity, acceleration, and time).
5. Run the simulation and analyze visual outputs and metrics.

## Project structure

Current structure (summary):

```text
.
|-- public/
|-- src/
|   |-- assets/
|   |-- components/
|   |-- router/
|   |-- views/
|   |-- App.vue
|   `-- main.ts
|-- Dockerfile
|-- docker-compose.yml
|-- nginx.conf
`-- package.json
```

## Available scripts

| Script                 | Description                                         |
| ---------------------- | --------------------------------------------------- |
| `npm run dev`          | Starts the Vite development server                  |
| `npm run build`        | Runs type-check and production build                |
| `npm run build-only`   | Creates a production build without extra type-check |
| `npm run preview`      | Serves the built app locally                        |
| `npm run type-check`   | Runs type checking with `vue-tsc`                   |
| `npm run lint`         | Runs lint pipeline (`oxlint` + `eslint`)            |
| `npm run lint:oxlint`  | Runs fast linting with oxlint                       |
| `npm run lint:eslint`  | Runs ESLint                                         |
| `npm run format`       | Formats source files with Prettier                  |
| `npm run format:check` | Checks formatting without changing files            |

## Contributing

Contributions are welcome, especially in academic and open-source contexts. To contribute:

1. Read [CONTRIBUTING.md](CONTRIBUTING.md).
2. Follow [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).
3. Open an Issue before implementing large changes.

## License

This project is licensed under the MIT License.

See [LICENSE.md](LICENSE.md) for the full text.
