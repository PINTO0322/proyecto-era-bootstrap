<?php

use CodeIgniter\Router\RouteCollection;

/** @var RouteCollection $routes */
$routes->get('/', 'Home::index');
$routes->get('catalogo', 'Home::catalogo');

$routes->get('registro', 'Auth::mostrarRegistro');
$routes->post('registro', 'Auth::registrar', ['filter' => 'csrf']);

$routes->get('login', 'Auth::mostrarLogin');
$routes->post('login', 'Auth::login', ['filter' => 'csrf']);
$routes->post('logout', 'Auth::logout', ['filter' => 'csrf']);
