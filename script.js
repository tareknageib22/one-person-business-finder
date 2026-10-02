(() => {
  const selector = '#headline-d107e476 h3';
  const updateTarget = () => {
    const target = document.querySelector(selector);

    if (!target) {
      return false;
    }

    target.textContent = 'HI | Tarek Here,';
    console.log('Target found:', target);
    return true;
  };

  if (!updateTarget()) {
    const observer = new MutationObserver(() => {
      if (updateTarget()) {
        observer.disconnect();
      }
    });

    observer.observe(document.documentElement, { childList: true, subtree: true });
  }
})();