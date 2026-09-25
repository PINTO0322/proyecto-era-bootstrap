<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Catálogo - eRa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="<?= base_url('assets/css/era.css') ?>" rel="stylesheet">
</head>
<body>
<nav class="navbar bg-white border-bottom sticky-top">
    <div class="container py-2">
        <a class="navbar-brand brand" href="<?= base_url('/') ?>">eRa</a>
        <div class="d-flex align-items-center gap-3">
            <span class="d-none d-md-inline">Hola, <?= esc($nombreUsuario) ?></span>
            <a class="btn btn-outline-primary" href="<?= base_url('/') ?>">Volver al panel</a>
            <form action="<?= base_url('logout') ?>" method="post" class="m-0">
                <?= csrf_field() ?>
                <button class="btn btn-link text-decoration-none" type="submit">Salir</button>
            </form>
        </div>
    </div>
</nav>

<main class="container py-5">
    <div class="row align-items-end g-4 mb-5">
        <div class="col-lg-7">
            <p class="section-kicker">CATÁLOGO REAL</p>
            <h1 class="fw-bold">Temas y tutores disponibles</h1>
            <p class="text-secondary mb-0">La información se consulta directamente desde la base de datos de eRa.</p>
        </div>
        <div class="col-lg-5">
            <form action="<?= base_url('catalogo') ?>" method="get">
                <label class="form-label fw-semibold" for="lenguaje">Filtrar por lenguaje</label>
                <div class="input-group">
                    <select class="form-select" id="lenguaje" name="lenguaje">
                        <option value="0">Todos los lenguajes</option>
                        <?php foreach ($lenguajes as $lenguaje): ?>
                            <option value="<?= $lenguaje['id_lenguaje'] ?>" <?= $idLenguaje === (int) $lenguaje['id_lenguaje'] ? 'selected' : '' ?>><?= esc($lenguaje['nombre']) ?></option>
                        <?php endforeach; ?>
                    </select>
                    <button class="btn btn-primary" type="submit">Filtrar</button>
                </div>
            </form>
        </div>
    </div>

    <div class="row g-4">
        <?php if ($temas === []): ?>
            <div class="col-12"><div class="alert alert-info">Este lenguaje todavía no tiene temas registrados.</div></div>
        <?php endif; ?>
        <?php foreach ($temas as $tema): ?>
            <div class="col-md-6 col-xl-4">
                <article class="topic-card h-100">
                    <span class="badge text-bg-primary mb-3"><?= esc($tema['lenguaje']) ?></span>
                    <h2 class="h4 fw-bold"><?= esc($tema['tema']) ?></h2>
                    <p class="text-secondary"><?= esc($tema['descripcion']) ?></p>
                    <hr>
                    <?php if ($tema['tutor']): ?>
                        <p class="mb-1"><i class="bi bi-person-check me-2"></i><?= esc($tema['tutor']) ?></p>
                        <p class="mb-1"><i class="bi bi-award me-2"></i><?= esc($tema['nivel_experiencia'] ?? 'Sin especificar') ?></p>
                        <p class="mb-0 fw-semibold"><i class="bi bi-cash-coin me-2"></i>$<?= number_format((float) $tema['tarifa_hora'], 0, ',', '.') ?> por hora</p>
                    <?php else: ?>
                        <p class="text-secondary mb-0">Tutor pendiente de asignación</p>
                    <?php endif; ?>
                </article>
            </div>
        <?php endforeach; ?>
    </div>
</main>

<footer class="py-4 border-top bg-white"><div class="container text-center text-secondary">© <?= date('Y') ?> Plataforma de Refuerzo Educativo eRa</div></footer>
</body>
</html>
