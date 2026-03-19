PRAGMA foreign_keys = ON;

-- =========================================
-- ELIMINAR TABLAS SI YA EXISTEN
-- =========================================
DROP TABLE IF EXISTS mensajes_contacto;
DROP TABLE IF EXISTS valores;
DROP TABLE IF EXISTS nosotros;
DROP TABLE IF EXISTS curso_caracteristicas;
DROP TABLE IF EXISTS cursos;
DROP TABLE IF EXISTS estadisticas;
DROP TABLE IF EXISTS hero;
DROP TABLE IF EXISTS configuracion_sitio;

-- =========================================
-- 1. CONFIGURACIÓN GENERAL DEL SITIO
-- =========================================
CREATE TABLE configuracion_sitio (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_sitio TEXT NOT NULL,
    tagline TEXT,
    footer_texto TEXT,
    email_contacto TEXT,
    telefono_contacto TEXT,
    direccion_contacto TEXT
);

-- =========================================
-- 2. HERO PRINCIPAL
-- =========================================
CREATE TABLE hero (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    descripcion TEXT,
    boton_1_texto TEXT,
    boton_1_url TEXT,
    boton_2_texto TEXT,
    boton_2_url TEXT,
    imagen TEXT,
    mensaje_superior TEXT
);

-- =========================================
-- 3. ESTADÍSTICAS / MÉTRICAS
-- =========================================
CREATE TABLE estadisticas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    valor TEXT NOT NULL,
    orden INTEGER DEFAULT 1
);

-- =========================================
-- 4. CURSOS / SERVICIOS
-- =========================================
CREATE TABLE cursos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    descripcion TEXT,
    imagen TEXT,
    estado INTEGER DEFAULT 1,
    orden INTEGER DEFAULT 1
);

-- =========================================
-- 5. CARACTERÍSTICAS DE CADA CURSO
-- =========================================
CREATE TABLE curso_caracteristicas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    curso_id INTEGER NOT NULL,
    caracteristica TEXT NOT NULL,
    orden INTEGER DEFAULT 1,
    FOREIGN KEY (curso_id) REFERENCES cursos(id) ON DELETE CASCADE
);

-- =========================================
-- 6. SECCIÓN NOSOTROS
-- =========================================
CREATE TABLE nosotros (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    descripcion_1 TEXT,
    descripcion_2 TEXT,
    subtitulo TEXT,
    resumen TEXT,
    imagen TEXT
);

-- =========================================
-- 7. VALORES / PALABRAS CLAVE
-- =========================================
CREATE TABLE valores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    orden INTEGER DEFAULT 1
);

-- =========================================
-- 8. MENSAJES DEL FORMULARIO DE CONTACTO
-- =========================================
CREATE TABLE mensajes_contacto (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    email TEXT NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    leido INTEGER DEFAULT 0
);

-- =========================================
-- INSERTS INICIALES
-- =========================================

-- CONFIGURACIÓN GENERAL
INSERT INTO configuracion_sitio (
    nombre_sitio,
    tagline,
    footer_texto,
    email_contacto,
    telefono_contacto,
    direccion_contacto
) VALUES (
    'RitmoPro',
    'Tu escuela de música online',
    '© 2026 RitmoPro. Todos los derechos reservados.',
    'contacto@ritmopro.com',
    '+591 70000000',
    'La Paz, Bolivia'
);

-- HERO
INSERT INTO hero (
    titulo,
    descripcion,
    boton_1_texto,
    boton_1_url,
    boton_2_texto,
    boton_2_url,
    imagen,
    mensaje_superior
) VALUES (
    'Descubre tu ritmo con RitmoPro',
    'Aprende, practica y crea tu música con nuestras herramientas y tutoriales.',
    'Ver cursos',
    '#cursos',
    'Explorar comunidad',
    '#nosotros',
    'imagenes/hero-music.png',
    'Amplia variedad de géneros • Tutoriales profesionales • Comunidad creativa'
);

-- ESTADÍSTICAS
INSERT INTO estadisticas (nombre, valor, orden) VALUES
('Cursos', '50+', 1),
('Profesores', '100+', 2),
('Anuncios', '0', 3);

-- CURSOS
INSERT INTO cursos (titulo, descripcion, imagen, estado, orden) VALUES
(
    'Clases en vivo',
    'Aprende con profesores expertos en sesiones interactivas.',
    'imagenes/curso1.png',
    1,
    1
),
(
    'Producción musical',
    'Domina el software profesional y crea tus canciones.',
    'imagenes/curso2.png',
    1,
    2
),
(
    'Comunidades y eventos',
    'Conecta con otros músicos y participa en eventos en vivo.',
    'imagenes/curso3.png',
    1,
    3
);

-- CARACTERÍSTICAS DE CURSOS
INSERT INTO curso_caracteristicas (curso_id, caracteristica, orden) VALUES
(1, 'Instrumentos variados', 1),
(1, 'Feedback en tiempo real', 2),
(1, 'Horarios flexibles', 3),

(2, 'Software de estudio', 1),
(2, 'Mezcla y masterización', 2),
(2, 'Herramientas creativas', 3),

(3, 'Foros activos', 1),
(3, 'Eventos online', 2),
(3, 'Colaboraciones', 3);

-- NOSOTROS
INSERT INTO nosotros (
    titulo,
    descripcion_1,
    descripcion_2,
    subtitulo,
    resumen,
    imagen
) VALUES (
    'Nosotros',
    'RitmoPro nace del amor por la música. Nuestro equipo está formado por músicos y profesionales de la tecnología dedicados a compartir conocimiento y construir comunidad.',
    'Nuestro objetivo es democratizar el aprendizaje musical a través de cursos accesibles y una plataforma colaborativa.',
    'Lo que nos mueve',
    'Pasión, creatividad y comunidad.',
    'imagenes/nosotros.png'
);

-- VALORES
INSERT INTO valores (nombre, orden) VALUES
('Creatividad', 1),
('Pasión', 2),
('Comunidad', 3),
('Tecnología', 4);

-- MENSAJES DE EJEMPLO
INSERT INTO mensajes_contacto (nombre, email, mensaje, leido) VALUES
('Juan Pérez', 'juan@email.com', 'Hola, quisiera más información sobre los cursos de música en vivo.', 0),
('María López', 'maria@email.com', 'Me interesa aprender producción musical. ¿Tienen horarios flexibles?', 0);