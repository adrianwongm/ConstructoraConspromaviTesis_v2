<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="CatalogoImagenesConstruccion.aspx.cs" Inherits="CatalogoImagenesConstruccion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="Server">
    <script src="Scripts/Demo.js"></script>
    <style type="text/css">
        .uploadContainer {
            float: left;
            margin-right: 80px;
        }

        .contentFooter {
            clear: both;
            padding-top: 20px;
        }
    </style>
    <script type="text/javascript">
        function onFilesUploadStart(s, e) {
            DXUploadedFilesContainer.Clear();
            if (cmbConstruccion.GetValue() != undefined && cmbConstruccion.GetValue() != null && cmbConstruccion.GetValue() != "") {
                UploadControl.cpConstruccion = cmbConstruccion.GetValue();
            }
            else {
                alert("Seleccione una construccion, para subir la imagen");
                UploadControl.Cancel();
                e.processOnServer = false;
            }
        }

        function onFileUploadComplete(s, e) {
            if (e.callbackData) {
                var fileData = e.callbackData.split('|');
                var fileName = fileData[0],
                    fileUrl = fileData[1],
                    fileSize = fileData[2];
                DXUploadedFilesContainer.AddFile(fileName, fileUrl, fileSize);
            }
        }

        function onFilesUploadComplete(s, e) {
            if (e.callbackData == "GRABAR_OK") {
                if (!(grdFiles.InCallback())) {
                    grdFiles.PerformCallback("Grabar");
                    DXUploadedFilesContainer.Clear();
                }
            }
        }

        function OnMoreInfoClick(contentUrl) {
            //clientPopupControl.SetContentUrl(contentUrl);
            imgConstruccion.SetImageUrl(contentUrl);
            clientPopupControl.Show();
        }

        function btnConsultar_Click(s, e) {
            if (!(grdFiles.InCallback())) {
                if (cmbConstruccion.GetValue() != undefined && cmbConstruccion.GetValue() != null && cmbConstruccion.GetValue() != "") {
                    grdFiles.PerformCallback("Cargar");
                }
                else {
                    alert("Por favor, seleccione una obra/ construccion");
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="Server">
    <div>
        <table>
        </table>

    </div>
    <div class="uploadContainer">

        <dx:ASPxFormLayout ID="ASPxFormLayout1" Theme="SoftOrange" runat="server">
            <Items>
                <dx:LayoutGroup ColCount="4" Caption="Configuracion de Imagenes">
                    <Items>
                        <dx:LayoutItem Caption="Construccion" Width="20%">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <table>
                                        <tr>
                                            <td>
                                                <dx:ASPxComboBox Theme="SoftOrange"
                                                    ID="cmbConstruccion" runat="server" ClientInstanceName="cmbConstruccion" OnInit="cmbConstruccion_Init"
                                                    TextField="Hotel_Name" ValueField="ID" OnDataBinding="cmbConstruccion_DataBinding">
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td>
                                                <dx:ASPxButton runat="server" Theme="SoftOrange" ID="btnConsultar" UseSubmitBehavior="false" CausesValidation="false"
                                                    AutoPostBack="false" ClientInstanceName="btnConsultar" Text="...">
                                                    <ClientSideEvents Click="btnConsultar_Click" />
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="" Width="10%">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings Location="Top" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Carga de Archivos" Width="35%">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">

                                    <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="UploadControl" Width="320"
                                        NullText="Select multiple files..." UploadMode="Advanced" ShowUploadButton="True" ShowProgressPanel="True"
                                        OnCustomJSProperties="UploadControl_CustomJSProperties"
                                        OnFileUploadComplete="UploadControl_FileUploadComplete" OnFilesUploadComplete="UploadControl_FilesUploadComplete">
                                        <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="True" EnableDragAndDrop="True" />
                                        <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg,.jpeg,.gif,.png">
                                        </ValidationSettings>
                                        <ClientSideEvents
                                            FilesUploadStart="onFilesUploadStart"
                                            FileUploadComplete="onFileUploadComplete"
                                            FilesUploadComplete="onFilesUploadComplete" />
                                    </dx:ASPxUploadControl>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <CaptionSettings Location="Top" />
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Archivos" Width="35%">
                            <CaptionSettings Location="Top" />
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">

                                    <dx:ASPxGridView Theme="SoftOrange" ID="grdFiles" Width="500px" OnRowDeleting="grdFiles_RowDeleting" KeyboardSupport="true"
                                        KeyFieldName="ID"
                                        ClientInstanceName="grdFiles" runat="server" OnDataBinding="grdFiles_DataBinding" OnCustomCallback="grdFiles_CustomCallback">
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowDeleteButton="true"></dx:GridViewCommandColumn>
                                            <dx:GridViewDataColumn FieldName="ID" Caption="ID"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Descripcion" Caption="Construccion"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="Picture_Id" Caption="Imagen"></dx:GridViewDataColumn>
                                            <dx:GridViewDataTextColumn Caption="More Info" UnboundType="String" VisibleIndex="6">
                                                <DataItemTemplate>
                                                    <dx:ASPxHyperLink ID="hyperLink" runat="server" OnInit="hyperLink_Init">
                                                    </dx:ASPxHyperLink>
                                                </DataItemTemplate>
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                        <SettingsPager PageSize="5"></SettingsPager>
                                    </dx:ASPxGridView>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
                <dx:LayoutGroup Caption="" ShowCaption="False" GroupBoxDecoration="HeadingLine">
                    <Items>
                        <dx:LayoutItem Caption="" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <div style="display: none">
                                        <dx:UploadedFilesContainer ID="FileContainer" runat="server" Width="380" Height="180"
                                            NameColumnWidth="240" SizeColumnWidth="70" HeaderText="Uploaded files" />
                                    </div>
                                    <br /> 
                                    <p class="note">
                                        <dx:ASPxLabel ID="AllowedFileExtensionsLabel" runat="server" Text="Allowed file extensions: .jpg, .jpeg, .gif, .png." Font-Size="8pt">
                                        </dx:ASPxLabel>
                                        <br />
                                        <dx:ASPxLabel ID="MaxFileSizeLabel" runat="server" Text="Maximum file size: 4 MB." Font-Size="8pt">
                                        </dx:ASPxLabel>
                                    </p>

                                    <div class="contentFooter">
                                        <p class="Note">
                                            <b>Note</b>: Todos los archivos seran guardados automaticamente al momento de subir las imagenes.
                                        </p>
                                    </div>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
            </Items>
        </dx:ASPxFormLayout>


    </div>

    

    <dx:ASPxPopupControl ID="popupControl" runat="server" HeaderText="Visor de imagenes" Theme="SoftOrange"
        ClientInstanceName="clientPopupControl" CloseAction="CloseButton" Height="200px" Modal="True"
        Width="850px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxImage ClientInstanceName="imgConstruccion" runat="server" ID="imgConstruccion" Theme="SoftOrange"></dx:ASPxImage>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterControlsPlaceHolder" runat="Server">
</asp:Content>
