<%@ Page Title="Grilla de Calificaciones" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Notas.aspx.cs" Inherits="ProyectoC.Notas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    :root {
        --primary: #6366f1;
        --primary-dark: #4f46e5;
        --secondary: #8b5cf6;
        --success: #10b981;
        --danger: #ef4444;
        --warning: #f59e0b;
        --info: #06b6d4;
        --light: #f8fafc;
        --dark: #1e293b;
        --border: #e2e8f0;
        --text: #1e293b;
        --text-muted: #64748b;
        --bg-card: #ffffff;
        --shadow: 0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.06);
        --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    body.dark-mode {
        --light: #0f172a;
        --dark: #f8fafc;
        --bg-card: #1e293b;
        --text: #f1f5f9;
        --text-muted: #cbd5e1;
        --border: #334155;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, var(--light) 0%, #f1f5f9 100%);
        color: var(--text);
        transition: var(--transition);
        min-height: 100vh;
    }

    body.dark-mode {
        background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
    }

    /* Header con Toggle */
    .app-header {
        background: var(--bg-card);
        border-bottom: 1px solid var(--border);
        padding: 1.5rem 2rem;
        position: sticky;
        top: 0;
        z-index: 1000;
        box-shadow: var(--shadow);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .app-title {
        font-size: 1.75rem;
        font-weight: 700;
        color: var(--primary);
        text-shadow: 0 2px 8px rgba(99, 102, 241, 0.3);
        letter-spacing: -0.5px;
    }

    body.dark-mode .app-title {
        text-shadow: 0 2px 12px rgba(139, 92, 246, 0.5);
    }

    .theme-toggle {
        background: var(--light);
        border: 2px solid var(--border);
        padding: 0.5rem 1rem;
        border-radius: 50px;
        cursor: pointer;
        font-size: 1rem;
        transition: var(--transition);
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: var(--text);
    }

    .theme-toggle:hover {
        background: var(--primary);
        color: white;
        border-color: var(--primary);
        transform: scale(1.05);
    }

    /* Container Principal */
    .app-container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 2rem;
    }

    /* Card Base */
    .card-modern {
        background: var(--bg-card);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 1.5rem;
        margin-bottom: 2rem;
        box-shadow: var(--shadow);
        transition: var(--transition);
    }

    .card-modern:hover {
        box-shadow: var(--shadow-lg);
        border-color: var(--primary);
    }

    .card-header-modern {
        display: flex;
        align-items: center;
        gap: 1rem;
        margin-bottom: 1.5rem;
        padding-bottom: 1rem;
        border-bottom: 2px solid var(--border);
    }

    .card-header-modern .icon {
        font-size: 1.75rem;
    }

    .card-header-modern h2 {
        font-size: 1.25rem;
        font-weight: 600;
        margin: 0;
        color: var(--text);
    }

    /* Form Inputs Modernos */
    .form-group {
        margin-bottom: 1.25rem;
    }

    .form-group label {
        display: block;
        font-size: 0.875rem;
        font-weight: 600;
        color: var(--text);
        margin-bottom: 0.5rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .form-control, .form-select {
        width: 100%;
        padding: 0.75rem 1rem;
        border: 2px solid var(--border);
        border-radius: 8px;
        font-size: 0.95rem;
        background: var(--light);
        color: var(--text);
        transition: var(--transition);
        font-family: inherit;
    }

    .form-control:focus, .form-select:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        background: var(--bg-card);
    }

    .form-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
    }

    /* Botones Modernos */
    .btn-modern {
        padding: 0.75rem 1.5rem;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        font-size: 0.95rem;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .btn-primary-modern {
        background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        color: white;
    }

    .btn-primary-modern:hover {
        transform: translateY(-2px);
        box-shadow: var(--shadow-lg);
    }

    .btn-secondary-modern {
        background: var(--light);
        color: var(--text);
        border: 2px solid var(--border);
    }

    .btn-secondary-modern:hover {
        background: var(--border);
        border-color: var(--text);
    }

    .btn-success-modern {
        background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
        color: white;
    }

    .btn-success-modern:hover {
        transform: translateY(-2px);
        box-shadow: var(--shadow-lg);
    }

    .btn-danger-modern {
        background: linear-gradient(135deg, var(--danger) 0%, #dc2626 100%);
        color: white;
    }

    .btn-danger-modern:hover {
        transform: translateY(-2px);
        box-shadow: var(--shadow-lg);
    }

    .btn-info-modern {
        background: linear-gradient(135deg, var(--info) 0%, #0891b2 100%);
        color: white;
    }

    .btn-info-modern:hover {
        transform: translateY(-2px);
        box-shadow: var(--shadow-lg);
    }

    .btn-small {
        padding: 0.5rem 1rem;
        font-size: 0.85rem;
    }

    /* Grid Botones */
    .btn-group {
        display: flex;
        gap: 1rem;
        flex-wrap: wrap;
    }

    .btn-group-vertical {
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
    }

    /* Alert */
    .alert-modern {
        padding: 1rem;
        border-radius: 8px;
        border-left: 4px solid;
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.05), rgba(239, 68, 68, 0.02));
        border-color: var(--danger);
        color: var(--danger);
        display: none;
    }

    .alert-modern:not(:empty) {
        display: block;
        animation: slideIn 0.3s ease;
    }

    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* GridView Moderno */
    .table-modern {
        width: 100%;
        border-collapse: collapse;
        font-size: 0.95rem;
    }

    .table-modern thead {
        background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        color: white;
    }

    .table-modern th {
        padding: 1rem;
        text-align: left;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-size: 0.85rem;
        cursor: pointer;
        user-select: none;
        position: relative;
    }

    .table-modern th:hover {
        background: linear-gradient(135deg, var(--primary-dark) 0%, #7c3aed 100%);
    }

    .table-modern th::after {
        content: '⇅';
        margin-left: 0.5rem;
        opacity: 0.5;
        font-size: 0.8rem;
    }

    .table-modern th.asc::after {
        content: '▲';
        opacity: 1;
    }

    .table-modern th.desc::after {
        content: '▼';
        opacity: 1;
    }

    .table-modern td {
        padding: 1rem;
        border-bottom: 1px solid var(--border);
        color: var(--text);
    }

    .table-modern tbody tr {
        transition: var(--transition);
    }

    .table-modern tbody tr:hover {
        background: rgba(99, 102, 241, 0.05);
    }

    .table-modern tbody tr:last-child td {
        border-bottom: none;
    }

    /* Estadísticas */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 1.5rem;
        margin-top: 2rem;
    }

    .stat-widget {
        background: var(--bg-card);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 1.5rem;
        position: relative;
        overflow: hidden;
        transition: var(--transition);
        box-shadow: var(--shadow);
    }

    .stat-widget:hover {
        transform: translateY(-4px);
        box-shadow: var(--shadow-lg);
        border-color: var(--primary);
    }

    .stat-widget::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(99, 102, 241, 0.1), transparent);
        animation: pulse 3s ease-in-out infinite;
    }

    @keyframes pulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.1); }
    }

    .stat-widget-content {
        position: relative;
        z-index: 1;
    }

    .stat-label {
        font-size: 0.85rem;
        color: var(--text-muted);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-weight: 600;
        margin-bottom: 0.5rem;
    }

    .stat-value {
        font-size: 2.5rem;
        font-weight: 700;
        color: var(--primary);
        margin-bottom: 0.5rem;
    }

    .stat-detail {
        font-size: 0.9rem;
        color: var(--text-muted);
        margin-bottom: 1rem;
    }

    .stat-bar {
        height: 6px;
        background: var(--border);
        border-radius: 3px;
        overflow: hidden;
    }

    .stat-bar-fill {
        height: 100%;
        background: linear-gradient(90deg, var(--primary) 0%, var(--secondary) 100%);
        border-radius: 3px;
        animation: fillBar 1.5s ease-out forwards;
    }

    @keyframes fillBar {
        from { width: 0; }
        to { width: 100%; }
    }

    /* Búsqueda Avanzada */
    .search-box {
        background: var(--bg-card);
        border: 2px solid var(--border);
        padding: 1.5rem;
        border-radius: 12px;
        display: flex;
        gap: 1rem;
        align-items: flex-end;
        margin-bottom: 2rem;
    }

    .search-input {
        flex: 1;
        min-width: 250px;
    }

    .search-box label {
        color: var(--text);
    }

    /* Ordenamiento Control */
    .sort-controls {
        display: flex;
        gap: 1rem;
        margin-bottom: 1rem;
        align-items: center;
        flex-wrap: wrap;
    }

    .sort-controls label {
        font-weight: 600;
        color: var(--text);
    }

    .sort-controls select {
        padding: 0.5rem 1rem;
        border: 2px solid var(--border);
        border-radius: 8px;
        background: var(--light);
        color: var(--text);
        cursor: pointer;
        font-family: inherit;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .app-container {
            padding: 1rem;
        }

        .app-header {
            flex-direction: column;
            gap: 1rem;
            padding: 1rem;
        }

        .form-row {
            grid-template-columns: 1fr;
        }

        .search-box {
            flex-direction: column;
            align-items: stretch;
        }

        .search-input {
            width: 100%;
        }

        .stats-grid {
            grid-template-columns: 1fr;
        }

        .table-modern {
            font-size: 0.85rem;
        }

        .table-modern th, .table-modern td {
            padding: 0.75rem;
        }

        .btn-group {
            flex-direction: column;
        }

        .sort-controls {
            flex-direction: column;
            align-items: stretch;
        }

        .sort-controls select {
            width: 100%;
        }
    }

    /* Animaciones */
    .fade-in {
        animation: fadeIn 0.5s ease;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Scrollbar personalizado */
    ::-webkit-scrollbar {
        width: 8px;
        height: 8px;
    }

    ::-webkit-scrollbar-track {
        background: var(--light);
    }

    ::-webkit-scrollbar-thumb {
        background: var(--primary);
        border-radius: 4px;
    }

    ::-webkit-scrollbar-thumb:hover {
        background: var(--primary-dark);
    }
</style>

<!-- Header -->
<div class="app-header">
    <h1 class="app-title">📊 Gestor de Calificaciones</h1>
    <button type="button" class="theme-toggle" id="toggleTheme">🌙 Dark Mode</button>
</div>

<div class="app-container">

    <!-- Formulario de Ingreso -->
    <div class="card-modern fade-in">
        <div class="card-header-modern">
            <span class="icon">✏️</span>
            <h2>Ingreso de Calificaciones</h2>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Nombre del Alumno</label>
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Placeholder="Ej: Juan Pérez"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>Materia</label>
                <asp:DropDownList ID="ddlMateria" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Seleccionar..." Value=""></asp:ListItem>
                    <asp:ListItem Text="Matemática" Value="Matemática"></asp:ListItem>
                    <asp:ListItem Text="Historia" Value="Historia"></asp:ListItem>
                    <asp:ListItem Text="Química" Value="Química"></asp:ListItem>
                    <asp:ListItem Text="Lengua" Value="Lengua"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Matrícula</label>
                <asp:TextBox ID="txtMatricula" runat="server" CssClass="form-control" Placeholder="Ej: 12345"></asp:TextBox>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Parcial 1 (0-20)</label>
                <asp:TextBox ID="txtParcial1" runat="server" CssClass="form-control" Placeholder="0" type="number"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>Parcial 2 (0-20)</label>
                <asp:TextBox ID="txtParcial2" runat="server" CssClass="form-control" Placeholder="0" type="number"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>TP (0-10)</label>
                <asp:TextBox ID="txtTP" runat="server" CssClass="form-control" Placeholder="0" type="number"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>Examen Final (0-50)</label>
                <asp:TextBox ID="txtExamenFinal" runat="server" CssClass="form-control" Placeholder="0" type="number"></asp:TextBox>
            </div>
        </div>

        <div class="btn-group">
            <asp:Button ID="btnAgregar" runat="server" Text="➕ Agregar Alumno" CssClass="btn-modern btn-primary-modern" OnClick="btnAgregar_Click" />
            <asp:Button ID="btnCancelar" runat="server" Text="✕ Cancelar" CssClass="btn-modern btn-secondary-modern" OnClick="btnCancelar_Click" CausesValidation="false" />
        </div>

        <asp:Label ID="lblError" runat="server" CssClass="alert-modern" style="margin-top: 1rem;"></asp:Label>
    </div>

    <!-- Búsqueda -->
    <div class="search-box fade-in">
        <div class="search-input">
            <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Buscar Alumno</label>
            <asp:TextBox ID="txtBusqueda" runat="server" CssClass="form-control" Placeholder="Ingresa nombre o matrícula..."></asp:TextBox>
        </div>
        <asp:Button ID="btnBuscar" runat="server" Text="🔍 Buscar" CssClass="btn-modern btn-info-modern" OnClick="btnBuscar_Click" />
        <asp:Button ID="btnLimpiar" runat="server" Text="🔄 Limpiar" CssClass="btn-modern btn-secondary-modern" OnClick="btnLimpiar_Click" />
    </div>

    <!-- GridView -->
    <div class="card-modern fade-in">
        <div class="card-header-modern">
            <span class="icon">📋</span>
            <h2>Listado de Alumnos</h2>
        </div>

        <!-- Controles de Ordenamiento -->
        <div class="sort-controls">
            <label for="ddlSort">Ordenar por:</label>
            <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-select" style="max-width: 250px;" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged" AutoPostBack="true">
                <asp:ListItem Text="Nombre (A-Z)" Value="nombre_asc"></asp:ListItem>
                <asp:ListItem Text="Nombre (Z-A)" Value="nombre_desc"></asp:ListItem>
                <asp:ListItem Text="Matrícula (Menor-Mayor)" Value="matricula_asc"></asp:ListItem>
                <asp:ListItem Text="Matrícula (Mayor-Menor)" Value="matricula_desc"></asp:ListItem>
                <asp:ListItem Text="Total (Mayor-Menor)" Value="total_desc"></asp:ListItem>
                <asp:ListItem Text="Total (Menor-Mayor)" Value="total_asc"></asp:ListItem>
                <asp:ListItem Text="Materia" Value="materia_asc"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <div style="overflow-x: auto;">
            <asp:GridView ID="gvNotas" runat="server" AutoGenerateColumns="False" DataKeyNames="Matricula" 
                CssClass="table-modern" OnRowCommand="gvNotas_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Materia" HeaderText="Materia" />
                    <asp:BoundField DataField="Matricula" HeaderText="Matrícula" />
                    <asp:BoundField DataField="Parcial1" HeaderText="P1" DataFormatString="{0:F1}" />
                    <asp:BoundField DataField="Parcial2" HeaderText="P2" DataFormatString="{0:F1}" />
                    <asp:BoundField DataField="TP" HeaderText="TP" DataFormatString="{0:F1}" />
                    <asp:BoundField DataField="ExamenFinal" HeaderText="Exam." DataFormatString="{0:F1}" />
                    <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:F2}" />
                    <asp:BoundField DataField="CalificacionFinal" HeaderText="Calific." />

                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div style="display: flex; gap: 0.5rem;">
                                <asp:Button ID="btnEditar" runat="server" CommandName="Editar" 
                                    CommandArgument='<%# Eval("Matricula") %>' Text="✏️ Editar" 
                                    CssClass="btn-modern btn-small btn-primary-modern" />
                                <asp:Button ID="btnEliminar" runat="server" CommandName="Eliminar" 
                                    CommandArgument='<%# Eval("Matricula") %>' Text="🗑️ Eliminar" 
                                    CssClass="btn-modern btn-small btn-danger-modern"
                                    OnClientClick="return confirm('¿Está seguro de eliminar este alumno?');" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="btn-group" style="margin-top: 1.5rem; justify-content: flex-end;">
            <asp:Button ID="btnExportarExcel" runat="server" Text="📊 Excel" 
                CssClass="btn-modern btn-success-modern" OnClick="btnExportarExcel_Click" />
            <asp:Button ID="btnExportarCSV" runat="server" Text="📄 CSV" 
                CssClass="btn-modern btn-info-modern" OnClick="btnExportarCSV_Click" />
            <asp:Button ID="btnExportarCambios" runat="server" Text="📝 Cambios" 
                CssClass="btn-modern btn-secondary-modern" OnClick="btnExportarCambios_Click" />
        </div>
    </div>

    <!-- Estadísticas -->
    <div>
        <h2 style="font-size: 1.5rem; margin-bottom: 1.5rem; margin-top: 3rem; color: var(--text);">📊 Estadísticas del Curso</h2>
        
        <div class="stats-grid fade-in">
            <!-- Mejor Calificación -->
            <div class="stat-widget">
                <div class="stat-widget-content">
                    <div class="stat-label">🏆 Mejor Calificación</div>
                    <div class="stat-value">
                        <asp:Label ID="lblMejorCalif" runat="server">-</asp:Label>
                    </div>
                    <div class="stat-detail">
                        <asp:Label ID="lblMejor" runat="server">Sin datos</asp:Label>
                    </div>
                    <div class="stat-bar">
                        <div class="stat-bar-fill" style="width: 100%;"></div>
                    </div>
                </div>
            </div>

            <!-- Peor Calificación -->
            <div class="stat-widget">
                <div class="stat-widget-content">
                    <div class="stat-label">⚠️ Peor Calificación</div>
                    <div class="stat-value">
                        <asp:Label ID="lblPeorCalif" runat="server">-</asp:Label>
                    </div>
                    <div class="stat-detail">
                        <asp:Label ID="lblPeor" runat="server">Sin datos</asp:Label>
                    </div>
                    <div class="stat-bar">
                        <div class="stat-bar-fill" style="width: 100%;"></div>
                    </div>
                </div>
            </div>

            <!-- Promedio General -->
            <div class="stat-widget">
                <div class="stat-widget-content">
                    <div class="stat-label">📈 Promedio del Curso</div>
                    <div class="stat-value">
                        <asp:Label ID="lblPromedioVal" runat="server">-</asp:Label>
                    </div>
                    <div class="stat-detail">
                        <asp:Label ID="lblPromedio" runat="server">Sin datos</asp:Label>
                    </div>
                    <div class="stat-bar">
                        <div id="progresoPromedio" class="stat-bar-fill" style="width: 0%;"></div>
                    </div>
                </div>
            </div>

            <!-- Aprobados -->
            <div class="stat-widget">
                <div class="stat-widget-content">
                    <div class="stat-label">✅ Alumnos Aprobados</div>
                    <div class="stat-value">
                        <asp:Label ID="lblAprobadosNum" runat="server">0</asp:Label>
                    </div>
                    <div class="stat-detail">
                        <asp:Label ID="lblAprobados" runat="server">0%</asp:Label>
                    </div>
                    <div class="stat-bar">
                        <div class="stat-bar-fill" style="width: 0%;"></div>
                    </div>
                </div>
            </div>

            <!-- Reprobados -->
            <div class="stat-widget">
                <div class="stat-widget-content">
                    <div class="stat-label">❌ Alumnos Reprobados</div>
                    <div class="stat-value">
                        <asp:Label ID="lblReprobadosNum" runat="server">0</asp:Label>
                    </div>
                    <div class="stat-detail">
                        <asp:Label ID="lblReprobados" runat="server">0%</asp:Label>
                    </div>
                    <div class="stat-bar">
                        <div class="stat-bar-fill" style="width: 0%;"></div>
                    </div>
                </div>
            </div>

            <!-- Total Alumnos -->
            <div class="stat-widget">
                <div class="stat-widget-content">
                    <div class="stat-label">👥 Total de Alumnos</div>
                    <div class="stat-value">
                        <asp:Label ID="lblTotalAlumnos" runat="server">0</asp:Label>
                    </div>
                    <div class="stat-detail">Registrados en el sistema</div>
                    <div class="stat-bar">
                        <div class="stat-bar-fill" style="width: 100%;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- Script Dark Mode Funcional -->
