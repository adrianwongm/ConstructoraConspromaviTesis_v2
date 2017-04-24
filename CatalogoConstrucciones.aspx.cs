using DevExpress.Web.Internal;
using HotelBooking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CatalogoConstrucciones : System.Web.UI.Page
{

    public List<Metro_Area> listadoArea
    {
        get
        {
            return (List<Metro_Area>)Session["listadoArea"];
        }
        set
        {
            Session["listadoArea"] = value;
        }
    }

    public List<City> listadoCiudad
    {
        get
        {
            return (List<City>)Session["listadoCiudad"];
        }
        set
        {
            Session["listadoCiudad"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        cargarCaracteristicas();
        cargarAreas();
    }

    private void cargarAreas()
    {
        try
        {
            SearchArea sAreas= new SearchArea(this.ToString(), new HotelBooking.HotelBookingDataContext());
            this.cmbArea.DataSource = listadoArea = sAreas.getListadoAreas();
            this.cmbArea.DataBind();
        }
        catch (Exception)
        {

            throw;
        }
    }

    private void cargarCaracteristicas()
    {
        try
        {
            SearchCaracteristicas sCaracteristicas = new SearchCaracteristicas(this.ToString(), new HotelBooking.HotelBookingDataContext());
            this.cmbCaracteristicas.DataSource = sCaracteristicas.getListadoCaracteristicas();
            this.cmbCaracteristicas.DataBind();
        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void cmbCiudad_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
    {
        try
        {
            if (e.Parameter.Contains("CARGAR"))
            {
                var a = e.Parameter.ToString().Split('|');
                cargarCiudad(int.Parse(a[1].ToString()));
            }
        }
        catch (Exception)
        {

            throw;
        }
    }

    private void cargarCiudad(int v)
    {
        try
        {
            SearchCiudad sCiudad = new SearchCiudad(this.ToString(), new HotelBooking.HotelBookingDataContext());
            this.cmbCiudad.DataSource = listadoCiudad = sCiudad.getListadoCiudadByAreaID(v);
            this.cmbCiudad.DataBind();

        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void cmbArea_DataBinding(object sender, EventArgs e)
    {
        try
        {
            if (listadoArea != null) {
                cmbArea.DataSource = listadoArea;
            }
        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void cmbCiudad_DataBinding(object sender, EventArgs e)
    {
        try
        {
            if (listadoCiudad != null) {
                cmbCiudad.DataSource = listadoCiudad;
            }
        }
        catch (Exception)
        {

            throw;
        }
    } 

    protected void ASPxUploadControl1_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
    {
        try
        {
            string ruta = Server.MapPath("~/Content/Pictures/");
            e.UploadedFile.SaveAs(ruta + e.UploadedFile.FileName);
            if (e.IsValid)
                e.CallbackData ="OK";
        }
        catch (Exception)
        {

            throw;
        }
    }
}