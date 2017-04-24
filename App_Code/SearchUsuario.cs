using HotelBooking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de SearchUsuario
/// </summary>
public class SearchUsuario
{
    public SearchUsuario()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    public SearchUsuario(string page, HotelBookingDataContext context)
    {
        Page = page;
        DataContext = context;
        
    }

    public string Page { get; set; }

    public HotelBookingDataContext DataContext { get; set; }

    public List<SCPV_Usuario_Empleados>getListEmpleadosByEmpresa(int pID_Empresa, string pEstado)
    {
        try
        {
            var listadoUsuarios = from p in DataContext.SCPV_Empleados
                                  join x in DataContext.SCPV_Usuario_Empleados on p.ID equals x.ID_Empleado
                                  where x.Estado == pEstado
                                  select new 
                                  {
                                      Empleado =    p.Nombres +" "+ p.Apellidos,
                                      ID = x.ID,
                                      Estado = x.Estado,
                                      Usuario = x.Usuario,
                                      ID_Empleado = x.ID_Empleado
                                  };
            List<SCPV_Usuario_Empleados> users = listadoUsuarios.AsEnumerable().Select(item => new SCPV_Usuario_Empleados()
            { Empleado_Nombres = item.Empleado, ID = item.ID, Estado = item.Estado, Usuario = item.Usuario, ID_Empleado = item.ID_Empleado }).ToList();

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

    public bool addUsuario(SCPV_Usuario_Empleados user) {
        bool bandera = false;
        try
        {
           DataContext.SP_SCPV_Ingresa_Usuario(user.Usuario, user.Password, user.ID_Empleado, user.Estado);
            bandera = true;
        }
        catch (Exception)
        {

            throw;
        }
        return bandera;
    }

    public bool updateUsuario(SCPV_Usuario_Empleados user)
    {
        bool bandera = false;
        try
        {
            DataContext.SP_SCPV_Actualiza_Usuario(user.Usuario, user.Password, user.Estado);
            bandera = true;
        }
        catch (Exception)
        {

            throw;
        }
        return bandera;
    }
}