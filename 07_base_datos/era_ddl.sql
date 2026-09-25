-- =====================================================
-- BASE DE DATOS DEL PROYECTO eRa
-- Plataforma de Refuerzo Educativo
-- =====================================================

DROP DATABASE IF EXISTS era_db;

CREATE DATABASE era_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE era_db;

-- =====================================================
-- TABLA ESTADO
-- =====================================================

CREATE TABLE estado (
    id_estado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150),
    tipo_estado VARCHAR(50) NOT NULL,

    CONSTRAINT uk_estado_nombre_tipo
        UNIQUE (nombre, tipo_estado)
) ENGINE=InnoDB;

-- =====================================================
-- TABLA ROL
-- =====================================================

CREATE TABLE rol (
    id_rol INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(150)
) ENGINE=InnoDB;

-- =====================================================
-- TABLA USUARIO
-- =====================================================

CREATE TABLE usuario (
    id_usuario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    correo VARCHAR(120) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_rol INT UNSIGNED NOT NULL,
    id_estado INT UNSIGNED NOT NULL,

    CONSTRAINT fk_usuario_rol
        FOREIGN KEY (id_rol)
        REFERENCES rol(id_rol)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_usuario_estado
        FOREIGN KEY (id_estado)
        REFERENCES estado(id_estado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_usuario_rol (id_rol),
    INDEX idx_usuario_estado (id_estado)
) ENGINE=InnoDB;

-- =====================================================
-- TABLA ESTUDIANTE
-- =====================================================

CREATE TABLE estudiante (
    id_estudiante INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNSIGNED NOT NULL UNIQUE,

    CONSTRAINT fk_estudiante_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- TABLA TUTOR
-- =====================================================

CREATE TABLE tutor (
    id_tutor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT,
    experiencia INT UNSIGNED DEFAULT 0,
    tarifa_hora DECIMAL(10,2) NOT NULL DEFAULT 0,
    especialidad VARCHAR(150),
    formacion VARCHAR(255),
    nivel_experiencia VARCHAR(50),
    tiempo_respuesta_estimado INT UNSIGNED DEFAULT NULL,
    id_usuario INT UNSIGNED NOT NULL UNIQUE,

    CONSTRAINT fk_tutor_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- TABLA POSTULACION_TUTOR
-- =====================================================

CREATE TABLE postulacion_tutor (
    id_postulacion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha_solicitud DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    documentos TEXT,
    contrato_aceptado TINYINT(1) NOT NULL DEFAULT 0,
    experiencia_acreditada TINYINT(1) NOT NULL DEFAULT 0,
    certificaciones TEXT,
    observacion TEXT,
    id_tutor INT UNSIGNED NOT NULL,
    id_estado INT UNSIGNED NOT NULL,

    CONSTRAINT fk_postulacion_tutor
        FOREIGN KEY (id_tutor)
        REFERENCES tutor(id_tutor)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_postulacion_estado
        FOREIGN KEY (id_estado)
        REFERENCES estado(id_estado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_postulacion_estado (id_estado)
) ENGINE=InnoDB;

-- =====================================================
-- TABLA DISPONIBILIDAD
-- =====================================================

CREATE TABLE disponibilidad (
    id_disponibilidad INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha_disponibilidad DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    id_tutor INT UNSIGNED NOT NULL,
    id_estado INT UNSIGNED NOT NULL,

    CONSTRAINT uk_disponibilidad
        UNIQUE (
            id_tutor,
            fecha_disponibilidad,
            hora_inicio,
            hora_fin
        ),

    CONSTRAINT fk_disponibilidad_tutor
        FOREIGN KEY (id_tutor)
        REFERENCES tutor(id_tutor)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_disponibilidad_estado
        FOREIGN KEY (id_estado)
        REFERENCES estado(id_estado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- =====================================================
-- TABLA CUENTA_BANCARIA
-- =====================================================

CREATE TABLE cuenta_bancaria (
    id_cuenta_bancaria INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    banco VARCHAR(100) NOT NULL,
    tipo_cuenta VARCHAR(30) NOT NULL,
    numero_cuenta VARCHAR(50) NOT NULL UNIQUE,
    titular VARCHAR(160) NOT NULL,
    id_tutor INT UNSIGNED NOT NULL,

    CONSTRAINT fk_cuenta_tutor
        FOREIGN KEY (id_tutor)
        REFERENCES tutor(id_tutor)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- TABLA LENGUAJE
-- =====================================================

CREATE TABLE lenguaje (
    id_lenguaje INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE,
    descripcion TEXT,
    imagen VARCHAR(255),
    id_estado INT UNSIGNED NOT NULL,

    CONSTRAINT fk_lenguaje_estado
        FOREIGN KEY (id_estado)
        REFERENCES estado(id_estado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- =====================================================
-- TABLA TEMA
-- =====================================================

CREATE TABLE tema (
    id_tema INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_lenguaje INT UNSIGNED NOT NULL,
    nombre VARCHAR(120) NOT NULL,
    descripcion TEXT,
    id_tutor INT UNSIGNED DEFAULT NULL,

    CONSTRAINT uk_tema_lenguaje
        UNIQUE (id_lenguaje, nombre),

    CONSTRAINT fk_tema_lenguaje
        FOREIGN KEY (id_lenguaje)
        REFERENCES lenguaje(id_lenguaje)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_tema_tutor
        FOREIGN KEY (id_tutor)
        REFERENCES tutor(id_tutor)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) ENGINE=InnoDB;

-- =====================================================
-- TABLA ESTUDIANTE_LENGUAJE
-- =====================================================

CREATE TABLE estudiante_lenguaje (
    id_estudiante_lenguaje INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT UNSIGNED NOT NULL,
    id_lenguaje INT UNSIGNED NOT NULL,
    porcentaje_progreso DECIMAL(5,2) NOT NULL DEFAULT 0,

    CONSTRAINT uk_estudiante_lenguaje
        UNIQUE (id_estudiante, id_lenguaje),

    CONSTRAINT fk_estudiante_lenguaje_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiante(id_estudiante)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_estudiante_lenguaje_lenguaje
        FOREIGN KEY (id_lenguaje)
        REFERENCES lenguaje(id_lenguaje)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- TABLA TUTOR_TEMA
-- =====================================================

CREATE TABLE tutor_tema (
    id_tutor_tema INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_tutor INT UNSIGNED NOT NULL,
    id_tema INT UNSIGNED NOT NULL,

    CONSTRAINT uk_tutor_tema
        UNIQUE (id_tutor, id_tema),

    CONSTRAINT fk_tutor_tema_tutor
        FOREIGN KEY (id_tutor)
        REFERENCES tutor(id_tutor)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_tutor_tema_tema
        FOREIGN KEY (id_tema)
        REFERENCES tema(id_tema)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- TABLA TUTOR_LENGUAJE
-- =====================================================

CREATE TABLE tutor_lenguaje (
    id_tutor_lenguaje INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_tutor INT UNSIGNED NOT NULL,
    id_lenguaje INT UNSIGNED NOT NULL,

    CONSTRAINT uk_tutor_lenguaje
        UNIQUE (id_tutor, id_lenguaje),

    CONSTRAINT fk_tutor_lenguaje_tutor
        FOREIGN KEY (id_tutor)
        REFERENCES tutor(id_tutor)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_tutor_lenguaje_lenguaje
        FOREIGN KEY (id_lenguaje)
        REFERENCES lenguaje(id_lenguaje)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- TABLA SESION_TUTORIA
-- =====================================================

CREATE TABLE sesion_tutoria (
    id_sesion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    duracion SMALLINT UNSIGNED NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    enlace_videollamada VARCHAR(255),
    id_estudiante INT UNSIGNED NOT NULL,
    id_tutor INT UNSIGNED NOT NULL,
    id_tema INT UNSIGNED NOT NULL,
    id_estado INT UNSIGNED NOT NULL,

    CONSTRAINT fk_sesion_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiante(id_estudiante)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_sesion_tutor
        FOREIGN KEY (id_tutor)
        REFERENCES tutor(id_tutor)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_sesion_tema
        FOREIGN KEY (id_tema)
        REFERENCES tema(id_tema)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_sesion_estado
        FOREIGN KEY (id_estado)
        REFERENCES estado(id_estado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_sesion_fecha (fecha, hora),
    INDEX idx_sesion_estudiante (id_estudiante),
    INDEX idx_sesion_tutor (id_tutor)
) ENGINE=InnoDB;

-- =====================================================
-- TABLA GRABACION
-- =====================================================

CREATE TABLE grabacion (
    id_grabacion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    url_grabacion VARCHAR(255) NOT NULL,
    fecha_disponible DATETIME NOT NULL,
    fecha_expiracion DATETIME DEFAULT NULL,
    duracion INT UNSIGNED DEFAULT NULL,
    id_sesion INT UNSIGNED NOT NULL UNIQUE,

    CONSTRAINT fk_grabacion_sesion
        FOREIGN KEY (id_sesion)
        REFERENCES sesion_tutoria(id_sesion)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- TABLA RESENA
-- =====================================================

CREATE TABLE resena (
    id_resena INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    calificacion TINYINT UNSIGNED NOT NULL,
    comentario TEXT,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_sesion INT UNSIGNED NOT NULL UNIQUE,

    CONSTRAINT fk_resena_sesion
        FOREIGN KEY (id_sesion)
        REFERENCES sesion_tutoria(id_sesion)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- =====================================================
-- TABLA NOTIFICACION
-- =====================================================

CREATE TABLE notificacion (
    id_notificacion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    mensaje TEXT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    envio TINYINT(1) NOT NULL DEFAULT 0,
    tipo VARCHAR(50) NOT NULL,
    id_usuario INT UNSIGNED NOT NULL,

    CONSTRAINT fk_notificacion_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    INDEX idx_notificacion_usuario (id_usuario, envio)
) ENGINE=InnoDB;

-- =====================================================
-- TABLA FORO
-- =====================================================

CREATE TABLE foro (
    id_foro INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(180) NOT NULL,
    contenido TEXT NOT NULL,
    tipo_publicacion VARCHAR(50) NOT NULL,
    fecha_publicacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    mejor_respuesta TEXT,
    id_lenguaje INT UNSIGNED NOT NULL,
    id_usuario INT UNSIGNED NOT NULL,
    id_estado INT UNSIGNED NOT NULL,

    CONSTRAINT fk_foro_lenguaje
        FOREIGN KEY (id_lenguaje)
        REFERENCES lenguaje(id_lenguaje)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_foro_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_foro_estado
        FOREIGN KEY (id_estado)
        REFERENCES estado(id_estado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_foro_lenguaje (id_lenguaje),
    INDEX idx_foro_estado (id_estado)
) ENGINE=InnoDB;

-- =====================================================
-- TABLA TRANSACCION
-- =====================================================

CREATE TABLE transaccion (
    id_transaccion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo_transaccion VARCHAR(50) NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_transaccion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    medio_transaccion VARCHAR(50) NOT NULL,
    referencia_transaccion VARCHAR(120) NOT NULL UNIQUE,
    fecha_procesamiento DATETIME DEFAULT NULL,
    id_usuario INT UNSIGNED NOT NULL,
    id_estado INT UNSIGNED NOT NULL,
    id_sesion INT UNSIGNED DEFAULT NULL,
    id_cuenta_bancaria INT UNSIGNED DEFAULT NULL,

    CONSTRAINT fk_transaccion_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_transaccion_estado
        FOREIGN KEY (id_estado)
        REFERENCES estado(id_estado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_transaccion_sesion
        FOREIGN KEY (id_sesion)
        REFERENCES sesion_tutoria(id_sesion)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT fk_transaccion_cuenta
        FOREIGN KEY (id_cuenta_bancaria)
        REFERENCES cuenta_bancaria(id_cuenta_bancaria)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    INDEX idx_transaccion_fecha (fecha_transaccion),
    INDEX idx_transaccion_usuario (id_usuario)
) ENGINE=InnoDB;

-- =====================================================
-- COMPROBACIÓN FINAL
-- =====================================================

SHOW TABLES;

SELECT COUNT(*) AS total_tablas
FROM information_schema.tables
WHERE table_schema = 'era_db';