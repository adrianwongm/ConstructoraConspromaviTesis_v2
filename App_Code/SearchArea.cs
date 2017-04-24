using HotelBooking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de SearchArea
/// </summary>
public class SearchArea
{
    public SearchArea()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    public SearchArea(string page, HotelBookingDataContext context)
    {
        Page = page;
        DataContext = context;
    }


    public string Page { get; set; }

    public HotelBookingDataContext DataContext { get; set; }

    public List<Metro_Area> getListadoAreas()
    {
        var consulta = from p in DataContext.Metro_Areas
                       select p;
        return consulta.ToList();
    }

}