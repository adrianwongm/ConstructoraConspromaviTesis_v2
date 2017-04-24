using HotelBooking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de SearchUsuario
/// </summary>
public class SearchClientes
{
    public SearchClientes()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    public SearchClientes(string page, HotelBookingDataContext context)
    {
        Page = page;
        DataContext = context;
        
    }

    public string Page { get; set; }

    public HotelBookingDataContext DataContext { get; set; }

    public List<SCPV_Clientes> getListClientesByCiudad(string pCiudad, string pEstado)
    {
        try
        {
            var listadoUsuarios = from p in DataContext.SCPV_Clientes
                                  where p.Estado == pEstado && p.Ciudad == pCiudad
                                  select new 
                                  {
                                      Cliente =    p.Nombres +" "+ p.Apellidos,
                                      Nombres = p.Nombres,
                                      Apellidos = p.Apellidos,
                                      ID = p.ID_Cliente,
                                      Identificacion = p.Identificacion,
                                      Estado = p.Estado,
                                      Usuario = p.Login,
                                      direccion = p.Direccion,
                                      tipoiden = p.TipoIdentificacion,
                                      ciudad = p.Ciudad,
                                      referencia = p.Referencia
                                  };
            List<SCPV_Clientes> users = listadoUsuarios.AsEnumerable().Select(item => new SCPV_Clientes()
            { Nombres = item.Nombres,
                Apellidos = item.Apellidos,
                ID_Cliente = item.ID, Estado = item.Estado, Login = item.Usuario, Direccion = item.direccion, TipoIdentificacion =item.tipoiden,
            Ciudad=item.ciudad, Referencia=item.referencia, Identificacion = item.Identificacion         }).ToList();

            return users;
        }
        catch (Exception ex)
        {

            throw;
        }
    }
    public List<SCPV_Clientes> getListClientes(string pEstado)
    {
        try
        {
            var listadoUsuarios = from p in DataContext.SCPV_Clientes
                                  where p.Estado == pEstado
                                  select new
                                  {
                                      Cliente = p.Nombres + " " + p.Apellidos,
                                      Nombres = p.Nombres,
                                      Apellidos = p.Apellidos,
                                      ID = p.ID_Cliente,
                                      Identificacion = p.Identificacion,
                                      Estado = p.Estado,
                                      Usuario = p.Login,
                                      direccion = p.Direccion,
                                      tipoiden = p.TipoIdentificacion,
                                      ciudad = p.Ciudad,
                                      referencia = p.Referencia,
                                      convencional=p.TelefonoConvencional,
                                      celular = p.TelefonoCelurares
                                  };
            List<SCPV_Clientes> users = listadoUsuarios.AsEnumerable().Select(item => new SCPV_Clientes()
            {
                Nombres = item.Nombres,
                Apellidos = item.Apellidos,
                ID_Cliente = item.ID,
                Estado = item.Estado,
                Login = item.Usuario,
                Direccion = item.direccion,
                TipoIdentificacion = item.tipoiden,
                Identificacion=item.Identificacion,
                Ciudad = item.ciudad,
                Referencia = item.referencia,
                TelefonoConvencional = item.convencional,
                TelefonoCelurares = item.celular
            }).ToList();

            return users;
        }
        catch (Exception ex)
        {

            throw;
        }
    }

    public SCPV_Usuario_Empleados VerficaUsuario(string pEmail, string pPassword)
    {
        SCPV_Usuario_Empleados userCliente = null;
        try
        {
          userCliente =   DataContext.SCPV_Usuario_Empleados.Where(p => p.Usuario == pEmail && p.Password == pPassword).FirstOrDefault();
            if(userCliente == null)
            {
                throw new Exception("No existe el usuario");
            }
        }
        catch (Exception)
        {
            throw;
        }
        return userCliente;
    }

    public SCPV_Usuario_Empleados VerficaUsuario2(string pEmail, string pPassword)
    {
        SCPV_Usuario_Empleados userClienteRetorno = null;
        SP_SCPV_Verifica_UsuarioResult userCliente = null;
        try
        {
            userCliente = DataContext.SP_SCPV_Verifica_Usuario(pEmail,pPassword).FirstOrDefault();
            if (userCliente == null)
            {

                throw new Exception("No existe el usuario");
            }
            else{
                userClienteRetorno = DataContext.SCPV_Usuario_Empleados.Where(p => p.Usuario == pEmail).FirstOrDefault();
            }
        }
        catch (Exception)
        {
            throw;
        }
        return userClienteRetorno;
    }

    public bool addCliente(SCPV_Clientes user) {
        bool bandera = false;
        try
        {
           DataContext.SP_SCPV_Ingresa_Cliente(user.Login, user.Password, user.Identificacion, user.TipoIdentificacion ,user.Nombres, user.Apellidos, user.Ciudad
             , user.Direccion, user.Referencia, user.TelefonoConvencional, user.TelefonoCelurares  , user.Estado);
            bandera = true;
        }
        catch (Exception)
        {

            throw;
        }
        return bandera;
    }

    public bool updateCliente(SCPV_Clientes user)
    {
        bool bandera = false;
        try
        {
            DataContext.SP_SCPV_Actualiza_Cliente(user.Login, user.Password, user.Identificacion, user.TipoIdentificacion, user.ID_Cliente, user.Nombres, user.Apellidos, user.Ciudad
             , user.Direccion, user.Referencia, user.TelefonoConvencional, user.TelefonoCelurares, user.Estado);
            bandera = true;
        }
        catch (Exception)
        {

            throw;
        }
        return bandera;
    }
}