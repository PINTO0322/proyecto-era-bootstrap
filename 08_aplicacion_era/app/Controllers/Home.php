<?php

namespace App\Controllers;

use CodeIgniter\HTTP\RedirectResponse;

class Home extends BaseController
{
    public function index(): string
    {
        $db = db_connect();

        $lenguajes = $db->table('lenguaje AS lenguaje')
            ->select('lenguaje.id_lenguaje, lenguaje.nombre, lenguaje.descripcion, COUNT(tema.id_tema) AS total_temas')
            ->join('tema', 'tema.id_lenguaje = lenguaje.id_lenguaje', 'left')
            ->where('lenguaje.id_estado', 4)
            ->groupBy('lenguaje.id_lenguaje, lenguaje.nombre, lenguaje.descripcion')
            ->orderBy('lenguaje.nombre', 'ASC')
            ->get()
            ->getResultArray();

                    $tutoriasCompletadas = null;
                    $horasAprendizaje = null;
                    $progresoGeneral = null;
                    $proximasSesiones = null;

        if (
            session()->get('autenticado')
            && (int) session()->get('usuario_rol') === 2
        ) {
            $estudiante = $db->table('estudiante')
                ->where('id_usuario', (int) session()->get('usuario_id'))
                ->get()
                ->getRowArray();

            if ($estudiante !== null) {
                $tutoriasCompletadas = $db->table('sesion_tutoria')
                    ->where('id_estudiante', (int) $estudiante['id_estudiante'])
                    ->where('id_estado', 14)
                    ->countAllResults();
                $resumenDuracion = $db->table('sesion_tutoria')
                    ->selectSum('duracion', 'total_minutos')
                    ->where('id_estudiante', (int) $estudiante['id_estudiante'])
                    ->where('id_estado', 14)
                    ->get()
                    ->getRowArray();

                $horasAprendizaje = (float) ($resumenDuracion['total_minutos'] ?? 0) / 60;
                $resumenProgreso = $db->table('estudiante_lenguaje')
                    ->selectAvg('porcentaje_progreso', 'promedio')
                    ->where('id_estudiante', (int) $estudiante['id_estudiante'])
                    ->get()
                    ->getRowArray();

                                if ($resumenProgreso['promedio'] !== null) {
                    $progresoGeneral = (float) $resumenProgreso['promedio'];
                }

                $ahora = new \DateTimeImmutable(
                    'now',
                    new \DateTimeZone('America/Bogota')
                );

                $proximasSesiones = $db->table('sesion_tutoria AS s')
                    ->select(
                        "s.id_sesion, s.fecha, s.hora, s.duracion,
                        tema.nombre AS tema,
                        CONCAT(u.nombre, ' ', u.apellido) AS tutor,
                        estado.nombre AS estado"
                    )
                    ->join('tema', 'tema.id_tema = s.id_tema')
                    ->join('tutor', 'tutor.id_tutor = s.id_tutor')
                    ->join('usuario AS u', 'u.id_usuario = tutor.id_usuario')
                    ->join('estado', 'estado.id_estado = s.id_estado')
                    ->where('s.id_estudiante', (int) $estudiante['id_estudiante'])
                    ->whereIn('s.id_estado', [12, 13])
                    ->groupStart()
                        ->where('s.fecha >', $ahora->format('Y-m-d'))
                        ->orGroupStart()
                            ->where('s.fecha', $ahora->format('Y-m-d'))
                            ->where('s.hora >=', $ahora->format('H:i:s'))
                        ->groupEnd()
                    ->groupEnd()
                    ->orderBy('s.fecha', 'ASC')
                    ->orderBy('s.hora', 'ASC')
                    ->orderBy('s.id_sesion', 'ASC')
                    ->limit(3)
                    ->get()
                    ->getResultArray();
                
            }
        }
                $tutoresPanel = null;

        if (
            session()->get('autenticado')
            && (int) session()->get('usuario_rol') === 2
        ) {
            $tutoresPanel = $db->table('tutor AS t')
                ->select(
                    "t.id_tutor, t.especialidad, t.nivel_experiencia,
                    t.tarifa_hora,
                    CONCAT(u.nombre, ' ', u.apellido) AS nombre"
                )
                ->join('usuario AS u', 'u.id_usuario = t.id_usuario')
                ->where('u.id_estado', 1)
                ->where('u.id_rol', 3)
                ->orderBy('u.nombre', 'ASC')
                ->orderBy('u.apellido', 'ASC')
                ->orderBy('t.id_tutor', 'ASC')
                ->limit(3)
                ->get()
                ->getResultArray();
        }

        return view('home', [
            'autenticado' => (bool) session()->get('autenticado'),
            'tutoriasCompletadas' => $tutoriasCompletadas,
            'horasAprendizaje' => $horasAprendizaje,
            'progresoGeneral' => $progresoGeneral,
            'proximasSesiones' => $proximasSesiones,
            'tutoresPanel' => $tutoresPanel,
            'nombreUsuario' => session()->get('usuario_nombre'),
            'lenguajes' => $lenguajes,
            'totalLenguajes' => count($lenguajes),
            'totalTutores' => $db->table('tutor')->countAllResults(),
            'totalTemas' => $db->table('tema')->countAllResults(),
        ]);
    }

    public function catalogo(): string|RedirectResponse
    {
        if (! session()->get('autenticado')) {
            return redirect()->to('/login')->with('error', 'Inicia sesión para consultar el catálogo.');
        }

        $db = db_connect();
        $idLenguaje = (int) $this->request->getGet('lenguaje');

        $lenguajes = $db->table('lenguaje')
            ->select('id_lenguaje, nombre')
            ->where('id_estado', 4)
            ->orderBy('nombre', 'ASC')
            ->get()
            ->getResultArray();

        $temasBuilder = $db->table('tema AS tema')
            ->select("tema.id_tema, tema.nombre AS tema, tema.descripcion, lenguaje.id_lenguaje, lenguaje.nombre AS lenguaje, CONCAT(usuario.nombre, ' ', usuario.apellido) AS tutor, tutor.tarifa_hora, tutor.nivel_experiencia")
            ->join('lenguaje', 'lenguaje.id_lenguaje = tema.id_lenguaje')
            ->join('tutor', 'tutor.id_tutor = tema.id_tutor', 'left')
            ->join('usuario', 'usuario.id_usuario = tutor.id_usuario', 'left')
            ->where('lenguaje.id_estado', 4)
            ->orderBy('lenguaje.nombre', 'ASC')
            ->orderBy('tema.nombre', 'ASC');

        if ($idLenguaje > 0) {
            $temasBuilder->where('lenguaje.id_lenguaje', $idLenguaje);
        }

        return view('catalogo', [
            'nombreUsuario' => session()->get('usuario_nombre'),
            'lenguajes' => $lenguajes,
            'idLenguaje' => $idLenguaje,
            'temas' => $temasBuilder->get()->getResultArray(),
        ]);
    }
}