<script>
    (function () {
        const toggleBtn = document.getElementById('toggleTheme');
        
        function applyTheme(isDark) {
            if (isDark) {
                document.body.classList.add('dark-mode');
                toggleBtn.textContent = '☀️ Light Mode';
                localStorage.setItem('theme', 'dark');
            } else {
                document.body.classList.remove('dark-mode');
                toggleBtn.textContent = '🌙 Dark Mode';
                localStorage.setItem('theme', 'light');
            }
        }

        function initTheme() {
            const saved = localStorage.getItem('theme');
            const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            applyTheme(saved ? saved === 'dark' : prefersDark);
        }

        toggleBtn.addEventListener('click', function () {
            const isDark = document.body.classList.contains('dark-mode');
            applyTheme(!isDark);
        });

        // Inicializar tema al cargar
        document.addEventListener('DOMContentLoaded', initTheme);

        // Sincronizar cuando cambia la preferencia del sistema
        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
            if (!localStorage.getItem('theme')) {
                applyTheme(e.matches);
            }
        });
    })();

    // Actualizar barra de progreso
    function actualizarBarraProgreso() {
        const promedioText = document.getElementById('<%= lblPromedioVal.ClientID %>').textContent.trim();
        if (promedioText && promedioText !== '-') {
            const promedio = parseFloat(promedioText);
            const porcentaje = Math.min((promedio / 100) * 100, 100);
            const barra = document.getElementById('progresoPromedio');
            if (barra) {
                barra.style.width = porcentaje + '%';
            }
        }
    }

    // Ejecutar después del DOM listo
    document.addEventListener('DOMContentLoaded', actualizarBarraProgreso);

    // Soporte para postbacks ASP.NET
    if (window.Sys && Sys.WebForms && Sys.WebForms.PageRequestManager) {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(actualizarBarraProgreso);
    }
</script>

</asp:Content>