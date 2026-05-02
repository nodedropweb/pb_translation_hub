const axios = require('axios');
const fs = require('fs-extra');
const path = require('path');

const CATEGORIES_API = 'https://www.drupal.org/jsonapi/taxonomy_term/module_categories';
const DE_CAT_PATH = '/var/www/drupalcms/pb_translation_hub/server/data/translations/de/categories.json';

async function check() {
  try {
    const apiRes = await axios.get(CATEGORIES_API, {
      params: { 'fields[taxonomy_term--module_categories]': 'name' }
    });
    const apiCats = apiRes.data.data;
    const deTrans = await fs.readJson(DE_CAT_PATH);

    console.log('--- API Categories ---');
    apiCats.forEach(cat => {
      const trans = deTrans[cat.id];
      console.log(`${cat.id} | ${cat.attributes.name} -> ${trans || 'MISSING'}`);
    });
  } catch (err) {
    console.error(err);
  }
}

check();
