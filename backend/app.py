from flask import Flask, g, jsonify, request, send_from_directory
import sqlite3
from datetime import datetime
from pathlib import Path

DB_PATH = Path(__file__).parent / 'db.sqlite3'

app = Flask(__name__, static_folder='../frontend', static_url_path='/')

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DB_PATH)
        db.row_factory = sqlite3.Row
    return db

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

@app.route('/')
def serve_frontend():
    return send_from_directory(app.static_folder, 'index.html')

@app.route('/api/readings', methods=['GET'])
def list_readings():
    limit = int(request.args.get('limit', 100))
    offset = int(request.args.get('offset', 0))
    sort = request.args.get('sort', 'timestamp_desc')
    order = 'DESC' if sort.endswith('desc') else 'ASC'
    cur = get_db().execute(f"SELECT * FROM readings ORDER BY timestamp {order} LIMIT ? OFFSET ?", (limit, offset))
    rows = cur.fetchall()
    return jsonify([dict(row) for row in rows])

@app.route('/api/readings', methods=['POST'])
def add_reading():
    data = request.get_json() or {}
    timestamp = data.get('timestamp') or datetime.utcnow().isoformat()
    db_level = float(data.get('db_level', 0))
    location = data.get('location', 'unknown')
    noise_type = data.get('noise_type', 'unknown')
    device_id = data.get('device_id', 'device-unknown')
    cur = get_db().execute(
        'INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES (?, ?, ?, ?, ?)',
        (timestamp, db_level, location, noise_type, device_id)
    )
    get_db().commit()
    new_id = cur.lastrowid
    row = get_db().execute('SELECT * FROM readings WHERE id = ?', (new_id,)).fetchone()
    return jsonify(dict(row)), 201

@app.route('/api/stats', methods=['GET'])
def stats():
    from_ts = request.args.get('from')
    to_ts = request.args.get('to')
    q = 'SELECT COUNT(*) as count, AVG(db_level) as avg_db, MIN(db_level) as min_db, MAX(db_level) as max_db FROM readings'
    params = []
    if from_ts and to_ts:
        q += ' WHERE timestamp BETWEEN ? AND ?'
        params = [from_ts, to_ts]
    row = get_db().execute(q, params).fetchone()
    return jsonify(dict(row))

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
