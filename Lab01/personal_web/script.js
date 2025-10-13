document.addEventListener('DOMContentLoaded', () => {
  const year = new Date().getFullYear();
  document.querySelectorAll('[data-year]').forEach(n => n.textContent = year);
});