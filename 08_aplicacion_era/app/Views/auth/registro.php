<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Crear cuenta - eRa</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
    >

    <style>
        body {
            background-color: #f5f7fb;
        }

        .registro-card {
            max-width: 500px;
            margin: 50px auto;
            border: none;
            border-radius: 20px;
        }

        .logo-era {
            width: 50px;
            height: 50px;
            background-color: #0d6efd;
            color: white;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin: auto;
        }
    </style>
</head>

<body>

<div class="container">

    <div class="card registro-card shadow">

        <div class="card-body p-4">

            <div class="logo-era mb-3">
                eRa
            </div>

            <h2 class="text-center fw-bold">
                Crear cuenta
            </h2>

            <p class="text-center text-muted mb-4">
                Únete a la comunidad de eRa
            </p>

            <?php if (session()->getFlashdata('error')): ?>
                <div class="alert alert-danger">
                    <?= esc(session()->getFlashdata('error')) ?>
                </div>
            <?php endif; ?>

            <?php if ($errores = session()->getFlashdata('errores')): ?>
                <div class="alert alert-danger">
                    <strong>Revisa la información:</strong>
                    <ul class="mb-0 mt-2">
                        <?php foreach ($errores as $error): ?>
                            <li><?= esc($error) ?></li>
                        <?php endforeach; ?>
                    </ul>
                </div>
            <?php endif; ?>

            <form action="<?= base_url('registro') ?>" method="POST">

                <?= csrf_field() ?>

                <div class="mb-3">
                    <label class="form-label">
                        Nombre
                    </label>

                    <input
                        type="text"
                        name="nombre"
                        class="form-control"
                        value="<?= esc(old('nombre')) ?>"
                        required
                    >
                </div>

                <div class="mb-3">
                    <label class="form-label">
                        Apellido
                    </label>

                    <input
                        type="text"
                        name="apellido"
                        class="form-control"
                        value="<?= esc(old('apellido')) ?>"
                        required
                    >
                </div>

                <div class="mb-3">
                    <label class="form-label">
                        Correo electrónico
                    </label>

                    <input
                        type="email"
                        name="correo"
                        class="form-control"
                        placeholder="tu@email.com"
                        value="<?= esc(old('correo')) ?>"
                        required
                    >
                </div>

                <div class="mb-3">
                    <label class="form-label">
                        Contraseña
                    </label>

                    <input
                        type="password"
                        name="contrasena"
                        class="form-control"
                        minlength="8"
                        placeholder="Mínimo 8 caracteres"
                        required
                    >
                </div>

                <div class="mb-3">
                    <label class="form-label">
                        Confirmar contraseña
                    </label>

                    <input
                        type="password"
                        name="confirmar_contrasena"
                        class="form-control"
                        minlength="8"
                        placeholder="Repite tu contraseña"
                        required
                    >
                </div>

                <div class="mb-3">
                    <label class="form-label">
                        Tipo de usuario
                    </label>

                    <select
                        name="id_rol"
                        class="form-select"
                        required
                    >

                        <option value="">
                            Selecciona una opción
                        </option>

                        <option value="2" <?= old('id_rol') === '2' ? 'selected' : '' ?>>
                            Estudiante
                        </option>

                        <option value="3" <?= old('id_rol') === '3' ? 'selected' : '' ?>>
                            Tutor
                        </option>

                    </select>
                </div>

                <div class="form-check mb-4">

                    <input
                        class="form-check-input"
                        type="checkbox"
                        id="terminos"
                        required
                    >

                    <label
                        class="form-check-label"
                        for="terminos"
                    >
                        Acepto los términos y condiciones
                        y la política de privacidad.
                    </label>

                </div>

                <button
                    type="submit"
                    class="btn btn-primary w-100 py-2"
                >
                    Crear cuenta
                </button>

            </form>

            <p class="text-center mt-4 mb-0">

                ¿Ya tienes cuenta?

                <a href="<?= base_url('login') ?>">
                    Inicia sesión aquí
                </a>

            </p>

        </div>

    </div>

</div>

</body>
</html>
