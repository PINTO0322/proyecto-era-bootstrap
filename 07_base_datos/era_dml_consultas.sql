USE era_db;

START TRANSACTION;

-- Datos de prueba

INSERT INTO estado
(id_estado, nombre, descripcion, tipo_estado)
VALUES
(1, 'Activo', 'Usuario habilitado', 'usuario'),
(2, 'Inactivo', 'Usuario deshabilitado', 'usuario'),
(3, 'Suspendido', 'Usuario suspendido', 'usuario'),
(4, 'Activo', 'Lenguaje disponible', 'lenguaje'),
(5, 'Inactivo', 'Lenguaje no disponible', 'lenguaje'),
(6, 'Pendiente', 'Postulación pendiente', 'postulacion'),
(7, 'Aprobada', 'Postulación aprobada', 'postulacion'),
(8, 'Rechazada', 'Postulación rechazada', 'postulacion'),
(9, 'Disponible', 'Horario disponible', 'disponibilidad'),
(10, 'Reservada', 'Disponibilidad reservada', 'disponibilidad'),
(11, 'No disponible', 'Horario no disponible', 'disponibilidad'),
(12, 'Solicitada', 'Sesión solicitada', 'sesion'),
(13, 'Confirmada', 'Sesión confirmada', 'sesion'),
(14, 'Finalizada', 'Sesión finalizada', 'sesion'),
(15, 'Cancelada', 'Sesión cancelada', 'sesion'),
(16, 'Abierto', 'Foro abierto', 'foro'),
(17, 'Resuelto', 'Foro resuelto', 'foro'),
(18, 'Cerrado', 'Foro cerrado', 'foro'),
(19, 'Pendiente', 'Transacción pendiente', 'transaccion'),
(20, 'Aprobada', 'Transacción aprobada', 'transaccion'),
(21, 'Rechazada', 'Transacción rechazada', 'transaccion'),
(22, 'Reembolsada', 'Transacción reembolsada', 'transaccion');

INSERT INTO rol
(id_rol, nombre_rol, descripcion)
VALUES
(1, 'Visitante', 'Usuario que consulta la plataforma'),
(2, 'Estudiante', 'Usuario que solicita tutorías'),
(3, 'Tutor', 'Usuario que ofrece tutorías'),
(4, 'Moderador', 'Usuario que modera la plataforma'),
(5, 'Administrador', 'Usuario que administra el sistema');

INSERT INTO usuario
(
    id_usuario,
    nombre,
    apellido,
    correo,
    contrasena,
    id_rol,
    id_estado
)
VALUES
(
    1,
    'Miguel',
    'Administrador',
    'admin@era.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.',
    5,
    1
),
(
    2,
    'María',
    'Moderadora',
    'moderador@era.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.',
    4,
    1
),
(
    3,
    'Carlos',
    'Mendoza',
    'carlos@era.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.',
    2,
    1
),
(
    4,
    'Laura',
    'Ramírez',
    'laura@era.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.',
    3,
    1
),
(
    5,
    'Diego',
    'Martínez',
    'diego@era.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.',
    3,
    1
),
(
    6,
    'Ana',
    'López',
    'ana@era.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.',
    2,
    1
),
(
    7,
    'Pedro',
    'Visitante',
    'visitante@era.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.',
    1,
    1
),
(
    8,
    'Sofía',
    'Torres',
    'sofia@era.com',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.',
    2,
    1
);

INSERT INTO estudiante
(id_estudiante, id_usuario)
VALUES
(1, 3),
(2, 6),
(3, 8);

INSERT INTO tutor
(
    id_tutor,
    descripcion,
    experiencia,
    tarifa_hora,
    especialidad,
    formacion,
    nivel_experiencia,
    tiempo_respuesta_estimado,
    id_usuario
)
VALUES
(
    1,
    'Tutora de programación y desarrollo web',
    5,
    40000,
    'Desarrollo web',
    'Ingeniera de Sistemas',
    'Avanzado',
    15,
    4
),
(
    2,
    'Tutor de bases de datos y backend',
    7,
    50000,
    'Bases de datos',
    'Ingeniero de Software',
    'Experto',
    20,
    5
);

INSERT INTO postulacion_tutor
(
    id_postulacion,
    fecha_solicitud,
    documentos,
    contrato_aceptado,
    experiencia_acreditada,
    certificaciones,
    observacion,
    id_tutor,
    id_estado
)
VALUES
(
    1,
    '2026-08-20 10:00:00',
    'hoja_vida_laura.pdf',
    1,
    1,
    'certificados_laura.pdf',
    'Documentación verificada',
    1,
    7
),
(
    2,
    '2026-08-21 11:00:00',
    'hoja_vida_diego.pdf',
    1,
    1,
    'certificados_diego.pdf',
    'Documentación verificada',
    2,
    7
);

