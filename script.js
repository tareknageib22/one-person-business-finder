(() => {
  const button = document.querySelector("#count-button");
  const countDisplay = document.querySelector("#click-count");

  if (!button || !countDisplay) {
    return;
  }

  let count = 0;

  button.addEventListener("click", () => {
    count += 1;
    countDisplay.textContent = String(count);
  });
})();
