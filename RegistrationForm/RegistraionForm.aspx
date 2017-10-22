<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegistraionForm.aspx.cs" Inherits="RegistraionForm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
            <h2 style="text-align: center;">Registraion Form<hr />
            </h2>
            <table border="1" align="center" style="background-color: aquamarine; color: #000; border-color: #000; width: 30%">
                <tr>
                    <td>First Name
                    </td>
                    <td>
                        <asp:TextBox ID="txtfirstname" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFVfirstname" runat="server" ErrorMessage="please enter first name" ControlToValidate="txtfirstname"
                            Display="None" ValidationGroup="registraion">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Last Name
                    </td>
                    <td>
                        <asp:TextBox ID="txtlastname" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RFVlastname" runat="server" ErrorMessage="please enter last name" ControlToValidate="txtlastname"
                            Display="None" ValidationGroup="registraion">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Email ID
                    </td>
                    <td>
                        <asp:TextBox ID="txtemailid" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter email id"
                            ControlToValidate="txtemailid" Display="None" ValidationGroup="registraion">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="rev1" runat="server" Display="None" ErrorMessage="Enter Proper email ID" ControlToValidate="txtemailid" ValidationGroup="registraion" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>Mobile No
                    </td>
                    <td>
                        <asp:TextBox ID="txtmobileno" runat="server"></asp:TextBox>
                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtmobileno" FilterType="Numbers">
                        </cc1:FilteredTextBoxExtender>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" Display="None" runat="server" ErrorMessage="Please enter mobile no"
                            ControlToValidate="txtmobileno" ValidationGroup="registraion">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="None" runat="server" ErrorMessage="Please enter 10 digit mobile no"
                            ControlToValidate="txtmobileno" ValidationGroup="registraion" ValidationExpression="^[0-9]{10}$"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>Gender
                    </td>
                    <td>
                        <asp:RadioButtonList ID="RBList" runat="server">
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="None" runat="server" ErrorMessage="Please select gender"
                            ControlToValidate="RBList" ValidationGroup="registraion">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Country
                    </td>
                    <td>
                        <asp:UpdatePanel ID="Upcountry" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlcountry" runat="server" DataTextField="countryname" DataValueField="countryid" AutoPostBack="true" OnSelectedIndexChanged="ddlcountry_SelectedIndexChanged"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="None" runat="server" ErrorMessage="Please select country"
                                    ControlToValidate="ddlcountry" ValidationGroup="registraion">*</asp:RequiredFieldValidator>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlcountry" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>

                    </td>
                </tr>
                <tr>
                    <td>State
                    </td>
                    <td>
                        <asp:UpdatePanel ID="Upstate" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlstate" runat="server" DataTextField="statename" DataValueField="stateid"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="None" runat="server" ErrorMessage="Please select state"
                                    ControlToValidate="ddlstate" ValidationGroup="registraion">*</asp:RequiredFieldValidator>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="ddlstate" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>Hobbies
                    </td>
                    <td>
                        <asp:CheckBoxList ID="chkhobbies" runat="server">
                            <asp:ListItem>Chess</asp:ListItem>
                            <asp:ListItem>Cricket</asp:ListItem>
                            <asp:ListItem>Holly Ball</asp:ListItem>
                            <asp:ListItem>FootBall</asp:ListItem>
                            <asp:ListItem>Net Surfing</asp:ListItem>
                        </asp:CheckBoxList>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Required" ClientValidationFunction="chkhobbies"></asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td>Images
                    </td>
                    <td>
                        <asp:FileUpload ID="fuimage" runat="server" /></td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" Display="None" runat="server" ErrorMessage="Please select Images"
                        ControlToValidate="fuimage" ValidationGroup="registraion">*</asp:RequiredFieldValidator>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" ValidationGroup="registraion" />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ShowSummary="false" ValidationGroup="registraion" />
                        <asp:Button ID="btnupdate" runat="server" Text="Update" Visible="false" OnClick="btnupdate_Click" />
                        <asp:Button ID="btncancel" runat="server" Text="Cancel" OnClick="btncancel_Click" />
                    </td>
                </tr>
            </table>
            <br />
            <table border="1" align="center" style="background-color: aquamarine; color: #000; border-color: #000; width: 30%">
                <tr>
                    <td>Search
                    </td>
                    <td>
                        <asp:TextBox ID="txtsearch" runat="server" placeholder="search record"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" Display="None" runat="server" ErrorMessage="Please enter keyword"
                            ControlToValidate="txtsearch" ValidationGroup="search">*</asp:RequiredFieldValidator>
                        <asp:Button ID="btnsearch" runat="server" Text="Searh" OnClick="btnsearch_Click" ValidationGroup="search" Style="margin: 0px -124px 0 66px;" />
                    </td>
                </tr>
            </table>
            <br />
            <table id="tblregistraion" runat="server" border="1" align="center" style="background-color: aquamarine; color: #000; border-color: #000; width: 30%">
                <tr>
                    <td>
                        <asp:GridView ID="gridview" runat="server" AllowPaging="true" AutoGenerateColumns="false" DataKeyNames="code" PageSize="2" OnRowEditing="gridview_RowEditing" OnPageIndexChanging="gridview_PageIndexChanging" OnRowDeleting="gridview_RowDeletinsg">
                            <Columns>
                                <asp:CommandField HeaderText="Delete" ShowDeleteButton="true" ButtonType="Button" />
                                <asp:CommandField HeaderText="Edit" ShowEditButton="true" ButtonType="Button" />
                                <asp:BoundField HeaderText="FirstName" DataField="firstname" />
                                <asp:BoundField HeaderText="LastName" DataField="lastname" />
                                <asp:BoundField HeaderText="EmailID" DataField="emailid" />
                                <asp:BoundField HeaderText="MobileNo" DataField="mobileno" />
                                <asp:BoundField HeaderText="Gender" DataField="gender" />
                                <asp:BoundField HeaderText="Country" DataField="country" />
                                <asp:BoundField HeaderText="State" DataField="state" />
                                <asp:BoundField HeaderText="Hobbies" DataField="hobbies" />
                                <asp:TemplateField HeaderText="Image">
                                    <ItemTemplate>
                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%#Eval("images") %>' Width="50px"
                                            Height="50px" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