INSERT INTO disponibilidad
(
    id_disponibilidad,
    fecha_disponibilidad,
    hora_inicio,
    hora_fin,
    id_tutor,
    id_estado
)
VALUES
(1, '2026-09-18', '08:00:00', '12:00:00', 1, 9),
(2, '2026-09-20', '14:00:00', '18:00:00', 1, 9),
(3, '2026-09-19', '09:00:00', '13:00:00', 2, 9),
(4, '2026-09-21', '14:00:00', '18:00:00', 2, 9);

INSERT INTO cuenta_bancaria
(
    id_cuenta_bancaria,
    banco,
    tipo_cuenta,
    numero_cuenta,
    titular,
    id_tutor
)
VALUES
(1, 'Bancolombia', 'Ahorros', '0001002001', 'Laura Ramírez', 1),
(2, 'Davivienda', 'Ahorros', '0001002002', 'Diego Martínez', 2);

INSERT INTO lenguaje
(id_lenguaje, nombre, descripcion, imagen, id_estado)
VALUES
(1, 'Python', 'Programación con Python', 'python.png', 4),
(2, 'JavaScript', 'Programación con JavaScript', 'javascript.png', 4),
(3, 'Java', 'Programación con Java', 'java.png', 4),
(4, 'C++', 'Programación con C++', 'cpp.png', 4),
(5, 'SQL', 'Bases de datos y consultas SQL', 'sql.png', 4),
(6, 'React', 'Desarrollo de interfaces con React', 'react.png', 4),
(7, 'HTML y CSS', 'Desarrollo de páginas web', 'html-css.png', 4),
(8, 'Node.js', 'Desarrollo backend con Node.js', 'nodejs.png', 4),
(9, 'PHP', 'Desarrollo web con PHP', 'php.png', 4),
(10, 'C#', 'Programación con C#', 'csharp.png', 4);

INSERT INTO tema
(id_tema, id_lenguaje, nombre, descripcion, id_tutor)
VALUES
(1, 1, 'Variables y tipos de datos', 'Fundamentos de Python', 1),
(2, 1, 'Ciclos y condicionales', 'Estructuras de control', 1),
(3, 2, 'Fundamentos de JavaScript', 'Sintaxis básica', 1),
(4, 2, 'Manipulación del DOM', 'Uso del DOM', 1),
(5, 5, 'Modelo relacional', 'Tablas, claves y relaciones', 2),
(6, 5, 'Consultas con JOIN', 'Unión de tablas', 2),
(7, 6, 'Componentes de React', 'Creación de componentes', 1),
(8, 7, 'Formularios HTML', 'Formularios y validaciones', 1),
(9, 9, 'Formularios con PHP', 'Procesamiento mediante PHP', 2),
(10, 8, 'API con Node.js', 'Creación de una API', 2);

INSERT INTO estudiante_lenguaje
(
    id_estudiante_lenguaje,
    id_estudiante,
    id_lenguaje,
    porcentaje_progreso
)
VALUES
(1, 1, 1, 75),
(2, 1, 5, 100),
(3, 2, 2, 100),
(4, 3, 7, 25),
(5, 3, 6, 10);

INSERT INTO tutor_tema
(id_tutor_tema, id_tutor, id_tema)
VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 7),
(6, 1, 8),
(7, 2, 5),
(8, 2, 6),
(9, 2, 9),
(10, 2, 10);

INSERT INTO tutor_lenguaje
(id_tutor_lenguaje, id_tutor, id_lenguaje)
VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 6),
(4, 1, 7),
(5, 2, 5),
(6, 2, 8),
(7, 2, 9);

INSERT INTO sesion_tutoria
(
    id_sesion,
    fecha,
    hora,
    duracion,
    precio,
    enlace_videollamada,
    id_estudiante,
    id_tutor,
    id_tema,
    id_estado
)
VALUES
(
    1,
    '2026-09-18',
    '08:00:00',
    60,
    40000,
    'https://meet.example.com/era-001',
    1,
    1,
    1,
    13
),
(
    2,
    '2026-09-10',
    '14:00:00',
    60,
    42000,
    'https://meet.example.com/era-002',
    2,
    1,
    4,
    14
),
(
    3,
    '2026-09-11',
    '14:00:00',
    60,
    50000,
    'https://meet.example.com/era-003',
    1,
    2,
    6,
    14
);

