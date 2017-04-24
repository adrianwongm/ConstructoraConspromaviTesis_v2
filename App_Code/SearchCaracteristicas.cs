using HotelBooking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de SearchCaracteristicas
/// </summary>
public class SearchCaracteristicas
{
    public SearchCaracteristicas()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    public SearchCaracteristicas(string page, HotelBookingDataContext context)
    {
        Page = page;
        DataContext = context; 
    }

    public string Page { get; set; }

    public HotelBookingDataContext DataContext { get; set; }

    public List<Features_List> getListadoCaracteristicas() {
        var consulta = from p in DataContext.Features_Lists
                       select p;
        return consulta.ToList();
    }
}