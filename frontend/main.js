const API_BASE = 'http://127.0.0.1:5000/api';

async function fetchReadings(){
  const res = await fetch(`${API_BASE}/readings?limit=50&sort=timestamp_desc`);
  return res.json();
}

async function fetchStats(){
  const res = await fetch(`${API_BASE}/stats`);
  return res.json();
}

function renderTable(rows){
  const tbody = document.querySelector('#readings-table tbody');
  tbody.innerHTML = '';
  rows.forEach(r=>{
    const tr = document.createElement('tr');
    tr.innerHTML = `<td>${new Date(r.timestamp).toLocaleString()}</td><td>${r.db_level}</td><td>${r.location}</td><td>${r.noise_type}</td><td>${r.device_id}</td>`;
    tbody.appendChild(tr);
  });
}

let chart;
function renderChart(rows){
  const ctx = document.getElementById('chart').getContext('2d');
  const labels = rows.slice().reverse().map(r=>new Date(r.timestamp).toLocaleTimeString());
  const data = rows.slice().reverse().map(r=>r.db_level);
  if(chart) chart.destroy();
  chart = new Chart(ctx, {
    type: 'line',
    data: {labels, datasets:[{label:'dB level', data}]},
    options:{scales:{y:{beginAtZero:true}}}
  });
}

async function refresh(){
  const rows = await fetchReadings();
  renderTable(rows);
  renderChart(rows);
  const s = await fetchStats();
  document.getElementById('summary-text').innerText = `Count: ${s.count} • Avg: ${Number(s.avg_db || 0).toFixed(1)} dB • Min: ${Number(s.min_db||0).toFixed(1)} dB • Max: ${Number(s.max_db||0).toFixed(1)} dB`;
}

document.getElementById('add-form').addEventListener('submit', async (e)=>{
  e.preventDefault();
  const fd = new FormData(e.target);
  const payload = {
    db_level: fd.get('db_level'),
    location: fd.get('location') || 'unknown',
    noise_type: fd.get('noise_type') || 'unknown',
    device_id: 'web-client'
  };
  await fetch(`${API_BASE}/readings`, {method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(payload)});
  e.target.reset();
  await refresh();
});

refresh();
setInterval(refresh, 30000);
