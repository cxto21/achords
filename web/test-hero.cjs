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
  
  // Check the hero section elements
  const heroSection = await page.locator('#hero').boundingBox();
  console.log('Hero section:', heroSection);
  
  // Check if gradient overlay exists
  const gradientOverlay = await page.locator('.absolute.inset-0.z-\\[1\\]').count();
  console.log('Gradient overlay count:', gradientOverlay);
  
  // Get computed styles of the gradient
  const gradientStyle = await page.evaluate(() => {
    const el = document.querySelector('.absolute.inset-0.z-\\[1\\]');
    if (el) {
      return {
        background: window.getComputedStyle(el).background,
        display: window.getComputedStyle(el).display,
        opacity: window.getComputedStyle(el).opacity,
        zIndex: window.getComputedStyle(el).zIndex
      };
    }
    return null;
  });
  console.log('Gradient styles:', gradientStyle);
  
  await browser.close();
  console.log('Screenshot saved to /tmp/hero-screenshot.png');
})();
