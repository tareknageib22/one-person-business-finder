document.addEventListener('DOMContentLoaded', () => {
  const target = document.querySelector('#headline-d107e476 h3');

  if (target) {
    target.textContent = 'gsap intro';
    console.log('Target found:', target);
  } else {
    console.log('Target NOT found');
  }
});