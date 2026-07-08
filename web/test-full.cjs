const { chromium } = require('playwright');
const { spawn } = require('child_process');
const path = require('path');

(async () => {
  // Start vite preview server
  const dist = path.join(__dirname, 'dist');
  const server = spawn('npx', ['serve', dist, '-l', '4200', '--no-clipboard'], {
    stdio: 'pipe',
    shell: true,
  });

  // Wait for server
  await new Promise(r => setTimeout(r, 3000));

  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage({ viewport: { width: 1920, height: 1080 } });

  try {
    await page.goto('http://localhost:4200/', { waitUntil: 'networkidle', timeout: 15000 });
    await page.waitForTimeout(2000);

    // Full page screenshot
    await page.screenshot({ path: '/tmp/achords-full.png', fullPage: true });
    // Hero only
    await page.screenshot({ path: '/tmp/achords-hero.png', fullPage: false });

    // Check gradient overlays
    const gradientInfo = await page.evaluate(() => {
      const hero = document.querySelector('#hero');
      if (!hero) return 'NO HERO FOUND';
      const divs = hero.querySelectorAll('div[style*="z-index"]');
      return Array.from(divs).map(d => ({
        style: d.style.cssText,
        computedBg: window.getComputedStyle(d).background.substring(0, 120),
        zIndex: window.getComputedStyle(d).zIndex,
        opacity: window.getComputedStyle(d).opacity,
        dimensions: d.getBoundingClientRect(),
      }));
    });
    console.log('Gradient overlays:', JSON.stringify(gradientInfo, null, 2));

    // Check if text is visible over the gradient
    const heroTitle = await page.evaluate(() => {
      const el = document.querySelector('.hero-title');
      if (!el) return 'NOT FOUND';
      const style = window.getComputedStyle(el);
      return {
        text: el.textContent.trim(),
        color: style.color,
        zIndex: style.zIndex,
        position: style.position,
        rect: el.getBoundingClientRect()
      };
    });
    console.log('Hero title:', JSON.stringify(heroTitle, null, 2));

    // Check all layers in hero
    const layers = await page.evaluate(() => {
      const hero = document.querySelector('#hero');
      if (!hero) return [];
      const all = hero.querySelectorAll('.absolute');
      return Array.from(all).map(d => ({
        tag: d.tagName,
        classes: d.className.substring(0, 100),
        style: d.style.cssText.substring(0, 120),
        zIndex: window.getComputedStyle(d).zIndex,
        rect: { w: d.getBoundingClientRect().width, h: d.getBoundingClientRect().height }
      }));
    });
    console.log('All hero layers:', JSON.stringify(layers, null, 2));

  } finally {
    await browser.close();
    server.kill();
  }
})();
