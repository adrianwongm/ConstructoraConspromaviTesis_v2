<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="CatalogoConstrucciones.aspx.cs" Inherits="CatalogoConstrucciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" Runat="Server">
    <script src="Scripts/jquery-3.1.0.min.js"></script>
    <script>
        //Script de botoneras de movimientos de caracteristicas
        function btnAgregarCaracteristica_Click(s, e) {
            MoveSelectedItems(cmbCaracteristicas, lstCaracteristica);
        }

        function btnQuitarCaracteristica_Click(s, e) {
            RemoveSelectedItems(lstCaracteristica);
        }

        function RemoveSelectedItems(srcListBox) {
            srcListBox.BeginUpdate(); 
            var items = srcListBox.GetSelectedItems();
            for (var i = items.length - 1; i >= 0; i = i - 1) { 
                srcListBox.RemoveItem(items[i].index);
            }
            srcListBox.EndUpdate(); 
        }


        function MoveSelectedItems(srcComboBox, dstListBox) {
            var items = srcComboBox.GetSelectedItem();
            dstListBox.BeginUpdate();  
            if (dstListBox.FindItemByValue(items.value) == null) {
                dstListBox.AddItem(items.text, items.value);
            }
            else {
                alert("Esta caracteristica ya existe!");
            }
            
            dstListBox.EndUpdate();
        }

        function cmbArea_SelectedIndexChanged(s, e) {
            if (!(cmbCiudad.InCallback())) {
                cmbCiudad.PerformCallback("CARGAR|" + cmbArea.GetValue());
            }
        }

        function onFileUploadComplete(s, e) {
            alert(e.callbackData);
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
    <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ClientInstanceName="ASPxFormLayout1" Theme="SoftOrange">

        <Items>
            <dx:LayoutGroup ColCount="7">
                <Items>
                    <dx:LayoutItem Caption="Nombre">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox runat="server" ID="txtNombre" ClientInstanceName="txtNombre" Theme="SoftOrange" MaxLength="15" ></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>

                        <CaptionSettings Location="Top"></CaptionSettings>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Descripcion">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox runat="server" ID="txtDescripcion" ClientInstanceName="txtDescripcion" Theme="SoftOrange" MaxLength="50"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>

                        <CaptionSettings Location="Top"></CaptionSettings>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Nivel">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox runat="server" ID="cmbNivel" ClientInstanceName="cmbNivel" Theme="SoftOrange" >
                                    <Items>
                                        <dx:ListEditItem Text="Construccion" />
                                        <dx:ListEditItem Text="Servicio de obras" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>

                        <CaptionSettings Location="Top"></CaptionSettings>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Area">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox runat="server" ID="cmbArea" ClientInstanceName="cmbArea" Theme="SoftOrange"
                                    AutoPostBack="false" ValueField="ID" TextField="Area_Name" OnDataBinding="cmbArea_DataBinding" > 
                                    <ClientSideEvents SelectedIndexChanged="cmbArea_SelectedIndexChanged" />
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>

                        <CaptionSettings Location="Top"></CaptionSettings>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Caracteristicas">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox runat="server" ID="cmbCaracteristicas" ClientInstanceName="cmbCaracteristicas" Theme="SoftOrange"
                                    TextField="Feature_Name" ValueField="ID" >
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>

                        <CaptionSettings Location="Top"></CaptionSettings>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxButton runat="server" ID="btnAgregarCaracteristica" ClientInstanceName="btnAgregarCaracteristica" AutoPostBack="false"
                                                Text="->" UseSubmitBehavior="false" CausesValidation="false" Theme="SoftOrange">
                                                <ClientSideEvents Click="btnAgregarCaracteristica_Click" />
                                            </dx:ASPxButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxButton runat="server" ID="btnQuitarCaracteristica" ClientInstanceName="btnQuitarCaracteristica" AutoPostBack="false"
                                                Text="<-" UseSubmitBehavior="false" CausesValidation="false" Theme="SoftOrange">
                                                <ClientSideEvents Click="btnQuitarCaracteristica_Click" />
                                            </dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                           
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxListBox runat="server" ID="lstCaracteristica" ClientInstanceName="lstCaracteristica" 
                                    TextField="Feature_Name" Width="200px" Height="150px" SelectionMode="CheckColumn" Caption=""
                                    ValueField="ID"></dx:ASPxListBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Ciudad">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox runat="server" ID="cmbCiudad" ClientInstanceName="cmbCiudad" TextField="City_Name" OnDataBinding="cmbCiudad_DataBinding"
                                    ValueField="ID" AutoPostBack="false" Theme="SoftOrange" OnCallback="cmbCiudad_Callback">

                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem ColSpan="2">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" UploadMode="Auto" OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete"
                                    ShowProgressPanel="true" ShowUploadButton="true">
                                    <AdvancedModeSettings EnableMultiSelect="false" EnableFileList="True" EnableDragAndDrop="True" />
                                    <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg,.jpeg,.gif,.png" />
                                    <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                                </dx:ASPxUploadControl>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem>
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton runat="server" ID="ASPxFormLayout1_E10"></dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem>
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton runat="server" ID="ASPxFormLayout1_E11"></dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
            <dx:LayoutGroup></dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterControlsPlaceHolder" Runat="Server">
</asp:Content>

