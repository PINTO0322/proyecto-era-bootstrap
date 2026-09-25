<?php

namespace App\Controllers;

use App\Models\UsuarioModel;
use CodeIgniter\HTTP\RedirectResponse;

class Auth extends BaseController
{
    public function mostrarRegistro(): string|RedirectResponse
    {
        if (session()->get('autenticado')) {
            return redirect()->to('/');
        }

        return view('auth/registro');
    }

    public function registrar(): RedirectResponse
    {
        $reglas = [
            'nombre' => 'required|min_length[2]|max_length[80]',
            'apellido' => 'required|min_length[2]|max_length[80]',
            'correo' => 'required|valid_email|max_length[120]|is_unique[usuario.correo]',
            'contrasena' => 'required|min_length[8]|max_length[72]',
            'confirmar_contrasena' => 'required|matches[contrasena]',
            'id_rol' => 'required|in_list[2,3]',
        ];

        if (! $this->validate($reglas)) {
            return redirect()->back()
                ->withInput()
                ->with('errores', $this->validator->getErrors());
        }

        $db = db_connect();
        $db->transStart();

        $usuarioModel = new UsuarioModel();
        $idRol = (int) $this->request->getPost('id_rol');

        $idUsuario = $usuarioModel->insert([
            'nombre' => trim((string) $this->request->getPost('nombre')),
            'apellido' => trim((string) $this->request->getPost('apellido')),
            'correo' => strtolower(trim((string) $this->request->getPost('correo'))),
            'contrasena' => password_hash(
                (string) $this->request->getPost('contrasena'),
                PASSWORD_BCRYPT
            ),
            'id_rol' => $idRol,
            'id_estado' => 1,
        ], true);

        if ($idRol === 2) {
            $db->table('estudiante')->insert(['id_usuario' => $idUsuario]);
        } else {
            $db->table('tutor')->insert([
                'id_usuario' => $idUsuario,
                'descripcion' => 'Perfil de tutor en proceso de actualización',
                'tarifa_hora' => 0,
                'nivel_experiencia' => 'Inicial',
            ]);
        }

        $db->transComplete();

        if (! $db->transStatus()) {
            return redirect()->back()
                ->withInput()
                ->with('error', 'No fue posible crear la cuenta. Inténtalo nuevamente.');
        }

        return redirect()->to('/login')->with('exito', 'Cuenta creada. Ya puedes iniciar sesión.');
    }

    public function mostrarLogin(): string|RedirectResponse
    {
        if (session()->get('autenticado')) {
            return redirect()->to('/');
        }

        return view('auth/login');
    }

    public function login(): RedirectResponse
    {
        $correo = strtolower(trim((string) $this->request->getPost('correo')));
        $contrasena = (string) $this->request->getPost('contrasena');

        if ($correo === '' || $contrasena === '') {
            return redirect()->back()->withInput()->with('error', 'Completa el correo y la contraseña.');
        }

        $usuario = (new UsuarioModel())
            ->where('correo', $correo)
            ->first();

        if (! $usuario || (int) $usuario['id_estado'] !== 1 || ! password_verify($contrasena, $usuario['contrasena'])) {
            return redirect()->back()->withInput()->with('error', 'Correo o contraseña incorrectos.');
        }

        $sesion = session();
        $sesion->regenerate(true);
        $sesion->set([
            'usuario_id' => (int) $usuario['id_usuario'],
            'usuario_nombre' => $usuario['nombre'],
            'usuario_correo' => $usuario['correo'],
            'usuario_rol' => (int) $usuario['id_rol'],
            'autenticado' => true,
        ]);

        return redirect()->to('/');
    }

    public function logout(): RedirectResponse
    {
        session()->destroy();

        return redirect()->to('/')->with('exito', 'Sesión cerrada correctamente.');
    }
}
