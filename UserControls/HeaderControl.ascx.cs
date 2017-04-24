using HotelBooking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControls_HeaderControl : System.Web.UI.UserControl
{
    public SearchUsuario Usuario { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            visiblemenu();
        }
        catch (Exception)
        {

            throw;
        }
    }
    protected void btnLoginNow_Click(object sender, EventArgs e) {
        if(Captcha.IsValid)
            LogonControl.ShowOnPageLoad = false;
        //Carga de controles
        Usuario = new SearchUsuario(this.ToString(), new HotelBooking.HotelBookingDataContext());
        SCPV_Usuario_Empleados user  = Usuario.VerficaUsuario2(txtEmail.Text.Trim(), txtPassword.Text.Trim());

        Session["userCliente"] = user;

        visiblemenu();
    }

    public void visiblemenu() {
        if (Session["userCliente"] == null)
        {
            this.mMain.Visible = false;
            Login.Visible = true;
        }
        else
        {
            var UsuarioSessionVar = (SCPV_Usuario_Empleados)Session["userCliente"];
            if (UsuarioSessionVar.ID_Empleado > 0)
            {
                this.mMain.Visible = true;
                Login.Visible = false;
            }
            else
            {
                this.mMain.Visible = false;
                Login.Visible = true;
            }
        }
    }
}
