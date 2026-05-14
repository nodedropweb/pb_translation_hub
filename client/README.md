# PB Translation Hub Client

This is the React-based administration interface for the Project Browser Translation Hub. It features a premium, modular architecture designed for high performance and AI-assisted development ("snackable" code).

## 🏗 Modular Architecture

The codebase has been meticulously modularized into specialized directories to ensure a clean separation of concerns:

### `src/views/`
Contains the top-level page components. Each view is responsible for its own business logic and layout.
- `Dashboard.jsx`: Project overview, sync management, and filtering.
- `Editor.jsx`: The heart of the app—the translation interface with AI support.
- `CategoriesView.jsx`: specialized view for translating Drupal categories.
- `SettingsView.jsx`: Admin configuration, backup management, and theme selection.
- `ProfileView.jsx`: User-specific settings, including Gemini API key and personal prompts.
- `LoginView.jsx` / `RegisterView.jsx`: Authentication flows.
- `HelpView.jsx`: Documentation and GDPR-compliant tutorial videos.

### `src/components/`
Small, reusable building blocks divided into:
- **`layout/`**: Structural components like `AppContent.jsx` (Sidebar + Top bar + Routing).
- **`shared/`**: Complex components used in multiple views (e.g., `BulkAiModal.jsx`, `PrivacyVideo.jsx`).
- **`ui/`**: Low-level UI elements (e.g., `StatusBadge.jsx`, `TagInput.jsx`, `ToastContainer.jsx`).

### `src/context/`
Centralized state management using React Context API:
- `AuthContext`: Authentication state and login/logout logic.
- `LanguageContext`: Target language selection and language list.
- `ThemeContext`: Global styling (Dark, Glassy, Nature, Liquid) and Unsplash background management.
- `ToastContext`: System notifications.
- `WorkflowContext`: Global workflow toggles (e.g., Drupal 11 Priority Mode).

### `src/utils/`
Static assets and helpers:
- `constants.js`: API endpoints (defaulting to port **9901** for the backend), theme definitions, and global lists.
- `helpers.js`: Specialized string manipulation (e.g., Drupal URL fixing) and formatting.

## ⚙️ API Configuration

By default, the client expects the backend API at `http://drupalcms.site:9901`. Port 9901 was chosen to avoid conflicts with common development tools like Gulp or Browsersync that often use 3001.

To override this, you can use environment variables in a `.env` file (not included):
- `VITE_BACKEND_URL`: Root URL of the backend.
- `VITE_API_BASE_URL`: Full URL to the `/api` endpoint.

## 🎨 Premium Design System

The application uses a custom **Glassmorphism / Acrylic** design system built with Vanilla CSS and TailwindCSS utilities. It features:
- **Dynamic Backgrounds**: Automated fetch of high-quality Unsplash images based on the active theme.
- **Theme Support**: Real-time switching between Light, Dark, Glassy, Nature, and Liquid modes.
- **Micro-Animations**: Smooth transitions using Framer Motion-inspired CSS animations.

## 🛠 Development

### Setup
```bash
npm install
```

### Run Dev Server
```bash
npm run dev
```

### Build for Production
```bash
npm run build
```

## 🤖 AI-Ready ("Snackable")
The code is fragmented into small, focused modules. This makes it highly efficient for AI assistants to process specific features without exceeding context limits, ensuring precise and reliable code generation.
