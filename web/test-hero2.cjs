const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage({ viewport: { width: 1920, height: 1080 } });
  
  // Navigate to the built site
  await page.goto('file:///home/kiox/achords/web/dist/index.html');
  
  // Wait for content to load
  await page.waitForTimeout(2000);
  
  // Take screenshot of hero section
  await page.screenshot({ path: '/tmp/hero-screenshot.png', fullPage: false });
  
  // Check all absolute divs in hero
  const heroDivs = await page.locator('#hero .absolute').count();
  console.log('Hero absolute divs:', heroDivs);
  
  // Get all divs with inline style containing z-index
  const styledDivs = await page.evaluate(() => {
    const divs = document.querySelectorAll('#hero div[style*="z-index"]');
    return Array.from(divs).map(d => ({
      style: d.style.cssText,
      computed: {
        background: window.getComputedStyle(d).background,
        zIndex: window.getComputedStyle(d).zIndex,
        opacity: window.getComputedStyle(d).opacity
      }
    }));
  });
  console.log('Styled divs:', JSON.stringify(styledDivs, null, 2));
  
  await browser.close();
})();
