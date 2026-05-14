const axios = require('axios');

/**
 * @file unsplash.js
 * Specialized service for Unsplash API integration.
 * Handles photo fetching, download tracking, and UTM attribution.
 */

// Load API key from environment
const UNSPLASH_ACCESS_KEY = process.env.UNSPLASH_ACCESS_KEY;

// Mandatory UTM parameters for Unsplash API compliance
const UTM_SOURCE = 'pb_translation_hub';
const UTM_MEDIUM = 'referral';
const UTM_PARAMS = `utm_source=${UTM_SOURCE}&utm_medium=${UTM_MEDIUM}`;

/**
 * Helper: Appends mandatory UTM parameters to Unsplash links.
 * Required for referral tracking and API compliance.
 * 
 * @param {string} url - The original Unsplash URL.
 * @returns {string} The URL with appended UTM parameters.
 */
function appendUTM(url) {
  if (!url) return url;
  const separator = url.includes('?') ? '&' : '?';
  return `${url}${separator}${UTM_PARAMS}`;
}

/**
 * Registers Unsplash-related endpoints to the Express application.
 * 
 * @param {import('express').Express} app - The Express app instance.
 */
function registerUnsplashRoutes(app) {
  
  /**
   * GET /api/unsplash/random-bg
   * Fetches a random high-quality photo based on keywords.
   * Includes a PicSum fallback if the Unsplash API is unavailable or rate-limited.
   */
  app.get('/api/unsplash/random-bg', async (req, res) => {
    const { query } = req.query;
    
    try {
      // 1. Attempt to fetch from official Unsplash API
      const response = await axios.get('https://api.unsplash.com/photos/random', {
        params: { 
          query: query || 'nature, abstract', 
          orientation: 'landscape',
          client_id: UNSPLASH_ACCESS_KEY 
        },
        timeout: 5000
      });
      
      const photo = response.data;
      
      // Return structured data for the frontend
      res.json({ 
        url: photo.urls.regular, 
        source: 'unsplash',
        photographer: {
          name: photo.user.name,
          username: photo.user.username,
          link: appendUTM(photo.user.links.html)
        },
        unsplash_link: appendUTM('https://unsplash.com/'),
        download_location: photo.links.download_location
      });
      
    } catch (error) {
      console.warn('Unsplash API unavailable. Triggering PicSum fallback.');
      
      // 2. Fallback: Picsum Photos (Theme-specific seed based on query)
      const seed = Buffer.from(query || 'default').toString('base64').substring(0, 10);
      const fallbackUrl = `https://picsum.photos/seed/${seed}/1920/1080`;
      
      res.json({ 
        url: fallbackUrl, 
        source: 'picsum',
        error: error.response?.status === 403 ? 'Rate limit' : 'API error'
      });
    }
  });

  /**
   * POST /api/unsplash/track-download
   * Notifies Unsplash that a photo has been "used" (displayed as background).
   * This is a mandatory requirement of the Unsplash API guidelines.
   */
  app.post('/api/unsplash/track-download', async (req, res) => {
    const { download_location } = req.body;
    
    if (!download_location) return res.status(400).json({ error: 'Missing download_location' });

    try {
      // Guidelines: This must be a simple GET request to the provided location
      await axios.get(download_location, {
        params: { client_id: UNSPLASH_ACCESS_KEY }
      });
      res.json({ success: true });
    } catch (error) {
      // We log but don't fail the user experience if tracking fails
      console.error('Unsplash tracking failed:', error.message);
      res.status(500).json({ error: 'Tracking failed' });
    }
  });
}

module.exports = { registerUnsplashRoutes };
