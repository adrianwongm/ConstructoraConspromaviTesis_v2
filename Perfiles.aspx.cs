using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HotelBooking;
using System.Web.Script.Serialization;

public partial class Perfiles : System.Web.UI.Page
{
    public List<SCPV_Perfiles> listadoPerfiles
    {
        get
        {
            return (List<SCPV_Perfiles>)Session["listadoPerfiles"];
        }
        set
        {
            Session["listadoPerfiles"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Session["UsuarioLogin"] = "ADMIN";
        if (!IsPostBack)
        {
            if (Session["UsuarioLogin"] == null)
            {
                salir();
            }
            cargaMallaPerfiles();
        }
        if (Session["UsuarioLogin"] == null)
        {
            salir();
        }
        this.ASPxGridView1.DataBind();
    }

    private void cargaMallaPerfiles()
    {
        SearchPerfiles oSearchUsuario = new SearchPerfiles(this.ToString(), new HotelBooking.HotelBookingDataContext());
        listadoPerfiles = oSearchUsuario.getListPerfiles("A");
        this.ASPxGridView1.DataSource = listadoPerfiles;
        this.ASPxGridView1.DataBind();
    }

    private void salir()
    {
        Response.Redirect("http://conspromavi.facturitas.com/default.aspx");
    }

    protected void btnNuevo_Click(object sender, EventArgs e)
    {
        limpiar(btnNuevo.Text);
    }

    private void limpiar(string origenOpcion)
    {
        try
        {
            if (origenOpcion == btnNuevo.Text)
            {
                this.btnNuevo.ClientEnabled = false;
                this.btnGrabar.ClientEnabled = true;
                this.btnModificar.ClientEnabled = false;
            }
            if (origenOpcion == btnCancelar.Text)
            {
                this.btnNuevo.ClientEnabled = true;
                this.btnGrabar.ClientEnabled = false;
                this.btnModificar.ClientEnabled = false;

            }
            this.tbCodigo.Text = "";
            this.tbDescripcion.Text = "";
            this.tbCodigo.ReadOnly = false;
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
            SCPV_Perfiles oPerfil = new SCPV_Perfiles();
            oPerfil.Codigo = this.tbCodigo.Text;
            oPerfil.Descripcion = this.tbDescripcion.Text;
            oPerfil.Estado = this.cmbEstado.Value.ToString();
            oPerfil.UsuarioCreacion = "ADMIN";
            oPerfil.FechaCreacion = DateTime.Now;
            SearchPerfiles oSearchUsuario = new SearchPerfiles(this.ToString(), new HotelBooking.HotelBookingDataContext());
            if (oSearchUsuario.addPerfiles(oPerfil))
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.onload=function(){");
                sb.Append("avisoGrabacion('");
                sb.Append("OK','" + oPerfil.Codigo.ToString());
                sb.Append("')};");
                sb.Append("</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
                cargaMallaPerfiles();
                limpiar(this.btnCancelar.Text);
            }
            else
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.onload=function(){");
                sb.Append("avisoGrabacion('");
                sb.Append("ERROR',' ERROR AL GENERAR LA CATEGORIA");
                sb.Append("')};");
                sb.Append("</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
            }
        }
        catch (Exception ex)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("avisoGrabacion('");
            sb.Append("ERROR',' ERROR AL GENERAR LA CATEGORIA - " + ex.Message);
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }
    
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        try
        {
            SCPV_Perfiles oPerfil = new SCPV_Perfiles();
            oPerfil.Codigo = this.tbCodigo.Text;
            oPerfil.Descripcion = this.tbDescripcion.Text;
            oPerfil.Estado = this.cmbEstado.Value.ToString();
            oPerfil.UsuarioModificacion = "ADMIN";
            oPerfil.FechaModificacion = DateTime.Now;
            SearchPerfiles oSearchUsuario = new SearchPerfiles(this.ToString(), new HotelBooking.HotelBookingDataContext());
            if (oSearchUsuario.updatePerfiles(oPerfil))
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.onload=function(){");
                sb.Append("avisoModificacion('");
                sb.Append("OK','" + oPerfil.Codigo.ToString());
                sb.Append("')};");
                sb.Append("</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
                cargaMallaPerfiles();
                limpiar(this.btnCancelar.Text);
            }
            else
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.onload=function(){");
                sb.Append("avisoModificacion('");
                sb.Append("ERROR',' ERROR AL GENERAR EL PRODUCTO");
                sb.Append("')};");
                sb.Append("</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
            }
        }
        catch (Exception ex)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("avisoModificacion('");
            sb.Append("ERROR',' ERROR AL GENERAR EL PRODUCTO - " + ex.Message);
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        } 
    }

    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        limpiar(btnCancelar.Text);
    }

    protected void ASPxGridView1_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
    {
        try
        {
            if (e.Parameters.Contains("CARGA_DATOS"))
            {
                string[] datos = e.Parameters.Split('|');
                var codigo = int.Parse(datos[1]);
                SCPV_Perfiles perfil = this.listadoPerfiles.Where(x => x.ID == codigo).FirstOrDefault();
                this.ASPxGridView1.JSProperties["cpPerfil"] = new JavaScriptSerializer().Serialize(perfil);
            }
        }
        catch (Exception ex)
        {
            // funcionControlErrores(ex.Message + " -TRACE: " + ex.StackTrace);
        }
    }

    protected void ASPxGridView1_DataBinding(object sender, EventArgs e)
    {
        if (this.listadoPerfiles != null)
        {
            ASPxGridView1.DataSource = this.listadoPerfiles;
        }
    }

    protected void ASPxGridView1_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
    {
        try
        {
            if (this.listadoPerfiles.Count > 0)
            {
                int key = int.Parse(e.Keys[0].ToString());
                SCPV_Perfiles oPerfil = listadoPerfiles.Where(p => p.ID == key).FirstOrDefault();
                oPerfil.UsuarioModificacion = "ADMIN";
                oPerfil.FechaModificacion = DateTime.Now;
                oPerfil.Estado = "I";
                SearchPerfiles oSearchUsuario = new SearchPerfiles(this.ToString(), new HotelBooking.HotelBookingDataContext());
                if (oSearchUsuario.updatePerfiles(oPerfil)) { 
                    cargaMallaPerfiles();
                }
            }
            e.Cancel = true;
        }
        catch (Exception ex)
        {
           // funcionControlErrores(ex.Message + " -TRACE: " + ex.StackTrace);
        }
    } 

    protected void btnEditar_Init(object sender, EventArgs e)
    {
        try
        {
            ASPxButton button = (ASPxButton)sender;
            GridViewDataItemTemplateContainer container = button.NamingContainer as GridViewDataItemTemplateContainer;
            int codigo = Convert.ToInt32(container.KeyValue);
            button.ClientSideEvents.Click = String.Format("function(s, e) {{ editar('{0}','{1}'); }}", codigo.ToString(), container.VisibleIndex);
        }
        catch (Exception ex)
        {
           // funcionControlErrores(ex.Message + " -TRACE: " + ex.StackTrace);
        }
    }

}