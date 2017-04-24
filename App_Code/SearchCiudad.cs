using HotelBooking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de SearchCiudad
/// </summary>
public class SearchCiudad
{
    public SearchCiudad()
    { 
    }

    public SearchCiudad(string page, HotelBookingDataContext context)
    {
        Page = page;
        DataContext = context;
    }
     
    public string Page { get; set; }

    public HotelBookingDataContext DataContext { get; set; }

    public List<City> getListadoCiudadByAreaID(int v)
    {
        var consulta = from p in DataContext.Cities
                       where p.Metro_Area_ID == v
                       select p;
        return consulta.ToList();
    }
}