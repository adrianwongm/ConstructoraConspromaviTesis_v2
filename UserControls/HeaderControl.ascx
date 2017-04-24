<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HeaderControl.ascx.cs" Inherits="UserControls_HeaderControl" %>
<script type="text/javascript">
    function hideLoginPanel(s, e) {
        pcLogin.Hide();
    }
    function showLoginPanel(s, e) {
        pcLogin.Show();
    }
</script>
<div class="header">
    <div class="content-сolumn">
        <div class="logo">
            <dx:ASPxHyperLink runat="server" ID="hlLogo" NavigateUrl="~/Default.aspx" ImageUrl="~/Content/Images/Header.png">
            </dx:ASPxHyperLink>
        </div>
        <div class="buttons">
            <dx:ASPxButton ID="Contact" runat="server" Text="Contacto" AutoPostBack="False" Font-Size="14px" Width="107px" Height="38px"
                CssClass="orangeButton">
	        </dx:ASPxButton>
            <dx:ASPxButton ID="Login" runat="server" Text="Ingreso" AutoPostBack="False" ClientInstanceName="btnLogin" Width="75px" Height="38px" Font-Size="14px"
                CssClass="orangeButton">
		        <ClientSideEvents Click="showLoginPanel" />
	        </dx:ASPxButton>
        </div>
        <div class="clear"></div>
    </div>
     <div class="content-сolumn">
         <dx:ASPxMenu ID="mMain" ClientInstanceName="mMain" runat="server" AllowSelectItem="True" ShowPopOutImages="True" Theme="Metropolis" >
            <Items>
                <dx:MenuItem Text="Inicio" NavigateUrl="../Default.aspx"></dx:MenuItem>
                <dx:MenuItem Text="Transacciones">
                    <Items> 
                        <dx:MenuItem Text="Construcciones" NavigateUrl="../CatalogoConstrucciones.aspx">
                        </dx:MenuItem>
                        <dx:MenuItem Text="Imagenes de construcciones" NavigateUrl="../CatalogoImagenesConstruccion.aspx">
                        </dx:MenuItem>
                         <dx:MenuItem Text="Cotizacion" NavigateUrl="../CatalogoImagenesConstruccion.aspx">
                        </dx:MenuItem>
                    </Items>
                </dx:MenuItem>
                <dx:MenuItem Text="Catalogos">
                    <Items>
                        <dx:MenuItem Text="Clientes" NavigateUrl="../Clientes.aspx">
                        </dx:MenuItem>
                        <dx:MenuItem Text="Empleados" NavigateUrl="../Empleados.aspx">
                        </dx:MenuItem>
                        <dx:MenuItem Text="Variables" NavigateUrl="../Empleados.aspx">
                        </dx:MenuItem> 
                    </Items>
                </dx:MenuItem>
                <dx:MenuItem Text="Configuracion">
                    <Items>
                        <dx:MenuItem Text="Usuarios" NavigateUrl="~/UsuarioInterno.aspx">
                        </dx:MenuItem>
                        <dx:MenuItem Text="Perfiles" NavigateUrl="../Perfiles.aspx">
                        </dx:MenuItem> 
                    </Items>
                </dx:MenuItem>
                <dx:MenuItem Text="Cuenta">
                    <Items>
                         <dx:MenuItem Text="Cambiar Password" NavigateUrl="../CambiarPassword.aspx">
                     </dx:MenuItem> 
                    </Items>
                </dx:MenuItem>
            </Items>
        </dx:ASPxMenu>
     </div>
    <dx:ASPxPopupControl ID="LogonControl" runat="server" ClientInstanceName="pcLogin" PopupHorizontalAlign="WindowCenter" ShowHeader="false"
        PopupVerticalAlign="WindowCenter" Modal="True" ShowCloseButton="False" Width="608px" ShowPageScrollbarWhenModal="true">
	    <ContentCollection>
		    <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <div class="loginPopup">
                    <div class="title">
                        FORMULARIO DE INGRESO
                    </div>
                    <div class="formLayout">
                        <dx:ASPxFormLayout ID="LoginFormLayout" runat="server" RequiredMarkDisplayMode="None">
                            <SettingsItems Width="328px" ShowCaption="False" />
                            <Styles>
                                <LayoutGroup>
                                    <Cell>
                                        <Paddings PaddingTop="3px" PaddingBottom="3px" />
                                    </Cell>
                                </LayoutGroup>
                            </Styles>
                            <Items>
                                <dx:LayoutItem>
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxTextBox ID="txtEmail" runat="server" Width="100%" NullText="Email" Height="30px" CssClass="editor">
					                            <NullTextStyle Font-Italic="true"></NullTextStyle>
                                                <ValidationSettings ValidationGroup="login" ErrorDisplayMode="None" Display="Dynamic">
                                                    <RegularExpression ErrorText="" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem>
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxTextBox ID="txtPassword" runat="server" Width="100%" NullText="Password" Height="30px" CssClass="editor" Password="true">
                                                <NullTextStyle Font-Italic="true"></NullTextStyle>
                                                <ValidationSettings ValidationGroup="login" ErrorDisplayMode="None" Display="Dynamic">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
					                        </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem>
                                    <ParentContainerStyle>
                                        <Paddings PaddingTop="22px" PaddingBottom="6px" />
                                    </ParentContainerStyle>
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxCaptcha ID="Captcha" runat="server" CodeLength="5" CssClass="captcha">
                                                <NullTextStyle Font-Italic="true"></NullTextStyle>
						                        <RefreshButton Position="Right"></RefreshButton>
						                        <TextBox LabelText="" NullText="Ingrese el código" Position="Bottom" ShowLabel="False" />
                                                <TextBoxStyle Width="328px" CssClass="textBox editor" />
						                        <ChallengeImage ForegroundColor="#000000" BackgroundColor="#f69b36" Width="328" Height="100">
						                        </ChallengeImage>
                                                <ValidationSettings ValidationGroup="login"></ValidationSettings>
					                        </dx:ASPxCaptcha>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                    </div>
                    <div class="buttons">
                        <div class="buttonsContainer">
                            <dx:ASPxButton ID="btnLoginNow" runat="server" Text="Ingresar" AutoPostBack="true" Width="110px" Height="40px" BackColor="#f7f7f7" 
                                OnClick="btnLoginNow_Click" ValidationGroup="login" Font-Size="14px"> 
					            <HoverStyle BackColor="#f88e1d"></HoverStyle>
				            </dx:ASPxButton>
                            <dx:ASPxButton ID="btnCancelLogin" runat="server" Text="Cancelar" AutoPostBack="false" Width="110px" Height="40px" BackColor="#f7f7f7" Font-Size="14px">
                                <HoverStyle BackColor="#f88e1d"></HoverStyle>
                                <ClientSideEvents Click="function(s, e) { hideLoginPanel(); }" />
				            </dx:ASPxButton>
                        </div>
                    </div>
                </div>
		    </dx:PopupControlContentControl>
	    </ContentCollection>
    </dx:ASPxPopupControl>
    <dx:ASPxPopupControl ID="ContactUsControl" runat="server" PopupElementID="Contact" PopupHorizontalAlign="RightSides" PopupVerticalAlign="Below" ShowHeader="False" Width="460px" ClientInstanceName="pcContact">
	    <ContentCollection>
		    <dx:PopupControlContentControl>
			    <div class="contactUs">
                    <h2 class="title">Para mayor información</h2>
                    <br />
                    <div class="text">
                        Para contratar nuestras obras o servicios
                        <br/>
                        para informacion, visitanos <a class="orangeLink" href="https://www.devexpress.com/Subscriptions/">Compara nuestras ofertas y precios</a> en nuestas oficinas.
                    </div>
                    <br />
                    <div class="text">
                        If you have any questions or require assistance, call us at
                        <br />
                        +1 (800) CONSPORMAVI a partir 7:30am y 4:30pm 
                        <br/>
                        o Email <a class="orangeLink" href="jennyflores23@icloud.com">jennyflores23@icloud.com</a>
                    </div>
                    <br />
				 <%--   <div class="text">
                        Download your free <a class="orangeLink" href="https://www.devexpress.com/Home/try.xml">30-day trial</a> today.
				    </div>--%>
                    <br />
					<dx:ASPxButton ID="btnCloseContact" runat="server" Text="Close" Width="420px" AutoPostBack="False" BackColor="#F7F7F7"  Font-Size="14px" Height="40px">
                        <ClientSideEvents Click="function(s, e) { pcContact.Hide(); }" />
						<HoverStyle BackColor="#F88E1D">
						</HoverStyle>
					</dx:ASPxButton>
			    </div>
		    </dx:PopupControlContentControl>
	    </ContentCollection>
    </dx:ASPxPopupControl>
</div>
