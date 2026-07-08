const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage({ viewport: { width: 1920, height: 1080 } });
  
  // Navigate to the dev server
  await page.goto('http://localhost:4176/');
  
  // Wait for content to load
  await page.waitForTimeout(3000);
  
  // Take screenshot
  await page.screenshot({ path: '/tmp/hero-dev.png', fullPage: false });
  
  // Check gradient overlay
  const gradientInfo = await page.evaluate(() => {
    const divs = document.querySelectorAll('#hero div[style*="z-index"]');
    return Array.from(divs).map(d => ({
      style: d.style.cssText,
      zIndex: window.getComputedStyle(d).zIndex,
      background: window.getComputedStyle(d).background.substring(0, 100),
      opacity: window.getComputedStyle(d).opacity
    }));
  });
  console.log('Gradient overlays:', JSON.stringify(gradientInfo, null, 2));
  
  // Check hero section visibility
  const heroText = await page.locator('.hero-title').textContent();
  console.log('Hero title:', heroText);
  
  await browser.close();
  console.log('Screenshot saved to /tmp/hero-dev.png');
})();
