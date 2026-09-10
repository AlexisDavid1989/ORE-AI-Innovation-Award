(() => {
  const countdown = document.querySelector('[data-contest-countdown]');
  if (!countdown) return;

  const start = new Date(countdown.dataset.start).getTime();
  const end = new Date(countdown.dataset.end).getTime();
  const label = countdown.querySelector('.countdown-label');
  const fields = {
    days: countdown.querySelector('[data-days]'),
    hours: countdown.querySelector('[data-hours]'),
    minutes: countdown.querySelector('[data-minutes]'),
    seconds: countdown.querySelector('[data-seconds]')
  };

  const pad = (value) => String(value).padStart(2, '0');

  function render() {
    const now = Date.now();
    let remaining;

    if (now < start) {
      label.textContent = 'Contest starts in';
      remaining = start - now;
    } else if (now < end) {
      label.textContent = 'Submissions close in';
      remaining = end - now;
    } else {
      label.textContent = 'Contest submissions are closed';
      remaining = 0;
    }

    const totalSeconds = Math.max(0, Math.floor(remaining / 1000));
    const days = Math.floor(totalSeconds / 86400);
    const hours = Math.floor((totalSeconds % 86400) / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);
    const seconds = totalSeconds % 60;

    fields.days.textContent = pad(days);
    fields.hours.textContent = pad(hours);
    fields.minutes.textContent = pad(minutes);
    fields.seconds.textContent = pad(seconds);
  }

  render();
  window.setInterval(render, 1000);
})();
