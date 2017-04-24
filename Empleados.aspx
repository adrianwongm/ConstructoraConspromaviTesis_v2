<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Empleados.aspx.cs" Inherits="Empleados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" Runat="Server">
    <script type="text/javascript">
        function btnGrabar_Click(s, e) {
            if (modificacion == false) {
                grdListadoEmpleados.PerformCallback("Grabar");
            } else {
                grdListadoEmpleados.PerformCallback("Modificar");
            }
            
        }

        function grdListadoEmpleados_EndCallback(s, e) {
            if (grdListadoEmpleados.cpGrabar == "OK") {
                alert("Registro grbado correctamente.");
                grdListadoEmpleados.cpGrabar = "";
                limpiar();
                return;
            }
            else if (grdListadoEmpleados.cpGrabar == "ERROR") {
                alert("Registro no pudo ser grabado.");
                grdListadoEmpleados.cpGrabar = "";
                return;
            }
            else if (grdListadoEmpleados.cpModificar == "OK") {
                alert("Registro actualizado correctamente.");
                grdListadoEmpleados.cpModificar = "";
                limpiar();
                return;
            }
            else if (grdListadoEmpleados.cpModificar == "ERROR") {
                alert("Registro no pudo ser actualizado.");
                grdListadoEmpleados.cpModificar = "";
                return;
            }
        }

        function limpiar() {
            modificacion = false;

            cmbCargos.SetValue("");
            cmbCargos.SetSelectedIndex(-1);

            cmbEstado.SetValue("A");
            cmbEstado.SetSelectedIndex(0);

            txtNombres.SetText("");
            txtApellidos.SetText("");
            txtIdentificacion.SetText("");
            grdListadoEmpleados.UnselectRows();
            btnGrabar.SetText("Grabar");
        }


        function grdListadoEmpleados_SelectionChanged(s, e) {
            grdListadoEmpleados.GetSelectedFieldValues('ID;NumeroIdentificacion;Nombres;Apellidos;ID_Cargo;Estado', OnGridSelectionComplete);
        }
        var modificacion = false;
        function OnGridSelectionComplete(values) {
            txtIdCliente.SetValue(values[0][0]);
            txtIdentificacion.SetValue(values[0][1]);
            txtNombres.SetValue(values[0][2]);
            txtApellidos.SetValue(values[0][3]);
            cmbCargos.SetValue(values[0][4]);
            cmbEstado.SetValue(values[0][5]);
            
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
            grdListadoEmpleados.UnselectRows();
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
        function grdListadoEmpleados_Init(s, e) {
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
            <dx:LayoutGroup ColCount="3" RowSpan="8" Caption="Datos del Empleado">
                <Items>
                    <dx:LayoutItem Caption="Cargo Empleado">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox runat="server" ID="cmbCargos" ClientInstanceName="cmbCargos"
                                    AutoPostBack="false" TextField="Descripcion" ValueField="Codigo" Theme="Metropolis" ></dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Identificacion">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="txtIdentificacion" ClientInstanceName="txtIdentificacion" runat="server" Width="170px" Theme="Metropolis"></dx:ASPxTextBox>
                                <dx:ASPxTextBox ID="txtIdCliente" ClientInstanceName="txtIdCliente" ReadOnly="true" runat="server" Width="70px" Border-BorderColor="Transparent" ForeColor="Transparent" Theme="Metropolis"></dx:ASPxTextBox>
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
                    <dx:LayoutItem Caption="">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
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
                                <dx:ASPxGridView ID="grdListadoEmpleados" runat="server" ClientInstanceName="grdListadoEmpleados" KeyFieldName="ID"
                                    Theme="SoftOrange" OnDataBinding="grdListadoEmpleados_DataBinding" Width="100%"  OnCustomCallback="grdListadoEmpleados_CustomCallback"
                                   >
                                    <SettingsBehavior  AllowSelectSingleRowOnly="true" />
                                    <ClientSideEvents EndCallback="grdListadoEmpleados_EndCallback" SelectionChanged="grdListadoEmpleados_SelectionChanged" 
                                        Init="grdListadoEmpleados_Init"/>
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowSelectButton="true"></dx:GridViewCommandColumn>
                                        <dx:GridViewDataColumn Caption="NumeroIdentificacion" FieldName="NumeroIdentificacion"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Nombres" FieldName="Nombres"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Apellidos" FieldName="Apellidos"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Estado" FieldName="Estado"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="ID" FieldName="ID">
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

