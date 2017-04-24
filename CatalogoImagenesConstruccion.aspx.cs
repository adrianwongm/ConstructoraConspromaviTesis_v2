using DevExpress.Web;
using HotelBooking;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CatalogoImagenesConstruccion : System.Web.UI.Page
{
    public List<Hotel> listadoHoteles
    {
        get
        {
            return (List<Hotel>)Session["listadoHoteles"];
        }
        set
        {
            Session["listadoHoteles"] = value;
        }
    }

    public List<SP_SCPV_ObtenerListadoImagenResult> listadoImagenesConstrucciones
    {
        get
        {
            return (List<SP_SCPV_ObtenerListadoImagenResult>)Session["listadoImagenesConstrucciones"];
        }
        set
        {
            Session["listadoImagenesConstrucciones"] = value;
        }
    }

    public List<string> listadoArhivos
    {
        get
        {
            return (List<string>)Session["listadoArhivos"];
        }
        set
        {
            Session["listadoArhivos"] = value;
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {

            this.cmbConstruccion.DataSource = listadoHoteles;
        }
        catch (Exception)
        {
             
        }
    }

        protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!(IsPostBack))
            {
                listadoArhivos = new List<string>();
                listadoArhivos.Clear();
                obtenerHoteles();
                UploadControl.JSProperties.Add("cpConstruccion", "");
                Session["ConstuccionIDImagen"] = 0;
            }
            
        }
        catch (Exception)
        {

            throw;
        }
    }


    private void obtenerHoteles()
    {
        try
        {
            HotelBookingDataContext context = new HotelBookingDataContext();
            listadoHoteles = (from p in context.Hotels
                                    select p).ToList();

            this.cmbConstruccion.DataSource = listadoHoteles;
            this.cmbConstruccion.DataBind();
        }
        catch (Exception ex)
        {

            throw;
        }
    }

    protected void cmbConstruccion_DataBinding(object sender, EventArgs e)
    {
        if(listadoHoteles != null)
        {
            this.cmbConstruccion.DataSource = listadoHoteles;
        }
    }

    const string UploadDirectory = "~/Content/Pictures/";
    private bool error_archivo = false;
    protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
    {
        try
        {
           if ( Session["ConstuccionIDImagen"] == null){
                return;
            }
            string resultExtension = Path.GetExtension(e.UploadedFile.FileName);
            string resultFileName = e.UploadedFile.FileName;// Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
            string resultFileUrl = UploadDirectory + resultFileName;
            string resultFilePath = MapPath(resultFileUrl);
            e.UploadedFile.SaveAs(resultFilePath);

            UploadingUtils.RemoveFileWithDelay(resultFileName, resultFilePath, 5);

            string name = e.UploadedFile.FileName;
            string url = ResolveClientUrl(resultFileUrl);
            long sizeInKilobytes = e.UploadedFile.ContentLength / 1024;
            string sizeText = sizeInKilobytes.ToString() + " KB";
            e.CallbackData = name + "|" + url + "|" + sizeText;
            listadoArhivos.Add(e.CallbackData +"|"+ Session["ConstuccionIDImagen"].ToString());
        }
        catch (Exception)
        { 
            throw;
        } 
    }

    protected void hyperLink_Init(object sender, EventArgs e)
    {
        ASPxHyperLink link = (ASPxHyperLink)sender;

        GridViewDataItemTemplateContainer templateContainer = (GridViewDataItemTemplateContainer)link.NamingContainer;

        int rowVisibleIndex = templateContainer.VisibleIndex;
        string ID = templateContainer.Grid.GetRowValues(rowVisibleIndex, "ID").ToString();
        string Image = templateContainer.Grid.GetRowValues(rowVisibleIndex, "Picture_Id").ToString();
        string contentUrl = string.Format("/Content/Pictures/{0}", Image);

        link.NavigateUrl = "javascript:void(0);";
        link.Text = string.Format("Ver");
        link.ClientSideEvents.Click = string.Format("function(s, e) {{ OnMoreInfoClick('{0}'); }}", contentUrl);
    }

    protected void grdFiles_DataBinding(object sender, EventArgs e)
    {
        if (listadoImagenesConstrucciones != null)
        {
            this.grdFiles.DataSource = listadoImagenesConstrucciones;
        }
    }

    protected void grdFiles_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
    {
        if (e.Parameters == "Cargar")
        {
            cargaMallaArchivos();
        }
        else if (e.Parameters == "Grabar") {
            grabarArchivos();
        } 
    }

    private void grabarArchivos()
    {
        Hotel a = new Hotel();
        Picture pPicture = new Picture();
        int Cons = 0;
        foreach (var item in listadoArhivos)
        {
          var param =  item.Split('|');
            pPicture = new Picture();
            pPicture.Picture_Id = param[0];
            pPicture.Room_ID = null;
            Cons = int.Parse(param[3]);
            pPicture.Hotel_ID = Cons;
            a.GrabarImagenes(pPicture);
        }
        listadoArhivos.Clear();
        cargaMallaArchivos();
    }

    private void cargaMallaArchivos(int pID = 0)
    {
        try
        {
            HotelBookingDataContext context = new HotelBookingDataContext();
            Hotel a = new Hotel();
            Session["ConstuccionIDImagen"] = 0;
            int id = 0;
            int.TryParse(this.cmbConstruccion.Value.ToString(), out id);
            
            if(pID > 0)
            {
                id = pID;
            }
            if(id > 0)
            {
                this.grdFiles.DataSource = listadoImagenesConstrucciones = a.obtenerListadoImagenesHoteles(id);
                Session["ConstuccionIDImagen"] = id;
            }
            this.grdFiles.DataBind();
        }
        catch (Exception)
        {

            throw;
        }
    }

    protected void UploadControl_FilesUploadComplete(object sender, FilesUploadCompleteEventArgs e)
    {
        try
        {
            if (this.listadoArhivos.Count > 0) {
                e.CallbackData = "GRABAR_OK";
            } 
        }
        catch (Exception)
        {

            throw;
        }
         
    }

    protected void cmbConstruccion_Init(object sender, EventArgs e)
    {
        if (listadoHoteles != null)
        {
            this.cmbConstruccion.DataSource = listadoHoteles;
        }
    }

    protected void UploadControl_CustomJSProperties(object sender, CustomJSPropertiesEventArgs e)
    {
       
    }

    protected void grdFiles_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
    {
        try
        {
            int iKey = int.Parse(e.Keys[0].ToString());
            Hotel pH = new Hotel();
            if(pH.EliminarImagenes(iKey))
                cargaMallaArchivos();

            e.Cancel = true;
            ((ASPxGridView)sender).CancelEdit();
        }
        catch (Exception)
        {

            throw;
        }
    }
}