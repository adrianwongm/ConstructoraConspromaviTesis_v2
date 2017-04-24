<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Clientes.aspx.cs" Inherits="Clientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" Runat="Server">
    <script type="text/javascript">
        function btnGrabar_Click(s, e) {
            if (modificacion == false) {
                grdListadoClientes.PerformCallback("Grabar");
            } else {
                grdListadoClientes.PerformCallback("Modificar");
            }
            
        }

        function grdListadoClientes_EndCallback(s, e) {
            if (grdListadoClientes.cpGrabar == "OK") {
                alert("Registro grbado correctamente.");
                grdListadoClientes.cpGrabar = "";
                limpiar();
                return;
            }
            else if (grdListadoClientes.cpGrabar == "ERROR") {
                alert("Registro no pudo ser grabado.");
                grdListadoClientes.cpGrabar = "";
                return;
            }
            else if (grdListadoClientes.cpModificar == "OK") {
                alert("Registro actualizado correctamente.");
                grdListadoClientes.cpModificar = "";
                limpiar();
                return;
            }
            else if (grdListadoClientes.cpModificar == "ERROR") {
                alert("Registro no pudo ser actualizado.");
                grdListadoClientes.cpModificar = "";
                return;
            }
        }

        function limpiar() {
            modificacion = false;

            cmbTipoDocumento.SetValue("");
            cmbTipoDocumento.SetSelectedIndex(-1);

            cmbEstado.SetValue("A");
            cmbEstado.SetSelectedIndex(0);

            txtUsuario.SetText("");
            txtPassword.SetText("");
            txtIdentificacion.SetText("");
            txtNombres.SetText("");
            txtCiudad.SetText("");
            txtApellidos.SetText("");
            txtconvencional.SetText("");
            txtcelular.SetText("");
            txtDireccion.SetText("");
            txtReferenciaDireccion.SetText("");
            grdListadoClientes.UnselectRows();
            btnGrabar.SetText("Grabar");
        }


        function grdListadoClientes_SelectionChanged(s, e) {
            grdListadoClientes.GetSelectedFieldValues('Login;Identificacion;Nombres;Ciudad;Apellidos;TelefonoConvencional;TelefonoCelurares;Estado;ID_Cliente;Direccion;Referencia;TipoIdentificacion', OnGridSelectionComplete);
        }
        var modificacion = false;
        function OnGridSelectionComplete(values) {
            txtUsuario.SetText(values[0][0]);
            txtIdentificacion.SetValue(values[0][1]);
            txtNombres.SetValue(values[0][2]);
            txtCiudad.SetValue(values[0][3]);
            txtApellidos.SetValue(values[0][4]);
            txtconvencional.SetValue(values[0][5]);
            txtcelular.SetValue(values[0][6]);
            cmbEstado.SetValue(values[0][7]);
            txtIdCliente.SetValue(values[0][8]);
            txtDireccion.SetValue(values[0][9]);
            txtReferenciaDireccion.SetValue(values[0][10]);
            cmbTipoDocumento.SetValue(values[0][11]);
            txtPassword.SetText("");
            alert(values[0][8])
           // ValueHiddenField.SetValue(values[0][8]);
         //   ValueHiddenField.Value = values[0][8];
           // alert(values[0][8].tostring())
            modificacion = true;
            if (modificacion == false) {
                btnGrabar.SetText("Grabar");
            }
            else {
                btnGrabar.SetText("Modificar");
            }
            //selList.BeginUpdate();
            //selList.ClearItems();
            //for (var i = 0; i < values.length; i++) {
            //    selList.AddItem(values[i]);
            //}
            //selList.EndUpdate();
        }

        function btnNuevo_Click(s, e) {
            modificacion = false;
            limpiar();
            grdListadoClientes.UnselectRows();
        }

        var ID_EmpleadoVisible = false;

        function SetID_EmpleadoColumnVisibility(visible) {
            ID_EmpleadoVisible = visible;

            var disp = visible ? 'table-cell' : 'none';
            $('td.ID_ClienteColumn').css('display', disp);
        }

        function RestoreID_EmpleadoColumnVisibility() {
            SetID_EmpleadoColumnVisibility(ID_EmpleadoVisible);
        }


        //Event handlers
        function grdListadoClientes_Init(s, e) {
            RestoreID_EmpleadoColumnVisibility(ID_EmpleadoVisible);
        }

        function btnGrabar_Init(s, e) {
            if (modificacion == false) {
                btnGrabar.SetText("Grabar");
            }
            else {
                btnGrabar.SetText("Modificar"); 
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server"> 
   
    <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" Width="100%" Theme="Metropolis">
        <Items>
            <dx:LayoutGroup ColCount="3" RowSpan="8" Caption="Datos del Cliente">
                <Items>
                    <dx:LayoutItem Caption="Tipo Documento">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox runat="server" ID="cmbTipoDocumento" ClientInstanceName="cmbTipoDocumento"
                                    AutoPostBack="false" TextField="Descripcion" ValueField="Codigo" Theme="Metropolis" ></dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Identificacion">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtIdentificacion" ClientInstanceName="txtIdentificacion" runat="server" Width="170px" Theme="Metropolis"></dx:ASPxTextBox>
                                <dx:ASPxTextBox ID="txtIdCliente" ClientInstanceName="txtIdCliente" style="display: none;" ReadOnly="true" runat="server" Width="70px" Border-BorderColor="Transparent" ForeColor="Transparent" Theme="Metropolis"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Nombres">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtNombres" ClientInstanceName="txtNombres" runat="server" Width="300px" Theme="Metropolis"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Apellidos">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtApellidos" ClientInstanceName="txtApellidos" runat="server" Width="300px" Theme="Metropolis"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Ciudad">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtCiudad" ClientInstanceName="txtCiudad" runat="server" Width="250px" Theme="Metropolis"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Direccion">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtDireccion" ClientInstanceName="txtDireccion" runat="server" Width="400px" Theme="Metropolis"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Referencia">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtReferenciaDireccion" ClientInstanceName="txtReferenciaDireccion" runat="server" Width="400px" Theme="Metropolis"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Tel: Convencional">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtconvencional" ClientInstanceName="txtconvencional" runat="server" Width="170px" Theme="Metropolis"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Tel: Celular">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtcelular" ClientInstanceName="txtcelular" runat="server" Width="170px" Theme="Metropolis"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>


                    <dx:LayoutItem Caption="Usuario">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtUsuario" ClientInstanceName="txtUsuario" runat="server" Width="170px" Theme="Metropolis"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Contrasena">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox runat="server" Width="170px" Password="True" ClientInstanceName="txtPassword" ID="txtPassword"></dx:ASPxTextBox>
                                 
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Estado">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox runat="server" ID="cmbEstado" ClientInstanceName="cmbEstado" Theme="Metropolis" SelectedIndex="0">
                                    <Items>
                                        <dx:ListEditItem Selected="True" Text="Activo" Value="A"></dx:ListEditItem>
                                        <dx:ListEditItem Text="Inactivo" Value="I"></dx:ListEditItem>
                                    </Items>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    
                     <dx:LayoutItem Caption="" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                     <dx:LayoutItem Caption="" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                               <dx:ASPxButton runat="server" ID ="btnNuevo" ClientInstanceName="btnNuevo" Text="Nuevo" Theme="SoftOrange" UseSubmitBehavior="false"
                                   AutoPostBack="false" CausesValidation="false">
                                   <ClientSideEvents Click="btnNuevo_Click" />
                               </dx:ASPxButton>
                               <dx:ASPxButton runat="server" ID ="btnGrabar" ClientInstanceName="btnGrabar" Text="Grabar" Theme="SoftOrange" UseSubmitBehavior="false"
                                   AutoPostBack="false" CausesValidation="false">
                                   <ClientSideEvents Click="btnGrabar_Click" Init="btnGrabar_Init" />
                               </dx:ASPxButton>
                               <dx:ASPxButton runat="server" ID ="btnCancelar" ClientInstanceName="btnCancelar" Text="Cancelar" Theme="SoftOrange"
                                  OnClick="btnCancelar_Click" ></dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
            <dx:LayoutGroup Caption="REGISTROS">
                <Items>
                    <dx:LayoutItem ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxGridView ID="grdListadoClientes" runat="server" ClientInstanceName="grdListadoClientes" KeyFieldName="ID_Cliente"
                                    Theme="SoftOrange" OnDataBinding="grdListadoClientes_DataBinding" Width="100%"  OnCustomCallback="grdListadoClientes_CustomCallback"
                                   >
                                    <SettingsBehavior  AllowSelectSingleRowOnly="true" />
                                    <ClientSideEvents EndCallback="grdListadoClientes_EndCallback" SelectionChanged="grdListadoClientes_SelectionChanged" 
                                        Init="grdListadoClientes_Init"/>
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowSelectButton="true"></dx:GridViewCommandColumn>
                                        <dx:GridViewDataColumn Caption="Login" FieldName="Login"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Identificacion" FieldName="Identificacion"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Nombres" FieldName="Nombres"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Apellidos" FieldName="Apellidos"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Estado" FieldName="Estado"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="ID_Cliente" FieldName="ID_Cliente">
                                            <HeaderStyle CssClass="ID_ClienteColumn" />
                                            <EditCellStyle CssClass="ID_ClienteColumn" />
                                            <CellStyle CssClass="ID_ClienteColumn" />
                                            <FilterCellStyle CssClass="ID_ClienteColumn" />
                                            <FooterCellStyle CssClass="ID_ClienteColumn" />
                                            <GroupFooterCellStyle CssClass="ID_ClienteColumn" />
                                        </dx:GridViewDataColumn>
                                    </Columns>
                                </dx:ASPxGridView>
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

