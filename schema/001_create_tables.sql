-- 001_create_tables.sql

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS usuario (
    id SERIAL PRIMARY KEY,
    telefono VARCHAR(20) UNIQUE NOT NULL,
    nombre TEXT,
    email TEXT,
    creado_en TIMESTAMP DEFAULT now()
);

-- Tabla de sesiones de chat
CREATE TABLE IF NOT EXISTS sesion_chat (
    id SERIAL PRIMARY KEY,
    id_usuario INTEGER REFERENCES usuario(id),
    canal TEXT DEFAULT 'whatsapp',
    fecha_inicio TIMESTAMP DEFAULT now(),
    fecha_fin TIMESTAMP,
    estado TEXT DEFAULT 'activa'
);

-- Tabla de mensajes
CREATE TABLE IF NOT EXISTS mensaje (
    id SERIAL PRIMARY KEY,
    id_sesion INTEGER REFERENCES sesion_chat(id),
    autor TEXT CHECK (autor IN ('USUARIO', 'BOT', 'HUMANO')),
    texto TEXT NOT NULL,
    enviado_en TIMESTAMP DEFAULT now()
);

-- Tabla de tickets
CREATE TABLE IF NOT EXISTS ticket (
    id SERIAL PRIMARY KEY,
    id_sesion INTEGER REFERENCES sesion_chat(id),
    estado TEXT CHECK (estado IN ('ABIERTO', 'ESCALADO', 'RESUELTO')) DEFAULT 'ABIERTO',
    prioridad TEXT,
    fecha_creacion TIMESTAMP DEFAULT now(),
    fecha_cierre TIMESTAMP
);

-- Tabla de agentes humanos
CREATE TABLE IF NOT EXISTS humano (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    rol TEXT
);

-- Tabla de handoff (escalamientos a humanos)
CREATE TABLE IF NOT EXISTS handoff (
    id SERIAL PRIMARY KEY,
    id_ticket INTEGER REFERENCES ticket(id),
    id_humano INTEGER REFERENCES humano(id),
    resumen_solucion TEXT,
    fecha_asignacion TIMESTAMP DEFAULT now(),
    fecha_resolucion TIMESTAMP
);

-- Tabla de documentos base de conocimiento
CREATE TABLE IF NOT EXISTS documento_kb (
    id SERIAL PRIMARY KEY,
    titulo TEXT NOT NULL,
    texto TEXT NOT NULL,
    creado_en TIMESTAMP DEFAULT now()
);

-- Tabla de embeddings vectoriales
CREATE TABLE IF NOT EXISTS embedding (
    id SERIAL PRIMARY KEY,
    id_documento INTEGER REFERENCES documento_kb(id),
    vector VECTOR(768),
    metadata JSONB,
    actualizado_en TIMESTAMP DEFAULT now()
);