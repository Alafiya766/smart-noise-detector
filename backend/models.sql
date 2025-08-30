PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS readings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  timestamp TEXT NOT NULL,
  db_level REAL NOT NULL,
  location TEXT,
  noise_type TEXT,
  device_id TEXT
);

INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T08:30:00', 35.2, 'Library', 'ambient', 'device-001');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T08:35:00', 70.4, 'Street', 'traffic', 'device-002');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T08:40:00', 45.0, 'Cafeteria', 'conversation', 'device-003');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T08:45:00', 52.0, 'Playground', 'children', 'device-001');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T09:00:00', 88.5, 'Construction', 'machinery', 'device-004');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T09:10:00', 30.1, 'Office', 'ambient', 'device-005');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T09:20:00', 65.7, 'Market', 'crowd', 'device-002');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T09:30:00', 55.3, 'Road', 'traffic', 'device-006');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T09:40:00', 40.0, 'Classroom', 'lecture', 'device-001');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T09:50:00', 47.6, 'Cafeteria', 'conversation', 'device-003');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T10:00:00', 72.2, 'Street', 'traffic', 'device-002');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T10:10:00', 38.5, 'Library', 'ambient', 'device-001');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T10:20:00', 95.1, 'Concert', 'music', 'device-007');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T10:30:00', 60.0, 'Gym', 'exercise', 'device-008');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T10:40:00', 32.7, 'Office', 'ambient', 'device-005');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T10:50:00', 49.9, 'Road', 'traffic', 'device-006');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T11:00:00', 81.3, 'Factory', 'machinery', 'device-004');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T11:10:00', 36.0, 'Cafeteria', 'ambient', 'device-003');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T11:20:00', 43.5, 'Library', 'ambient', 'device-001');
INSERT INTO readings (timestamp, db_level, location, noise_type, device_id) VALUES ('2025-08-29T11:30:00', 68.8, 'Market', 'crowd', 'device-002');

COMMIT;
