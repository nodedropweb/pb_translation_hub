/**
 * @file constants.js
 * Global constants and configuration for the Project Browser Translation Hub.
 */

export const BACKEND_URL = import.meta.env.VITE_BACKEND_URL || '';
export const API_BASE = import.meta.env.VITE_API_BASE_URL || '/api';

export const THEMES = [
  { id: 'light', name: 'Light', nameDe: 'Hell', icon: 'Sun', keywords: 'minimalist, white, clean' },
  { id: 'dark', name: 'Dark', nameDe: 'Dunkel', icon: 'Moon', keywords: 'midnight, stars, dark' },
  { id: 'glassy', name: 'Glassy', nameDe: 'Glasig', icon: 'Palette', keywords: 'glassmorphism, abstract, blurry' },
  { id: 'nature', name: 'Nature', nameDe: 'Natur', icon: 'Droplets', keywords: 'forest, mountains, river, nature' },
  { id: 'liquid', name: 'Liquid', nameDe: 'Flüssig', icon: 'Zap', keywords: 'liquid, color, flow' }
];

export const LANGUAGES = [
  { code: 'de', name: 'German' },
  { code: 'fr', name: 'French' },
  { code: 'es', name: 'Spanish' },
  { code: 'it', name: 'Italian' }
];

export const DEFAULT_AI_PROMPT = `Translate the following two HTML blocks (summary and main description) from the Drupal Project Browser to {{langcode}}.
IMPORTANT:
1. Return ONLY the translation.
2. Do NOT add any introduction, comments, or explanations (e.g., NO "Here is the translation").
3. Module names must stay in English.
4. Links and image URLs must remain unchanged.
5. Separate the two translated blocks EXACTLY by the string '---'.

Summary:
{{summary}}

---

Main Description:
{{body}}`;
