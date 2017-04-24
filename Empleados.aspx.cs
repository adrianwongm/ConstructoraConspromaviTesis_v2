using HotelBooking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Empleados : System.Web.UI.Page
{
    public List<HotelBooking.SCPV_Usuario_Empleados> listadoUsuarioEmpleados
    {
        get
        {
            return (List<HotelBooking.SCPV_Usuario_Empleados>)Session["listadoUsuarios"];
        }
        set
        {
            Session["listadoUsuarios"] = value;
        }
    }


    public List<HotelBooking.SCPV_Empleados> listadoEmpleados
    {
        get
        {
            return (List<HotelBooking.SCPV_Empleados>)Session["listadoEmpleados"];
        }
        set
        {
            Session["listadoEmpleados"] = value;
        }
    }

    public List<HotelBooking.SCPV_Diccionario> listadoCargo
    {
        get
        {
            return (List<HotelBooking.SCPV_Diccionario>)Session["listadoCargo"];
        }
        set
        {
            Session["listadoCargo"] = value;
        }
    }

   


    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            cargaInicialDatosEmpleados();
            cargaCombos();
        }
        catch (Exception)
        {

            throw;
        }
    }

    private void cargaCombos()
    {
        SearchDiccionario oTipoDocumento = new SearchDiccionario(this.ToString(), new HotelBooking.HotelBookingDataContext());
        listadoCargo = oTipoDocumento.getListadoDiccionarios(3);
        this.cmbCargos.DataSource = listadoCargo;
        this.cmbCargos.DataBind();
    }

    private void cargaInicialDatosEmpleados()
    {
        SearchEmpleado oSearchEmpleado = new SearchEmpleado(this.ToString(), new HotelBooking.HotelBookingDataContext());
        listadoEmpleados = oSearchEmpleado.getListEmpleado("A");
        this.grdListadoEmpleados.DataSource = listadoEmpleados;
        this.grdListadoEmpleados.DataBind();
    }



    protected void grdListadoEmpleados_DataBinding(object sender, EventArgs e)
    {
        try
        {
            this.grdListadoEmpleados.DataSource = listadoEmpleados;
        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void grdListadoEmpleados_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
    {
        try
        {
            if (e.Parameters == "Grabar")
            {
                SearchEmpleado userGrabar = new SearchEmpleado(this.ToString(), new HotelBooking.HotelBookingDataContext());
                SCPV_Empleados user = new SCPV_Empleados();
                user.Apellidos = this.txtApellidos.Text;
                user.Nombres = this.txtNombres.Text;
                user.NumeroIdentificacion = this.txtIdentificacion.Text;
                user.Estado = this.cmbEstado.Value.ToString();
                user.ID_Cargo = int.Parse(this.cmbCargos.Value.ToString());
                userGrabar.addEmpleado(user);
                cargaInicialDatosEmpleados();
                this.grdListadoEmpleados.JSProperties["cpGrabar"] = "OK";
            }
            else if (e.Parameters == "Modificar") {
                SearchEmpleado userGrabar = new SearchEmpleado(this.ToString(), new HotelBooking.HotelBookingDataContext());
                SCPV_Empleados user = new SCPV_Empleados();
                user.Apellidos = this.txtApellidos.Text;
                user.Nombres = this.txtNombres.Text;
                user.NumeroIdentificacion = this.txtIdentificacion.Text;
                user.ID = int.Parse(this.txtIdCliente.Text);
                user.ID_Cargo = int.Parse(this.cmbCargos.Value.ToString());
                user.Estado = this.cmbEstado.Value.ToString(); 
                userGrabar.updateEmpleado(user);
                cargaInicialDatosEmpleados();
                this.grdListadoEmpleados.JSProperties["cpModificar"] = "OK";
            }
        }
        catch (Exception)
        {
            if (e.Parameters == "Grabar")
            {
                this.grdListadoEmpleados.JSProperties["cpGrabar"] = "ERROR";
            }
            else if (e.Parameters == "Modificar")
            {
                this.grdListadoEmpleados.JSProperties["cpModificar"] = "ERROR";
            }

                throw;
        }
    }




    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        try
        {
           
            this.cmbCargos.SelectedIndex = - 1;
            this.cmbEstado.SelectedIndex = 0;
            this.grdListadoEmpleados.Selection.UnselectAll();
        }
        catch (Exception)
        {

            throw;
        }
    }
}