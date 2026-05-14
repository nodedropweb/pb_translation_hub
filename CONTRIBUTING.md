# Contributing to PB Translation Hub

Thank you for your interest in improving the Drupal Project Browser translation ecosystem! 

## 🚀 Getting Started
1. Clone the repository.
2. Follow the [README.md](./README.md) instructions to set up your environment (Docker is recommended).
3. Check the [DATABASE.md](./DATABASE.md) for the schema details.

## 🛠 Development Workflow

### Frontend (React)
The frontend is built with **Vite** and **Tailwind CSS** (via vanilla-like classes). 
- **Style Guide:** Use the "Glassy/Acrylic" theme principles. Avoid plain colors; use semi-transparent backgrounds and blurs.
- **Components:** Keep components modular and localized. Use `LanguageContext` for all UI strings.

### Backend (Node.js)
The backend is a standard **Express** server.
- **Database:** All queries should use prepared statements with `mysql2`.
- **Filtering:** Use the central `getFilteredIndex` function for project queries to maintain consistency.
- **AI Integration:** When modifying AI prompts, ensure placeholders like `[DESCRIPTION]` are maintained.

## 🧪 Testing
- **UI:** Test in both Light and Dark modes.
- **Translations:** Verify that HTML tags in descriptions are preserved during translation.
- **Sync:** When adding new fields, update the migration scripts in `server/`.

## 📝 Commit Guidelines
- Use descriptive commit messages.
- Prefix bug fixes with `fix:` and new features with `feat:`.

---
*Documentation state: **Living***
