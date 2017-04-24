using HotelBooking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CambiarPassword : System.Web.UI.Page
{
    public SCPV_Usuario_Empleados usuario
    {
        get
        {
            return (SCPV_Usuario_Empleados)Session["userCliente"]; ;
        }
        
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!(IsPostBack))
            {
                this.txtUsuario.Text = usuario.Usuario;
            }

        }
        catch (Exception)
        {

            throw;
        }
    }

    private void limpiar()
    {
        try
        {
            this.txtUsuario.Text = usuario.Usuario;
            this.txtPassActual.Text = "";
            this.txtPassNueva.Text = "";
            this.txtPassNuevaRepetir.Text = "";
        }
        catch (Exception)
        {

            throw;
        }
    }
    protected void btnGrabar_Click(object sender, EventArgs e)
    {
        try
        {
            string pCodigo = usuario.Usuario;
            string pLogin = usuario.Usuario;
            string pPasswordActual = this.txtPassActual.Text.Trim();
            string pPasswordNueva = this.txtPassNueva.Text.Trim();
            string pPasswordNuevaRepetir = this.txtPassNuevaRepetir.Text.Trim();
            string pEstado = "A";

            if (pPasswordNueva == pPasswordNuevaRepetir)
            {
                SearchUsuario userGrabar = new SearchUsuario(this.ToString(), new HotelBooking.HotelBookingDataContext());
                SCPV_Usuario_Empleados user = new SCPV_Usuario_Empleados();
                user.Usuario = pLogin;
                user.Password = pPasswordNueva;
                user.Estado = pEstado; 
                if (userGrabar.updateUsuario(user))
                {
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("<script type = 'text/javascript'>");
                    sb.Append("window.onload=function(){");
                    sb.Append("avisoModificacion('");
                    sb.Append("OK','" + pLogin);
                    sb.Append("')};");
                    sb.Append("</script>");
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
                }
                else
                {
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("<script type = 'text/javascript'>");
                    sb.Append("window.onload=function(){");
                    sb.Append("avisoModificacion('");
                    sb.Append("ERROR',' ERROR AL GENERAR EL CAMBIO DE CLAVE");
                    sb.Append("')};");
                    sb.Append("</script>");
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
                }
            }
        }
        catch (Exception ex)
        {
           
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("avisoModificacion('");
            sb.Append("ERROR',' ERROR AL GENERAR EL CAMBIO DE CLAVE - " + ex.Message);
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }

    }

    

    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        try
        {
            limpiar();
        }
        catch (Exception)
        {

            throw;
        }
    }
}