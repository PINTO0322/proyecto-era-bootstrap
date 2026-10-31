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
            }
        }

        return view('home', [
            'autenticado' => (bool) session()->get('autenticado'),
            'tutoriasCompletadas' => $tutoriasCompletadas,
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

