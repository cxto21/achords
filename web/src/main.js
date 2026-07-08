import './style.css'
import { setLang, getLang, t } from './i18n.js'

// ══════════════════════════════════════════════════════════════════════
// Main entry — Achords Landing Page
// ══════════════════════════════════════════════════════════════════════

document.addEventListener('DOMContentLoaded', () => {
  // Language toggle
  document.querySelectorAll('.lang-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      setLang(btn.dataset.lang)
    })
  })

  // Waveform interaction — mouse
  window.addEventListener('mousemove', (e) => {
    const bars = document.querySelectorAll('.waveform-bar')
    const index = Math.floor((e.clientX / window.innerWidth) * bars.length)
    if (bars[index]) {
      bars[index].style.height = `${Math.random() * 95}%`
      bars[index].style.backgroundColor = '#fff'
      setTimeout(() => {
        bars[index].style.backgroundColor = ''
      }, 300)
    }
  })

  // Waveform auto-animation
  function animateWaveform() {
    const bars = document.querySelectorAll('.waveform-bar')
    if (bars.length === 0) return
    // Pick 3 random bars to animate
    for (let i = 0; i < 3; i++) {
      const idx = Math.floor(Math.random() * bars.length)
      const bar = bars[idx]
      if (bar) {
        bar.style.height = `${Math.random() * 95}%`
        bar.style.transition = 'height 0.3s ease'
      }
    }
  }
  setInterval(animateWaveform, 400)

  // Logo click effect
  const logo = document.querySelector('.logo-text')
  if (logo) {
    logo.addEventListener('click', () => {
      logo.style.animationDuration = '1s'
      setTimeout(() => {
        logo.style.animationDuration = '8s'
      }, 1000)
    })
  }

  // Copy terminal command
  document.querySelectorAll('.copy-cmd').forEach(btn => {
    btn.addEventListener('click', () => {
      const cmd = btn.closest('.terminal-box')?.querySelector('.cmd-text')?.textContent
      if (cmd) {
        navigator.clipboard.writeText(cmd.trim())
        btn.textContent = '✓'
        setTimeout(() => { btn.textContent = 'content_copy' }, 1500)
      }
    })
  })
})
