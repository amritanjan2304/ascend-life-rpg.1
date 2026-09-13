CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(80) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  level INT NOT NULL DEFAULT 1 CHECK(level >= 1),
  xp BIGINT NOT NULL DEFAULT 0 CHECK(xp >= 0),
  gold INT NOT NULL DEFAULT 100 CHECK(gold >= 0),
  strength INT NOT NULL DEFAULT 5,
  wisdom INT NOT NULL DEFAULT 5,
  intellect INT NOT NULL DEFAULT 5,
  spirit INT NOT NULL DEFAULT 5,
  current_streak INT NOT NULL DEFAULT 0,
  best_streak INT NOT NULL DEFAULT 0,
  last_quest_date DATE,
  theme VARCHAR(40) NOT NULL DEFAULT 'nightfall',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS quests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(160) NOT NULL,
  description TEXT DEFAULT '',
  category VARCHAR(30) NOT NULL DEFAULT 'Discipline',
  difficulty VARCHAR(20) NOT NULL DEFAULT 'Normal',
  xp_reward INT NOT NULL DEFAULT 100 CHECK(xp_reward > 0),
  gold_reward INT NOT NULL DEFAULT 30 CHECK(gold_reward >= 0),
  attribute VARCHAR(20) NOT NULL DEFAULT 'wisdom',
  frequency VARCHAR(20) NOT NULL DEFAULT 'Daily',
  completed BOOLEAN NOT NULL DEFAULT FALSE,
  completed_at TIMESTAMPTZ,
  due_date DATE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS inventory (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  item_key VARCHAR(80) NOT NULL,
  item_type VARCHAR(20) NOT NULL,
  name VARCHAR(100) NOT NULL,
  description TEXT DEFAULT '',
  rarity VARCHAR(20) DEFAULT 'Common',
  image_url TEXT,
  purchased_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(user_id, item_key)
);

CREATE TABLE IF NOT EXISTS activity_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type VARCHAR(40) NOT NULL,
  message TEXT NOT NULL,
  xp_delta INT DEFAULT 0,
  gold_delta INT DEFAULT 0,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_quests_user ON quests(user_id, completed, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_activity_user ON activity_log(user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_leaderboard ON users(level DESC, xp DESC, gold DESC);

INSERT INTO users (name,email,password_hash) VALUES ('Demo Hero','demo@ascend.app','$2a$10$7Qe5kM4J6e7uYQ5h5r8mUeR0V6bF1w5oR0Kx0G6c1fQk5j3c0xwO2') ON CONFLICT DO NOTHING;