INSERT INTO grabacion
(
    id_grabacion,
    url_grabacion,
    fecha_disponible,
    fecha_expiracion,
    duracion,
    id_sesion
)
VALUES
(
    1,
    'grabaciones/sesion_002.mp4',
    '2026-09-10 15:10:00',
    '2026-10-10 15:10:00',
    3500,
    2
),
(
    2,
    'grabaciones/sesion_003.mp4',
    '2026-09-11 15:10:00',
    '2026-10-11 15:10:00',
    3600,
    3
);

INSERT INTO resena
(id_resena, calificacion, comentario, fecha, id_sesion)
VALUES
(1, 5, 'La explicación fue clara y práctica.', '2026-09-10 16:00:00', 2),
(2, 4, 'Buena tutoría sobre consultas SQL.', '2026-09-11 16:00:00', 3);

INSERT INTO notificacion
(id_notificacion, mensaje, fecha, envio, tipo, id_usuario)
VALUES
(
    1,
    'Tu sesión de Python fue confirmada.',
    '2026-09-14 10:00:00',
    1,
    'Sesión',
    3
),
(
    2,
    'Tienes una nueva sesión programada.',
    '2026-09-14 10:05:00',
    1,
    'Tutoría',
    4
),
(
    3,
    'Completaste el tema Manipulación del DOM.',
    '2026-09-10 16:10:00',
    1,
    'Progreso',
    6
);

INSERT INTO foro
(
    id_foro,
    titulo,
    contenido,
    tipo_publicacion,
    fecha_publicacion,
    mejor_respuesta,
    id_lenguaje,
    id_usuario,
    id_estado
)
VALUES
(
    1,
    '¿Cómo funciona un ciclo for?',
    'Necesito recorrer una lista de números.',
    'Pregunta',
    '2026-09-09 09:00:00',
    'Puedes utilizar for elemento in lista.',
    1,
    3,
    17
),
(
    2,
    '¿Cómo seleccionar un elemento del DOM?',
    'No entiendo cómo utilizar querySelector.',
    'Pregunta',
    '2026-09-10 11:00:00',
    NULL,
    2,
    6,
    16
);

INSERT INTO transaccion
(
    id_transaccion,
    tipo_transaccion,
    monto,
    fecha_transaccion,
    medio_transaccion,
    referencia_transaccion,
    fecha_procesamiento,
    id_usuario,
    id_estado,
    id_sesion,
    id_cuenta_bancaria
)
VALUES
(
    1,
    'Pago de tutoría',
    40000,
    '2026-09-14 09:00:00',
    'PSE',
    'ERA-TRANS-001',
    '2026-09-14 09:01:00',
    3,
    20,
    1,
    1
),
(
    2,
    'Pago de tutoría',
    42000,
    '2026-09-10 13:30:00',
    'Tarjeta',
    'ERA-TRANS-002',
    '2026-09-10 13:31:00',
    6,
    20,
    2,
    1
),
(
    3,
    'Pago de tutoría',
    50000,
    '2026-09-11 13:20:00',
    'Transferencia',
    'ERA-TRANS-003',
    '2026-09-11 13:21:00',
    3,
    20,
    3,
    2
),
(
    4,
    'Retiro de tutor',
    42000,
    '2026-09-12 10:00:00',
    'Transferencia',
    'ERA-TRANS-004',
    '2026-09-12 10:30:00',
    4,
    20,
    NULL,
    1
);

INSERT INTO notificacion
(id_notificacion, mensaje, envio, tipo, id_usuario)
VALUES
(4, 'Notificación temporal', 0, 'Prueba', 1);

UPDATE notificacion
SET mensaje = 'Notificación actualizada'
WHERE id_notificacion = 4;

DELETE FROM notificacion
WHERE id_notificacion = 4;

COMMIT;

-- Consultas

SELECT
    u.id_usuario,
    CONCAT(u.nombre, ' ', u.apellido) AS usuario,
    u.correo,
    r.nombre_rol,
    e.nombre AS estado
FROM usuario AS u
INNER JOIN rol AS r
    ON u.id_rol = r.id_rol
INNER JOIN estado AS e
    ON u.id_estado = e.id_estado
ORDER BY u.id_usuario;

SELECT
    CONCAT(u.nombre, ' ', u.apellido) AS tutor,
    l.nombre AS lenguaje
