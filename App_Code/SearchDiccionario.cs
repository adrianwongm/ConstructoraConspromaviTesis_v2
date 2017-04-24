using HotelBooking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de SearchCaracteristicas
/// </summary>
public class SearchDiccionario
{
    public SearchDiccionario()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    public SearchDiccionario(string page, HotelBookingDataContext context)
    {
        Page = page;
        DataContext = context; 
    }

    public string Page { get; set; }

    public HotelBookingDataContext DataContext { get; set; }

    public List<SCPV_Diccionario> getListadoDiccionarios(int tipo) {
        var consulta = from p in DataContext.SCPV_Diccionario
                       where p.id_tipo == tipo
                       select p ;
        return consulta.ToList();
    }
}