using HotelBooking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Clientes : System.Web.UI.Page
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

    public List<HotelBooking.SCPV_Diccionario> listadoTipoDocumento
    {
        get
        {
            return (List<HotelBooking.SCPV_Diccionario>)Session["listadoTipoDocumento"];
        }
        set
        {
            Session["listadoTipoDocumento"] = value;
        }
    }

    public List<HotelBooking.SCPV_Clientes> listadoClientes
    {
        get
        {
            return (List<HotelBooking.SCPV_Clientes>)Session["listadoClientes"];
        }
        set
        {
            Session["listadoClientes"] = value;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            cargaInicialDatosClientes();
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
        listadoTipoDocumento = oTipoDocumento.getListadoDiccionarios(2);
        this.cmbTipoDocumento.DataSource = listadoTipoDocumento;
        this.cmbTipoDocumento.DataBind();
    }

    private void cargaInicialDatosClientes()
    {
        SearchClientes oSearchClientes = new SearchClientes(this.ToString(), new HotelBooking.HotelBookingDataContext());
        listadoClientes = oSearchClientes.getListClientes("A");
        this.grdListadoClientes.DataSource = listadoClientes;
        this.grdListadoClientes.DataBind();
    }



    protected void grdListadoClientes_DataBinding(object sender, EventArgs e)
    {
        try
        {
            this.grdListadoClientes.DataSource = listadoClientes;
        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void grdListadoClientes_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
    {
        try
        {
            if (e.Parameters == "Grabar")
            {
                SearchClientes userGrabar = new SearchClientes(this.ToString(), new HotelBooking.HotelBookingDataContext());
                SCPV_Clientes user = new SCPV_Clientes();
                user.Apellidos = this.txtApellidos.Text;
                user.Nombres = this.txtNombres.Text;
                user.Identificacion = this.txtIdentificacion.Text;
                user.Ciudad = this.txtCiudad.Text;
                user.Direccion = this.txtDireccion.Text;
                user.Referencia = this.txtReferenciaDireccion.Text;
                user.TelefonoConvencional = this.txtconvencional.Text;
                user.TelefonoCelurares = this.txtcelular.Text;
                user.Login = this.txtUsuario.Text;
                user.Password = this.txtPassword.Text;
                user.Estado = this.cmbEstado.Value.ToString();
                user.TipoIdentificacion = this.cmbTipoDocumento.Value.ToString();
                userGrabar.addCliente(user);
              cargaInicialDatosClientes();
                this.grdListadoClientes.JSProperties["cpGrabar"] = "OK";
            }
            else if (e.Parameters == "Modificar") {
                SearchClientes userGrabar = new SearchClientes(this.ToString(), new HotelBooking.HotelBookingDataContext());
                SCPV_Clientes user = new SCPV_Clientes();
                
                user.Apellidos = this.txtApellidos.Text;
                user.Nombres = this.txtNombres.Text;
                user.Identificacion = this.txtIdentificacion.Text;
                user.Ciudad = this.txtCiudad.Text;
                user.Direccion = this.txtDireccion.Text;
                user.Referencia = this.txtReferenciaDireccion.Text;
                user.TelefonoConvencional = this.txtconvencional.Text;
                user.TelefonoCelurares = this.txtcelular.Text;
                user.Login = this.txtUsuario.Text;
                user.ID_Cliente = long.Parse(this.txtIdCliente.Text);
                user.Password = this.txtPassword.Text;
                user.TipoIdentificacion = this.cmbTipoDocumento.Value.ToString();
                user.Estado = this.cmbEstado.Value.ToString(); 
                userGrabar.updateCliente(user);
                cargaInicialDatosClientes();
                this.grdListadoClientes.JSProperties["cpModificar"] = "OK";
            }
        }
        catch (Exception)
        {
            if (e.Parameters == "Grabar")
            {
                this.grdListadoClientes.JSProperties["cpGrabar"] = "ERROR";
            }
            else if (e.Parameters == "Modificar")
            {
                this.grdListadoClientes.JSProperties["cpModificar"] = "ERROR";
            }

                throw;
        }
    }




    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        try
        {
            this.txtPassword.Text = "";
            this.txtUsuario.Text = "";
            this.cmbTipoDocumento.SelectedIndex = - 1;
            this.cmbEstado.SelectedIndex = 0;
            this.grdListadoClientes.Selection.UnselectAll();
        }
        catch (Exception)
        {

            throw;
        }
    }
}