FROM tutor AS t
INNER JOIN usuario AS u
    ON t.id_usuario = u.id_usuario
INNER JOIN tutor_lenguaje AS tl
    ON t.id_tutor = tl.id_tutor
INNER JOIN lenguaje AS l
    ON tl.id_lenguaje = l.id_lenguaje
ORDER BY tutor, lenguaje;

SELECT
    s.id_sesion,
    CONCAT(ue.nombre, ' ', ue.apellido) AS estudiante,
    CONCAT(ut.nombre, ' ', ut.apellido) AS tutor,
    l.nombre AS lenguaje,
    te.nombre AS tema,
    s.fecha,
    s.hora,
    es.nombre AS estado
FROM sesion_tutoria AS s
INNER JOIN estudiante AS est
    ON s.id_estudiante = est.id_estudiante
INNER JOIN usuario AS ue
    ON est.id_usuario = ue.id_usuario
INNER JOIN tutor AS tut
    ON s.id_tutor = tut.id_tutor
INNER JOIN usuario AS ut
    ON tut.id_usuario = ut.id_usuario
INNER JOIN tema AS te
    ON s.id_tema = te.id_tema
INNER JOIN lenguaje AS l
    ON te.id_lenguaje = l.id_lenguaje
INNER JOIN estado AS es
    ON s.id_estado = es.id_estado
ORDER BY s.fecha, s.hora;

SELECT
    t.id_tutor,
    CONCAT(u.nombre, ' ', u.apellido) AS tutor,
    COUNT(s.id_sesion) AS total_sesiones
FROM tutor AS t
INNER JOIN usuario AS u
    ON t.id_usuario = u.id_usuario
LEFT JOIN sesion_tutoria AS s
    ON t.id_tutor = s.id_tutor
GROUP BY
    t.id_tutor,
    u.nombre,
    u.apellido
ORDER BY total_sesiones DESC;

SELECT
    CONCAT(u.nombre, ' ', u.apellido) AS tutor,
    COUNT(tr.id_transaccion) AS total_transacciones,
    COALESCE(SUM(tr.monto), 0) AS total_recaudado
FROM tutor AS t
INNER JOIN usuario AS u
    ON t.id_usuario = u.id_usuario
LEFT JOIN cuenta_bancaria AS cb
    ON t.id_tutor = cb.id_tutor
LEFT JOIN transaccion AS tr
    ON cb.id_cuenta_bancaria = tr.id_cuenta_bancaria
   AND tr.tipo_transaccion = 'Pago de tutoría'
   AND tr.id_estado = 20
GROUP BY
    t.id_tutor,
    u.nombre,
    u.apellido
ORDER BY total_recaudado DESC;

SELECT
    CONCAT(u.nombre, ' ', u.apellido) AS estudiante,
    l.nombre AS lenguaje,
    el.porcentaje_progreso
FROM estudiante_lenguaje AS el
INNER JOIN estudiante AS e
    ON el.id_estudiante = e.id_estudiante
INNER JOIN usuario AS u
    ON e.id_usuario = u.id_usuario
INNER JOIN lenguaje AS l
    ON el.id_lenguaje = l.id_lenguaje
ORDER BY estudiante, lenguaje;

SELECT
    t.id_tutor,
    CONCAT(u.nombre, ' ', u.apellido) AS tutor,
    t.tarifa_hora
FROM tutor AS t
INNER JOIN usuario AS u
    ON t.id_usuario = u.id_usuario
WHERE t.tarifa_hora > (
    SELECT AVG(tarifa_hora)
    FROM tutor
);

SELECT
    e.id_estudiante,
    CONCAT(u.nombre, ' ', u.apellido) AS estudiante
FROM estudiante AS e
INNER JOIN usuario AS u
    ON e.id_usuario = u.id_usuario
WHERE NOT EXISTS (
    SELECT 1
    FROM sesion_tutoria AS s
    WHERE s.id_estudiante = e.id_estudiante
);

SELECT COUNT(*) AS total_estados
FROM estado;

SELECT COUNT(*) AS total_roles
FROM rol;

SELECT COUNT(*) AS total_usuarios
FROM usuario;

SELECT COUNT(*) AS total_estudiantes
FROM estudiante;

SELECT COUNT(*) AS total_tutores
FROM tutor;

SELECT COUNT(*) AS total_lenguajes
FROM lenguaje;

SELECT COUNT(*) AS total_sesiones
FROM sesion_tutoria;

SELECT COUNT(*) AS total_transacciones
FROM transaccion;