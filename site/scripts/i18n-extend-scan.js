const fs = require('fs');
const path = require('path');

function readJson(p){ return JSON.parse(fs.readFileSync(p,'utf8')); }

const projects = readJson('site/src/content/projects.json');
const experiences = readJson('site/src/content/experiences.json');
const en = readJson('site/public/locales/en.json');
const fr = readJson('site/public/locales/fr.json');

function flatten(obj, prefix = ''){
  const out = {};
  if (Array.isArray(obj)){
    obj.forEach((v, i) => {
      const key = `${prefix}${i}`;
      if (v && typeof v === 'object') Object.assign(out, flatten(v, key + '.'));
      else out[key] = v;
    });
    return out;
  }
  for(const k in obj){
    const v = obj[k];
    const key = prefix + k;
    if(v && typeof v === 'object' && !Array.isArray(v)) Object.assign(out, flatten(v, key + '.'));
    else out[key] = v;
  }
  return out;
}
const enKeys=Object.keys(flatten(en));
const frKeys=Object.keys(flatten(fr));

// build expected dynamic keys for projects and experiences
const expected=[];
projects.forEach(p=>{
  const s=p.slug;
  ['title','description','period','context','seeProject'].forEach(k=> expected.push(`projects.${s}.${k}`));
});
experiences.forEach(e=>{
  const s=e.slug;
  ['title','company','location','period','context','description','missions_title'].forEach(k=> expected.push(`experiences.${s}.${k}`));
  // missions array keys: experiences.<slug>.missions.<idx>
  if(Array.isArray(e.missions)){
    e.missions.forEach((m,idx)=> expected.push(`experiences.${s}.missions.${idx}`));
  }
});

// skills categories (from Skills.astro hardcoded keys)
const skillCategoryKeys = [
  'skills.categories.languages',
  'skills.categories.embedded',
  'skills.categories.design',
  'skills.categories.devops',
  'skills.categories.web',
  'skills.categories.testing'
];
skillCategoryKeys.forEach(k=> expected.push(k));

// other typical keys that might be dynamic
['nav.about','nav.experience','nav.education','nav.skills','nav.projects','nav.contact'].forEach(k=>expected.push(k));

// compute missing
const missingEn=[]; const missingFr=[];
expected.forEach(k=>{
  // if key ends with .<number> and parent array key exists, consider it present
  const arrayIndexMatch = k.match(/^(.*)\.\d+$/);
  if(arrayIndexMatch){
    const parent = arrayIndexMatch[1];
    if(enKeys.includes(parent)){
      // present in en
    } else if(!enKeys.includes(k)) missingEn.push(k);
    if(frKeys.includes(parent)){
      // present in fr
    } else if(!frKeys.includes(k)) missingFr.push(k);
    return;
  }
  if(!enKeys.includes(k)) missingEn.push(k);
  if(!frKeys.includes(k)) missingFr.push(k);
});

console.log('Expected dynamic keys count:', expected.length);
console.log('\nMissing in en.json:', missingEn.length); missingEn.forEach(k=>console.log('  ',k));
console.log('\nMissing in fr.json:', missingFr.length); missingFr.forEach(k=>console.log('  ',k));
