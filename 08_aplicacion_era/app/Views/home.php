<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>eRa - Plataforma de Refuerzo Educativo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="<?= base_url('assets/css/era.css') ?>" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg bg-white border-bottom sticky-top">
    <div class="container py-2">
        <a class="navbar-brand d-flex align-items-center gap-2"
   href="<?= base_url('/') ?>">
    <span class="brand">eRa</span>

    <?php if ($autenticado && (int) session()->get('usuario_rol') === 2): ?>
        <span class="text-dark fw-semibold lh-sm small">
            Centro de<br>Aprendizaje
        </span>
    <?php endif; ?>
</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="menu">
            <div class="navbar-nav ms-auto align-items-lg-center gap-lg-2">
                <?php if ($autenticado): ?>
                    <span class="nav-link">Hola, <?= esc($nombreUsuario) ?></span>
                    <a class="nav-link" href="<?= base_url('catalogo') ?>">Catálogo</a>
                    <form action="<?= base_url('logout') ?>" method="post" class="m-0">
                        <?= csrf_field() ?>
                        <button class="btn btn-outline-primary" type="submit">Cerrar sesión</button>
                    </form>
                <?php else: ?>
                    <a class="nav-link" href="#como-funciona">Cómo funciona</a>
                    <a class="btn btn-outline-primary" href="<?= base_url('login') ?>">Iniciar sesión</a>
                    <a class="btn btn-primary" href="<?= base_url('registro') ?>">Crear cuenta</a>
                <?php endif; ?>
            </div>
        </div>
    </div>
</nav>

<?php if (session()->getFlashdata('exito')): ?>
    <div class="container mt-3"><div class="alert alert-success"><?= esc(session()->getFlashdata('exito')) ?></div></div>
<?php endif; ?>

<?php if (! $autenticado): ?>
<main>
    <section class="hero py-5">
        <div class="container py-5">
            <div class="row align-items-center g-5">
                <div class="col-lg-7">
                    <span class="badge text-bg-light text-primary mb-3">Aprende con acompañamiento personalizado</span>
                    <h1 class="display-4 fw-bold">Refuerza tus conocimientos con el tutor adecuado</h1>
                    <p class="lead text-secondary my-4">eRa conecta estudiantes con tutores en programación, bases de datos y desarrollo web.</p>
                    <div class="d-flex flex-wrap gap-3">
                        <a class="btn btn-primary btn-lg" href="<?= base_url('registro') ?>">Comenzar ahora</a>
                        <a class="btn btn-light btn-lg" href="#lenguajes">Explorar lenguajes</a>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="hero-card"><i class="bi bi-mortarboard-fill"></i><h2>Aprende a tu ritmo</h2><p class="mb-0">Selecciona un tema, encuentra un tutor y programa tu refuerzo.</p></div>
                </div>
            </div>
        </div>
    </section>

    <section id="como-funciona" class="container py-5">
        <div class="text-center mb-5"><p class="section-kicker">PROCESO</p><h2 class="fw-bold">¿Cómo funciona eRa?</h2></div>
        <div class="row g-4">
            <?php foreach ([
                ['1', 'Elige un lenguaje', 'Selecciona el área en la que necesitas refuerzo.'],
                ['2', 'Escoge un tema', 'Consulta los temas disponibles y su tutor.'],
                ['3', 'Programa tu tutoría', 'Coordina una sesión de acuerdo con tu necesidad.'],
            ] as $paso): ?>
                <div class="col-md-4"><article class="info-card h-100"><span><?= $paso[0] ?></span><h3><?= $paso[1] ?></h3><p><?= $paso[2] ?></p></article></div>
            <?php endforeach; ?>
        </div>
    </section>

    <section id="lenguajes" class="section-soft py-5">
        <div class="container py-4">
            <div class="d-flex justify-content-between align-items-end mb-4">
                <div><p class="section-kicker">CATÁLOGO</p><h2 class="fw-bold mb-0">Lenguajes disponibles</h2></div>
                <a href="<?= base_url('login') ?>">Inicia sesión para ver los temas</a>
            </div>
            <div class="row g-3">
                <?php foreach (array_slice($lenguajes, 0, 8) as $lenguaje): ?>
                    <div class="col-sm-6 col-lg-3">
                        <article class="language-card h-100">
                            <div class="language-icon"><i class="bi bi-code-slash"></i></div>
                            <h3><?= esc($lenguaje['nombre']) ?></h3>
                            <p><?= esc($lenguaje['descripcion']) ?></p>
                            <small><?= (int) $lenguaje['total_temas'] ?> temas disponibles</small>
                        </article>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </section>
</main>
<?php else: ?>
<main>
    <section class="container pt-5 pb-4">
        <h1 class="fw-bold">
            ¡Hola, <?= esc($nombreUsuario) ?>! 👋
        </h1>

        <p class="text-secondary mb-4">
            Continúa aprendiendo y encuentra apoyo para tus dudas de programación.
        </p>

        <div class="d-flex flex-column flex-sm-row gap-3">
            <a class="btn btn-primary btn-lg"
               href="<?= base_url('catalogo') ?>">
                <i class="bi bi-book me-2" aria-hidden="true"></i>
                Explorar Lenguajes
            </a>

            <button class="btn btn-success btn-lg"
                    type="button"
                    disabled>
                <i class="bi bi-search me-2" aria-hidden="true"></i>
                Buscar Tutor
            </button>
        </div>

        <p class="small text-secondary mt-3 mb-0">
            La búsqueda de tutores estará disponible próximamente.
        </p>
    </section>
    <section class="container py-5">
        <div class="row g-4 mb-5">
            <div class="col-md-4"><div class="stat-card"><i class="bi bi-code-square"></i><strong><?= $totalLenguajes ?></strong><span>Lenguajes</span></div></div>
            <div class="col-md-4"><div class="stat-card"><i class="bi bi-journal-code"></i><strong><?= $totalTemas ?></strong><span>Temas</span></div></div>
            <div class="col-md-4"><div class="stat-card"><i class="bi bi-people"></i><strong><?= $totalTutores ?></strong><span>Tutores</span></div></div>
        </div>
        <div class="d-flex justify-content-between align-items-end mb-4">
            <div><p class="section-kicker">APRENDIZAJE</p><h2 class="fw-bold mb-0">Selecciona un lenguaje</h2></div>
            <a class="btn btn-primary" href="<?= base_url('catalogo') ?>">Ver todos los temas</a>
        </div>
        <div class="row g-3">
            <?php foreach ($lenguajes as $lenguaje): ?>
                <div class="col-sm-6 col-lg-4">
                    <a class="text-decoration-none" href="<?= base_url('catalogo?lenguaje=' . $lenguaje['id_lenguaje']) ?>">
                        <article class="language-card h-100">
                            <div class="language-icon"><i class="bi bi-code-slash"></i></div>
                            <h3><?= esc($lenguaje['nombre']) ?></h3>
                            <p><?= esc($lenguaje['descripcion']) ?></p>
                            <small><?= (int) $lenguaje['total_temas'] ?> temas</small>
                        </article>
                    </a>
                </div>
            <?php endforeach; ?>
        </div>
    </section>
</main>
<?php endif; ?>

<footer class="py-4 border-top bg-white"><div class="container text-center text-secondary">© <?= date('Y') ?> Plataforma de Refuerzo Educativo eRa</div></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
