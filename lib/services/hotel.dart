import '../models/habitacion.dart';
import '../models/huesped.dart';
import '../models/recepcionista.dart';
import '../models/reserva.dart';
import '../models/check_in.dart';
import '../models/check_out.dart';
import '../enums/tipo_habitacion.dart';
import '../enums/estado_habitacion.dart';

// Clase principal del sistema: guarda toda la información del hotel
// y contiene las reglas de negocio (reservas, check-in, check-out, etc).
// La interfaz de consola (SistemaHotel) solo llama a estos métodos,
// no valida nada por su cuenta.
class Hotel {
  List<Habitacion> habitaciones = [];
  List<Recepcionista> recepcionistas = [];
  List<Reserva> reservas = [];
  List<CheckIn> checkIns = [];
  List<CheckOut> checkOuts = [];

  Hotel() {
    crearHabitacionesIniciales();
  }

  // Carga inicial de habitaciones del hotel. En una versión real esto
  // vendría de una base de datos o de un archivo de configuración.
  void crearHabitacionesIniciales() {
    habitaciones.add(
      Habitacion(numero: 101, tipo: TipoHabitacion.sencilla, capacidad: 1),
    );
    habitaciones.add(
      Habitacion(numero: 102, tipo: TipoHabitacion.sencilla, capacidad: 1),
    );
    habitaciones.add(
      Habitacion(numero: 201, tipo: TipoHabitacion.doble, capacidad: 2),
    );
    habitaciones.add(
      Habitacion(numero: 202, tipo: TipoHabitacion.doble, capacidad: 2),
    );
    habitaciones.add(
      Habitacion(numero: 301, tipo: TipoHabitacion.suite, capacidad: 4),
    );
  }

  // ---------- RF01 y RF02: Recepcionistas ----------

  // Devuelve true si el registro fue exitoso, false si el usuario ya existe.
  bool registrarRecepcionista(String usuario, String contrasena) {
    for (var r in recepcionistas) {
      if (r.usuario == usuario) {
        return false;
      }
    }
    recepcionistas.add(Recepcionista(usuario: usuario, contrasena: contrasena));
    return true;
  }

  bool iniciarSesion(String usuario, String contrasena) {
    for (var r in recepcionistas) {
      if (r.usuario == usuario && r.contrasena == contrasena) {
        return true;
      }
    }
    return false;
  }

  // ---------- Buscar y consultar habitaciones (RF03) ----------

  // Busca una habitación por número. Devuelve null si no existe.
  Habitacion? buscarHabitacion(int numero) {
    for (var h in habitaciones) {
      if (h.numero == numero) {
        return h;
      }
    }
    return null;
  }

  List<Habitacion> consultarDisponibles() {
    List<Habitacion> disponibles = [];
    for (var h in habitaciones) {
      if (h.estado == EstadoHabitacion.disponible) {
        disponibles.add(h);
      }
    }
    return disponibles;
  }
}
