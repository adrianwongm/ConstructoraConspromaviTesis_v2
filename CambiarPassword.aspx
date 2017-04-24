<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="CambiarPassword.aspx.cs" Inherits="CambiarPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" Runat="Server">
     <script  type="text/javascript">
        function btnGrabar_Click(s, e) {
            if (txtPassNuevaRepetir.GetText() != txtPassNueva.GetText()) {
                e.processOnServer  = false;
                alert("El nuevo password no coincide.");
                txtPassNuevaRepetir.SetFocus();
                return false;
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

    </script>
    <style type="text/css">
        .centered {
            margin: 0 auto;
            float: none !important;
            display: table;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
    <dx:ASPxFormLayout ID="ASPxFormLayout1" ClientInstanceName="ASPxFormLayout1" runat="server" Theme="SoftOrange" CssClass="centered">
        <Items>
            <dx:LayoutGroup Caption="Cambio de contrase&#241;a">
                <Items>
                    <dx:LayoutItem Caption="Usuario" RequiredMarkDisplayMode="Hidden">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox runat="server" ID="txtUsuario" ClientInstanceName="txtUsuario" ReadOnly="true" Theme="Office2010Blue"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Password Actual" RequiredMarkDisplayMode="Required">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox runat="server" ID="txtPassActual" ClientInstanceName="txtPassActual" Theme="Office2010Blue"
                                    Password="true">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Password Nueva" RequiredMarkDisplayMode="Required">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox runat="server" ID="txtPassNueva" ClientInstanceName="txtPassNueva" Theme="Office2010Blue"
                                    Password="true">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Password Nueva(Repetir)" RequiredMarkDisplayMode="Required">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox runat="server" ID="txtPassNuevaRepetir" ClientInstanceName="txtPassNuevaRepetir" Theme="Office2010Blue"
                                    Password="true"></dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
            <dx:LayoutGroup Caption="" ColCount="2">
                <Items>
                    <dx:LayoutItem ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton runat="server" ID="btnGrabar" ClientInstanceName="btnGrabar" Text="Grabar" ToolTip="Guardar el cambio de password"
                                    OnClick="btnGrabar_Click" UseSubmitBehavior="false" Theme="SoftOrange"    ImagePosition="Left" >
                                    <ClientSideEvents Click="btnGrabar_Click" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton runat="server" ID="btnCancelar" ClientInstanceName="btnCancelar" Text="Cancelar" ToolTip="Cancelar accion"
                                    OnClick="btnCancelar_Click" Theme="SoftOrange"   ImagePosition="Left" 
                                   CausesValidation="false" UseSubmitBehavior="false">

                                </dx:ASPxButton>
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

