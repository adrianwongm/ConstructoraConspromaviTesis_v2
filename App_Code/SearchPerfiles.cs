using HotelBooking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de SearchPerfiles
/// </summary>
public class SearchPerfiles
{
    public SearchPerfiles()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    public SearchPerfiles(string page, HotelBookingDataContext context)
    {
        Page = page;
        DataContext = context;
    }

    public string Page { get; set; }

    public HotelBookingDataContext DataContext { get; set; }

    public List<SCPV_Perfiles> getListPerfiles(string pEstado)
    {
        var listado = from p in DataContext.SCPV_Perfiles
                      where p.Estado == pEstado
                      select p;

        return listado.ToList();
    }

    public bool addPerfiles(SCPV_Perfiles pPerfil) {
        bool bandera = false;
        try
        {
            DataContext.SCPV_Perfiles.InsertOnSubmit(pPerfil);
            DataContext.SubmitChanges();
            bandera = true;
        }
        catch (Exception)
        {
             
        }
        return bandera;
    }

    public bool updatePerfiles(SCPV_Perfiles pPerfil) {
        bool bandera = false;
        try
        {
            var perfil = DataContext.SCPV_Perfiles.Where(p => p.Codigo == pPerfil.Codigo).FirstOrDefault();
            perfil.Descripcion = pPerfil.Descripcion;
            perfil.Estado = pPerfil.Estado;
            perfil.UsuarioModificacion = pPerfil.UsuarioModificacion;
            perfil.FechaModificacion = pPerfil.FechaModificacion;
            DataContext.SubmitChanges();
            bandera = true;
        }
        catch (Exception ex)
        {
             
        }
        return bandera; 
    }
 }