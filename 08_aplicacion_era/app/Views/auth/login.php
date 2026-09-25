<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Iniciar sesión - eRa</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
    >

    <style>
        body {
            background-color: #f5f7fb;
        }

        .login-card {
            max-width: 450px;
            margin: 80px auto;
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

    <div class="card login-card shadow">

        <div class="card-body p-4">

            <div class="logo-era mb-3">
                eRa
            </div>

            <h2 class="text-center fw-bold">
                Iniciar sesión
            </h2>

            <p class="text-center text-muted mb-4">
                Ingresa a tu cuenta de eRa
            </p>

            <?php if (session()->getFlashdata('exito')): ?>
                <div class="alert alert-success">
                    <?= esc(session()->getFlashdata('exito')) ?>
                </div>
            <?php endif; ?>

            <?php if (session()->getFlashdata('error')): ?>
                <div class="alert alert-danger">
                    <?= esc(session()->getFlashdata('error')) ?>
                </div>
            <?php endif; ?>

            <form action="<?= base_url('login') ?>" method="POST">

                <?= csrf_field() ?>

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

                <div class="mb-4">

                    <label class="form-label">
                        Contraseña
                    </label>

                    <input
                        type="password"
                        name="contrasena"
                        class="form-control"
                        placeholder="Ingresa tu contraseña"
                        required
                    >

                </div>

                <button
                    type="submit"
                    class="btn btn-primary w-100 py-2"
                >
                    Iniciar sesión
                </button>

            </form>

            <p class="text-center mt-4 mb-0">

                ¿No tienes una cuenta?

                <a href="<?= base_url('registro') ?>">
                    Regístrate aquí
                </a>

            </p>

        </div>

    </div>

</div>

</body>
</html>
