/**
 * @file constants.js
 * Global constants and configuration for the Project Browser Translation Hub.
 */

export const BACKEND_URL = import.meta.env.VITE_BACKEND_URL || 'http://drupalcms.site:9901';
export const API_BASE = import.meta.env.VITE_API_BASE_URL || `${BACKEND_URL}/api`;

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
