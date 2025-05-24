-- 002_create_indexes.sql

-- Índice para búsqueda semántica en vectores
CREATE INDEX IF NOT EXISTS idx_embedding_vector
ON embedding USING hnsw (vector vector_cosine_ops);

-- Índices adicionales útiles
CREATE INDEX IF NOT EXISTS idx_ticket_estado ON ticket(estado);
CREATE INDEX IF NOT EXISTS idx_mensaje_id_sesion ON mensaje(id_sesion);
CREATE INDEX IF NOT EXISTS idx_handoff_id_ticket ON handoff(id_ticket);