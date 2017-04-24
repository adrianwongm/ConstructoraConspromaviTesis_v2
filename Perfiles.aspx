<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Perfiles.aspx.cs" Inherits="Perfiles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" Runat="Server">
    <script src="Scripts/jquery-3.1.0.min.js"></script>

    <script> 

        function sampleGrid_RowDblClick(s, e) {
            sampleGrid.GetSelectedFieldValues('Codigo;Descripcion;Estado', OnGetSelectedFieldValuesCommodities);
        }

        function OnGetSelectedFieldValuesCommodities(selectedValues) {
            if (selectedValues.length == 0) return;
            for (i = 0; i < selectedValues.length; i++) { 
                tbCodigo.SetText(selectedValues[i][0]);
                tbDescripcion.SetText(selectedValues[i][1]);
                cmbEstado.SetValue(selectedValues[i][2]);
                btnNuevo.SetEnabled(false);
                btnGrabar.SetEnabled(false);
                btnModificar.SetEnabled(true);
                tbCodigo.GetInputElement().readOnly = true;
            }
        }

        function avisoGrabacion(mensaje, numProveedor) {
            if (mensaje == "OK") {
                alert(mensaje + "PROVEEDOR: " + numProveedor);
            }
            else if (mensaje == "ERROR") {
                alert(numProveedor);
            }
        }

        function avisoModificacion(mensaje, numProveedor) {
            if (mensaje == "OK") {
                //Imprimir
                alert(mensaje + " MODIFICACION DE PRODUCTO : " + numProveedor);
            }
            else if (mensaje == "ERROR") {
                alert(numProveedor);
            }
        }

        function editar(codigo, VisibleIndex) {
            sampleGrid.UnselectAllRowsOnPage();
            sampleGrid.SelectRowOnPage(VisibleIndex);
            if (!sampleGrid.InCallback()) {
                sampleGrid.PerformCallback("CARGA_DATOS|" + codigo);
            }
        }

        function UpdateGridHeight() {
            sampleGrid.SetHeight(0);
            var containerHeight = ASPxClientUtils.GetDocumentClientHeight();
            if (document.body.scrollHeight > containerHeight)
                containerHeight = document.body.scrollHeight;
            sampleGrid.SetHeight(containerHeight);
        }

        function btnGrabar_Click(s, e) {

            if (tbCodigo.GetText().trim() == "") {
                e.processOnServer = false;
                alert("ingrese el codigo");
                tbCodigo.SetFocus();
                return false;
            }
            if (tbDescripcion.GetText().trim() == "") {
                e.processOnServer = false;
                alert("ingrese la descripcion");
                tbDescripcion.SetFocus();
                return false;
            }
        }

        function btnModificar_Click(s, e) {

            if (tbCodigo.GetText().trim() == "") {
                e.processOnServer = false;
                alert("ingrese el codigo");
                tbCodigo.SetFocus();
                return false;
            }
            if (tbDescripcion.GetText().trim() == "") {
                e.processOnServer = false;
                alert("ingrese la descripcion");
                tbDescripcion.SetFocus();
                return false;
            }

        }

        function sampleGrid_EndCallback(s, e) {
            //Objeto de retorno cpPerfil
            if (sampleGrid.cpPerfil != null && sampleGrid.cpPerfil != undefined && sampleGrid.cpPerfil != "") {
                //ASPxClientEdit.ClearEditorsInContainer(formLayout.GetMainElement()); //formLayout.GetMainElement()
                var objPerfil = JSON.parse(sampleGrid.cpPerfil);
                tbCodigo.SetText(objPerfil.Codigo);
                tbDescripcion.SetText(objPerfil.Descripcion);
                cmbEstado.SetValue(objPerfil.Estado);
                sampleGrid.cpPerfil = "";
                btnNuevo.SetEnabled(false);
                btnGrabar.SetEnabled(false);
                btnModificar.SetEnabled(true);
                tbCodigo.GetInputElement().readOnly = true;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

    <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" Theme="SoftOrange" ClientInstanceName="formLayout"> 
        <Items>
            <dx:LayoutGroup ColCount="5">
                <Items>
                    <dx:LayoutItem ShowCaption="True" Caption="Codigo">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox runat="server" ID="tbCodigo" ClientInstanceName="tbCodigo"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top"></CaptionSettings>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Descripcion" ShowCaption="True">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox runat="server" ID="tbDescripcion" ClientInstanceName="tbDescripcion"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection> 
                        <CaptionSettings Location="Top"></CaptionSettings>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Estado">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox runat="server" ID="cmbEstado" ClientInstanceName="cmbEstado">
                                    <Items>
                                        <dx:ListEditItem Value="A" Text="Activo" Selected="true" />
                                        <dx:ListEditItem Value="I" Text="Inactivo"   />
                                    </Items>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection> 
                        <CaptionSettings Location="Top"></CaptionSettings>
                    </dx:LayoutItem>
                  <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" Width="100%">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <table>
                                    <tr>
                                        <td style="padding-right: 10px">
                                            <dx:ASPxButton runat="server" Text="Nuevo" Theme="SoftOrange" ID="btnNuevo" CausesValidation="false" UseSubmitBehavior="false" AutoPostBack="true"
                                                ClientInstanceName="btnNuevo" OnClick="btnNuevo_Click">
                                                <%--<ClientSideEvents Click="btnNuevo_Click" />--%>
                                            </dx:ASPxButton>
                                        </td>
                                        <td style="padding-right: 10px">
                                            <dx:ASPxButton runat="server" Text="Grabar" Theme="SoftOrange" ID="btnGrabar" CausesValidation="true" UseSubmitBehavior="false" AutoPostBack="true"
                                                ClientInstanceName="btnGrabar" ClientEnabled="false" OnClick="btnGrabar_Click">
                                                <ClientSideEvents Click="btnGrabar_Click" />
                                            </dx:ASPxButton>
                                        </td>
                                        <td style="padding-right: 10px">
                                            <dx:ASPxButton runat="server" Text="Modificar" Theme="SoftOrange" ID="btnModificar" OnClick="btnModificar_Click"
                                                ClientInstanceName="btnModificar" CausesValidation="true" UseSubmitBehavior="false" AutoPostBack="true"
                                                ClientEnabled="false">
                                                <ClientSideEvents Click="btnModificar_Click" />
                                            </dx:ASPxButton>
                                        </td>
                                        <td style="padding-right: 10px">
                                            <dx:ASPxButton runat="server" Text="Cancelar" Theme="SoftOrange" ID="btnCancelar" CausesValidation="false"
                                                UseSubmitBehavior="false" AutoPostBack="true" OnClick="btnCancelar_Click"
                                                ClientInstanceName="btnCancelar">
                                                <%--<ClientSideEvents Click="btnCancelar_Click" />--%>
                                            </dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>

            <dx:LayoutGroup ShowCaption="False" ColCount="4" GroupBoxDecoration="HeadingLine" UseDefaultPaddings="false">
                <Items>
                    <dx:LayoutItem ShowCaption="False" Width="100%">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxGridView runat="server" Width="100%" ID="ASPxGridView1" ClientInstanceName="sampleGrid" Theme="SoftOrange"
                                    OnDataBinding="ASPxGridView1_DataBinding" OnCustomCallback="ASPxGridView1_CustomCallback" OnRowDeleting="ASPxGridView1_RowDeleting"
                                    AutoGenerateColumns="False" KeyFieldName="ID" EnableRowsCache="false">
                                    <%--<Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="300" />--%>
                                    <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true"></SettingsAdaptivity>
                                    <EditFormLayoutProperties>
                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="100" />
                                    </EditFormLayoutProperties>
                                     <SettingsBehavior AllowSelectSingleRowOnly="true" AllowFocusedRow="true" AllowSelectByRowClick="true"  />
                                    <ClientSideEvents EndCallback="sampleGrid_EndCallback" RowDblClick="sampleGrid_RowDblClick" />
                                    <Columns>

                                        <dx:GridViewCommandColumn ShowNewButtonInHeader="false" ShowDeleteButton="true" ShowEditButton="false" Width="15%" />
                                        <dx:GridViewDataTextColumn FieldName="Codigo" Width="40%"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Descripcion" AdaptivePriority="4" Width="15%" />
                                        <dx:GridViewDataTextColumn FieldName="Estado" AdaptivePriority="4" Width="15%" />
                                        <dx:GridViewDataColumn Name="DataColumn" Caption="Editar" Width="5%" AdaptivePriority="4">
                                            <EditFormSettings Visible="False" />
                                            <DataItemTemplate>
                                                <dx:ASPxButton RenderMode="Link" Text="Editar" runat="server" AutoPostBack="false" UseSubmitBehavior="false" CausesValidation="false"
                                                    ClientInstanceName="btnEditar" OnInit="btnEditar_Init">
                                                </dx:ASPxButton>
                                            </DataItemTemplate>
                                        </dx:GridViewDataColumn>
                                    </Columns>
                                    <SettingsPager PageSize="6" NumericButtonCount="6" />
                                    <Styles>
                                        <Cell Wrap="False"></Cell>
                                    </Styles>
                                    <Settings ShowFooter="True" />
                                    <Styles>
                                        <Footer Font-Bold="true" Font-Size="Large"></Footer>
                                    </Styles>
                                    <SettingsBehavior ConfirmDelete="true" />
                                    <SettingsText ConfirmDelete="Esta seguro que desea borrar el proveedor?" />
                                </dx:ASPxGridView>
                                <script type="text/javascript">
                                    // <![CDATA[
                                    ASPxClientControl.GetControlCollection().ControlsInitialized.AddHandler(function (s, e) {
                                        UpdateGridHeight();
                                    });
                                    ASPxClientControl.GetControlCollection().BrowserWindowResized.AddHandler(function (s, e) {
                                        UpdateGridHeight();
                                    });
                                    // ]]>
                                </script>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterControlsPlaceHolder" Runat="Server">
</asp:Content>

