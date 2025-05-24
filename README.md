# 📦 chat_ia_db

**Base de datos del proyecto Chat IA con soporte humano escalable**

Este repositorio contiene la estructura y scripts necesarios para desplegar una base de datos PostgreSQL utilizada por un sistema de chat inteligente basado en RAG (Retrieval-Augmented Generation), con opción de escalamiento a operadores humanos.

---

## 📐 Estructura del proyecto

```plaintext
chat_ia_db/
│
├── schema/                        # Scripts de estructura inicial
│   ├── 001_create_tables.sql
│   ├── 002_create_indexes.sql
│   └── 003_insert_initial_data.sql
│
├── migrations/                    # Migraciones futuras (manuales o con herramienta)
│   └── README.md
│
├── init.sh                        # Script automatizado para crear toda la base
├── .env.example                   # Plantilla de conexión (solo para entornos externos)
├── .gitignore
└── README.md
```

---

## 🚀 Requisitos

- Ubuntu Server o WSL con Ubuntu
- PostgreSQL 16 o superior
- Extensión pgvector activa

**Instalar pgvector en PostgreSQL 16:**
- bash
```plaintext
sudo apt install postgresql-16-pgvector
```
**Activar la extensión:**
- sql
```plaintext
CREATE EXTENSION IF NOT EXISTS vector;
```

---

## ⚙️ Instalación y uso

**1. Clonar el repositorio**
- bash
```plaintext
git clone https://github.com/TU_USUARIO/chat_ia_db.git
cd chat_ia_db
```
**2. Ejecutar el script principal**
- bash
```plaintext
chmod +x init.sh
./init.sh
```
**Este script:**
- Crea la base de datos chat_ia si no existe
- Activa la extensión pgvector
- Ejecuta todos los scripts SQL (estructura, índices y datos de prueba)


---

## 🧩 Componentes clave del modelo de datos

```plaintext
| Tabla          | Propósito                                                      |
| -------------- | -------------------------------------------------------------- |
| `usuario`      | Registra a los clientes por número de teléfono                 |
| `sesion_chat`  | Agrupa las conversaciones por sesión y canal                   |
| `mensaje`      | Guarda cada mensaje del diálogo (usuario, bot, humano)         |
| `ticket`       | Representa un incidente o consulta escalada                    |
| `handoff`      | Relaciona un ticket con un humano que lo atiende               |
| `humano`       | Agentes humanos registrados en el sistema                      |
| `documento_kb` | Documentos de conocimiento (manuales, tickets resueltos, etc.) |
| `embedding`    | Vectores semánticos generados con `pgvector`                   |
```

---

## 🧪 Comandos útiles para desarrolladores

**Entrar a PostgreSQL como superusuario:**
- bash
```plaintext
sudo -u postgres psql
```
**Conectarse a la base chat_ia:**
- sql
```plaintext
\c chat_ia
\dt               -- Ver todas las tablas
\d nombre_tabla   -- Ver estructura de una tabla
SELECT * FROM usuario;  -- Consultar datos
```

---

## 🧠 Extra: vector DB y RAG

```plaintext
Este proyecto integra una base vectorial usando pgvector para búsquedas semánticas con RAG (Retrieval-Augmented Generation).
Los embeddings pueden ser generados localmente con modelos como bge-base-en-v1.5 y consultados por similitud usando operadores como <=>.
```

