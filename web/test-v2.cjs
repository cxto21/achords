const { chromium } = require('playwright');
const { spawn } = require('child_process');
const path = require('path');

(async () => {
  const dist = path.join(__dirname, 'dist');
  const server = spawn('npx', ['serve', dist, '-l', '4201', '--no-clipboard'], {
    stdio: 'pipe', shell: true,
  });
  await new Promise(r => setTimeout(r, 3000));

  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage({ viewport: { width: 1920, height: 1080 } });

  try {
    await page.goto('http://localhost:4201/', { waitUntil: 'networkidle', timeout: 15000 });
    await page.waitForTimeout(2000);
    await page.screenshot({ path: '/tmp/achords-hero-v2.png', fullPage: false });
    console.log('Screenshot saved');
  } finally {
    await browser.close();
    server.kill();
  }
})();
