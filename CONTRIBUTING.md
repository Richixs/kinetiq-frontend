# Contributing to Kinetiq Frontend

Thank you for your interest in contributing to Kinetiq Frontend. This is an academic and open-source project, so we value contributions that are clear, maintainable, and well documented.

## Prerequisites

- A GitHub account
- A Node.js version compatible with this project
- npm installed

## Contribution workflow

### 1. Fork the repository

1. Go to the main repository.
2. Click **Fork**.
3. Clone your fork locally:

```bash
git clone https://github.com/your-username/kinetiq-frontend.git
cd kinetiq-frontend
```

### 2. Create a branch

Use descriptive branch names based on the type of change:

- `feature/short-change-name`
- `fix/short-bug-name`
- `docs/short-docs-name`
- `refactor/short-refactor-name`

Example:

```bash
git checkout -b feature/simulation-parameter-panel
```

### 3. Make your changes

- Keep each Pull Request focused on a single goal.
- Update or add documentation when needed.
- Avoid unrelated changes.

### 4. Run local checks

```bash
npm run lint
npm run type-check
npm run build
```

### 5. Create commits using conventions

Use the Conventional Commits style:

- `feat: add simulation controls`
- `fix: correct animation time calculation`
- `docs: update backend configuration`
- `refactor: simplify simulation composable`
- `chore: update dependencies`

Suggested rules:

- Use present tense.
- Be clear and specific.
- A commit should represent one logical unit of change.

### 6. Open your Pull Request

Include:

- Context and goal of the change.
- Screenshots or visual evidence for UI changes.
- Notes about tests you ran.
- References to related Issues (if applicable).

## Pull Request conventions

- Use a descriptive, concise title.
- Provide a structured description (problem, solution, validation).
- Do not mix large refactors with functional features in the same PR.
- Address review comments and keep technical discussion clear.

## Code style

- Follow the ESLint and Prettier configuration used in the project.
- Keep component and file naming consistent.
- Prefer small, readable, reusable functions and components.
- Avoid complex logic directly inside templates.
- Add comments only when context is not obvious.

## Bug reports and feature requests

To report bugs or propose improvements:

1. Check whether a related Issue already exists.
2. If not, create one with reproduction steps and expected behavior.
3. Include relevant environment details (OS, browser, Node version).

## License

By contributing to this project, you agree that your code will be published under the repository's MIT License.
