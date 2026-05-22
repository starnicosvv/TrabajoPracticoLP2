<%@ Page Title="Grilla de Calificaciones" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Notas.aspx.cs" Inherits="ProyectoC.Notas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            background-color: #f8f9fa;
        }
        h2 {
            color: #4B0082;
            font-weight: bold;
        }
        .btn-custom {
            background-color: #4B0082;
            color: white;
            border: none;
        }
        .btn-custom:hover {
            background-color: #FF7F50;
            color: white;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .error-msg {
            color: #dc3545;
            font-weight: bold;
        }
    </style>

    <div class="card p-4 mb-4">
        <h2 class="mb-3">Ingreso de Calificaciones</h2>

        <div class="row g-3">
            <div class="col-md-4">
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Placeholder="Nombre"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <asp:DropDownList ID="ddlMateria" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Matemática" Value="Matemática"></asp:ListItem>
                    <asp:ListItem Text="Historia" Value="Historia"></asp:ListItem>
                    <asp:ListItem Text="Química" Value="Química"></asp:ListItem>
                    <asp:ListItem Text="Lengua" Value="Lengua"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-4">
                <asp:TextBox ID="txtMatricula" runat="server" CssClass="form-control" Placeholder="Matrícula"></asp:TextBox>
            </div>
        </div>

        <div class="row g-3 mt-3">
            <div class="col-md-2">
                <asp:TextBox ID="txtParcial1" runat="server" CssClass="form-control" Placeholder="Parcial 1 (0-20)"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="txtParcial2" runat="server" CssClass="form-control" Placeholder="Parcial 2 (0-20)"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="txtTP" runat="server" CssClass="form-control" Placeholder="TP (0-10)"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="txtExamenFinal" runat="server" CssClass="form-control" Placeholder="Examen Final (0-50)"></asp:TextBox>
            </div>
            <div class="col-md-4 d-grid">
                <asp:Button ID="btnAgregar" runat="server" Text="Agregar Alumno" CssClass="btn btn-custom" OnClick="btnAgregar_Click" />
            </div>
        </div>

        <div class="mt-3">
            <asp:Label ID="lblError" runat="server" CssClass="error-msg"></asp:Label>
        </div>
    </div>

<div class="card p-4">
    <asp:GridView ID="gvNotas" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover"
        OnRowDeleting="gvNotas_RowDeleting"
        OnRowEditing="gvNotas_RowEditing"
        OnRowUpdating="gvNotas_RowUpdating"
        OnRowCancelingEdit="gvNotas_RowCancelingEdit">
        <Columns>
            
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:BoundField DataField="Materia" HeaderText="Materia" />
            <asp:BoundField DataField="Matricula" HeaderText="Matrícula" />
            <asp:BoundField DataField="Parcial1" HeaderText="Parcial 1" />
            <asp:BoundField DataField="Parcial2" HeaderText="Parcial 2" />
            <asp:BoundField DataField="TP" HeaderText="TP" />
            <asp:BoundField DataField="ExamenFinal" HeaderText="Examen Final" />

            
            <asp:BoundField DataField="Total" HeaderText="Total" />
            <asp:BoundField DataField="CalificacionFinal" HeaderText="Calificación Final" />

            
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>
</div>


        <div class="mt-3">
            <asp:Label ID="lblMejor" runat="server" CssClass="fw-bold text-success"></asp:Label><br />
            <asp:Label ID="lblPeor" runat="server" CssClass="fw-bold text-danger"></asp:Label><br />
            <asp:Label ID="lblPromedio" runat="server" CssClass="fw-bold text-primary"></asp:Label>
            <asp:Label ID="lblAprobados" runat="server" CssClass="fw-bold text-success"></asp:Label><br />
            <asp:Label ID="lblReprobados" runat="server" CssClass="fw-bold text-danger"></asp:Label>

        </div>
    
</asp:Content>
