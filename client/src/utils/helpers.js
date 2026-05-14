/**
 * @file helpers.js
 * Specialized utility functions for Project Browser Translation Hub.
 */

/**
 * Fixes relative URLs in HTML by prefixing them with drupal.org domain.
 * This is needed because Project Browser often uses relative paths for images/links.
 * 
 * @param {string} html - The HTML content to process.
 * @returns {string} - The processed HTML with absolute URLs.
 */
export const fixRelativeUrls = (html) => {
  if (typeof html !== 'string') return '';
  return html.replace(/src="\/(sites|files|core|themes|modules)\/([^"]+)"/g, 'src="https://www.drupal.org/$1/$2"')
             .replace(/href="\/(sites|files|core|themes|modules)\/([^"]+)"/g, 'href="https://www.drupal.org/$1/$2"');
};

/**
 * Reverts absolute drupal.org URLs back to relative paths.
 * Useful when saving content back to the database to keep it clean.
 * 
 * @param {string} html - The HTML content to process.
 * @returns {string} - The processed HTML with relative URLs.
 */
export const stripAbsoluteUrls = (html) => {
  if (typeof html !== 'string') return '';
  return html.replace(/src="https:\/\/www\.drupal\.org\/(sites|files|core|themes|modules)\/([^"]+)"/g, 'src="/$1/$2"')
             .replace(/href="https:\/\/www\.drupal\.org\/(sites|files|core|themes|modules)\/([^"]+)"/g, 'href="/$1/$2"');
};
