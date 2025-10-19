const fs = require('fs');
const glob = require('glob');

function collectDataI18n(){
  const files = glob.sync('site/src/**/*.astro');
  const keys = new Set();
  files.forEach(f => {
    const s = fs.readFileSync(f, 'utf8');
    const regexLit = /data-i18n=\"([^\"]+)\"/g;
    let m;
    while((m = regexLit.exec(s))){ keys.add(m[1]); }
    const regexExpr = /data-i18n=\{([^\}]+)\}/g;
    while((m = regexExpr.exec(s))){ keys.add('{EXPR}:' + m[1].trim()); }
  });
  return Array.from(keys).sort();
}

function flatten(obj, prefix = ''){
  const out = {};
  if(Array.isArray(obj)){
    out[prefix.slice(0, -1)] = obj;
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

function main(){
  const used = collectDataI18n();
  const en = JSON.parse(fs.readFileSync('site/public/locales/en.json', 'utf8'));
  const fr = JSON.parse(fs.readFileSync('site/public/locales/fr.json', 'utf8'));
  const enKeys = Object.keys(flatten(en));
  const frKeys = Object.keys(flatten(fr));

  console.log('Used keys (literals and expressions):', used.length);
  used.forEach(k => console.log('  ', k));

  const missingInEn = [];
  const missingInFr = [];

  used.forEach(u => {
    if(u.startsWith('{EXPR}:')){
      console.log('Found dynamic expression pattern:', u.replace('{EXPR}:', ''));
      return;
    }
    if(!enKeys.includes(u)) missingInEn.push(u);
    if(!frKeys.includes(u)) missingInFr.push(u);
  });

  console.log('\nMissing in en.json:', missingInEn.length);
  missingInEn.forEach(k=>console.log('  ', k));
  console.log('\nMissing in fr.json:', missingInFr.length);
  missingInFr.forEach(k=>console.log('  ', k));
}

main();
