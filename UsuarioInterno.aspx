<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="UsuarioInterno.aspx.cs" Inherits="UsuarioInterno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" Runat="Server">
    <script type="text/javascript">
        function btnGrabar_Click(s, e) {
            if (modificacion == false) {
                grdListadoUsuarios.PerformCallback("Grabar");
            } else {
                grdListadoUsuarios.PerformCallback("Modificar");
            }
            
        }

        function grdListadoUsuarios_EndCallback(s, e) {
            if (grdListadoUsuarios.cpGrabar == "OK") {
                alert("Registro grbado correctamente.");
                grdListadoUsuarios.cpGrabar = "";
                limpiar();
                return;
            }
            else if (grdListadoUsuarios.cpGrabar == "ERROR") {
                alert("Registro no pudo ser grabado.");
                grdListadoUsuarios.cpGrabar = "";
                return;
            }
            else if (grdListadoUsuarios.cpModificar == "OK") {
                alert("Registro actualizado correctamente.");
                grdListadoUsuarios.cpModificar = "";
                limpiar();
                return;
            }
            else if (grdListadoUsuarios.cpModificar == "ERROR") {
                alert("Registro no pudo ser actualizado.");
                grdListadoUsuarios.cpModificar = "";
                return;
            }
        }

        function limpiar() {
            modificacion = false;

            cmbEmpleado.SetValue("");
            cmbEmpleado.SetSelectedIndex(-1);

            cmbEstado.SetValue("A");
            cmbEstado.SetSelectedIndex(0);

            txtUsuario.SetText("");
            txtPassword.SetText("");
            grdListadoUsuarios.UnselectRows();
            btnGrabar.SetText("Grabar");
        }


        function grdListadoUsuarios_SelectionChanged(s, e) {
            grdListadoUsuarios.GetSelectedFieldValues('Usuario;Estado;ID_Empleado', OnGridSelectionComplete);
        }
        var modificacion = false;
        function OnGridSelectionComplete(values) {
            txtUsuario.SetText(values[0][0]);
            cmbEstado.SetValue(values[0][1]);
            cmbEmpleado.SetValue(values[0][2]);
            txtPassword.SetText("");
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
            grdListadoUsuarios.UnselectRows();
        }

        var ID_EmpleadoVisible = false;

        function SetID_EmpleadoColumnVisibility(visible) {
            ID_EmpleadoVisible = visible;

            var disp = visible ? 'table-cell' : 'none';
            $('td.ID_EmpleadoColumn').css('display', disp);
        }

        function RestoreID_EmpleadoColumnVisibility() {
            SetID_EmpleadoColumnVisibility(ID_EmpleadoVisible);
        }


        //Event handlers
        function grdListadoUsuarios_Init(s, e) {
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
            <dx:LayoutGroup ColCount="7" Caption="Datos de usuario">
                <Items>
                    <dx:LayoutItem Caption="Empleado">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox runat="server" ID="cmbEmpleado" ClientInstanceName="cmbEmpleado"
                                    AutoPostBack="false" TextField="Empleado_Nombres" ValueField="ID" Theme="Metropolis" ></dx:ASPxComboBox>
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
                               <dx:ASPxButton runat="server" ID ="btnNuevo" ClientInstanceName="btnNuevo" Text="Nuevo" Theme="SoftOrange" UseSubmitBehavior="false"
                                   AutoPostBack="false" CausesValidation="false">
                                   <ClientSideEvents Click="btnNuevo_Click" />
                               </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                     <dx:LayoutItem Caption="" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                               <dx:ASPxButton runat="server" ID ="btnGrabar" ClientInstanceName="btnGrabar" Text="Grabar" Theme="SoftOrange" UseSubmitBehavior="false"
                                   AutoPostBack="false" CausesValidation="false">
                                   <ClientSideEvents Click="btnGrabar_Click" Init="btnGrabar_Init" />
                               </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
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
                                <dx:ASPxGridView ID="grdListadoUsuarios" runat="server" ClientInstanceName="grdListadoUsuarios" KeyFieldName="Usuario"
                                    Theme="SoftOrange" OnDataBinding="grdListadoUsuarios_DataBinding" Width="100%"  OnCustomCallback="grdListadoUsuarios_CustomCallback"
                                   >
                                    <SettingsBehavior  AllowSelectSingleRowOnly="true" />
                                    <ClientSideEvents EndCallback="grdListadoUsuarios_EndCallback" SelectionChanged="grdListadoUsuarios_SelectionChanged" 
                                        Init="grdListadoUsuarios_Init"/>
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowSelectButton="true"></dx:GridViewCommandColumn>
                                        <dx:GridViewDataColumn Caption="Login" FieldName="Usuario"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Empleado" FieldName="Empleado_Nombres"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Estado" FieldName="Estado"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="ID_Empleado" FieldName="ID_Empleado">
                                            <HeaderStyle CssClass="ID_EmpleadoColumn" />
                                            <EditCellStyle CssClass="ID_EmpleadoColumn" />
                                            <CellStyle CssClass="ID_EmpleadoColumn" />
                                            <FilterCellStyle CssClass="ID_EmpleadoColumn" />
                                            <FooterCellStyle CssClass="ID_EmpleadoColumn" />
                                            <GroupFooterCellStyle CssClass="ID_EmpleadoColumn" />
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

