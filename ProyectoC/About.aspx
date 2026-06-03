<%@ Page Title="Informacion Sobre el Algoritmo de busqueda" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="ProyectoC.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %>.</h2>

        <style>
.card {
    border-radius: 12px;
}

.card-header {
    border-radius: 12px 12px 0 0 !important;
}

pre {
    font-size: 14px;
    line-height: 1.3;
    overflow-x: auto;
}

h4 {
    margin-top: 20px;
    margin-bottom: 15px;
    font-weight: 600;
}

.table td,
.table th {
    vertical-align: middle;
}
        </style>

<div class="card shadow-sm border-0 mt-4">
    <div class="card-header bg-primary text-white">
        <h3 class="mb-0">
            <i class="fas fa-search"></i>
            Manual Técnico – Módulo de Búsqueda en la Grilla de Alumnos
        </h3>
    </div>

    <div class="card-body">

        
        <h4 class="text-primary">1. Componentes principales</h4>

        <table class="table table-bordered table-hover">
            <thead class="table-light">
                <tr>
                    <th>Componente</th>
                    <th>Descripción</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>TextBox (txtBusqueda)</strong></td>
                    <td>Recibe el criterio de búsqueda (Nombre o Matrícula).</td>
                </tr>
                <tr>
                    <td><strong>Botón Buscar (btnBuscar)</strong></td>
                    <td>Ejecuta el proceso de filtrado.</td>
                </tr>
                <tr>
                    <td><strong>Botón Limpiar (btnLimpiar)</strong></td>
                    <td>Restablece la grilla y las estadísticas.</td>
                </tr>
                <tr>
                    <td><strong>GridView (gvNotas)</strong></td>
                    <td>Muestra los resultados encontrados.</td>
                </tr>
                <tr>
                    <td><strong>Session["Alumnos"]</strong></td>
                    <td>Lista almacenada en memoria con todos los registros cargados.</td>
                </tr>
            </tbody>
        </table>

        <hr />

        
        <h4 class="text-primary">2. Flujo de ejecución – Buscar</h4>

        <ol class="list-group list-group-numbered mb-4">
            <li class="list-group-item">
                El usuario ingresa un criterio de búsqueda en <strong>txtBusqueda</strong>.
            </li>
            <li class="list-group-item">
                Al presionar <strong>Buscar</strong>, se ejecuta el evento
                <code>btnBuscar_Click</code>.
            </li>
            <li class="list-group-item">
                El texto ingresado se normaliza utilizando
                <code>Trim()</code> y <code>ToLower()</code>.
            </li>
            <li class="list-group-item">
                Se aplica un filtro sobre la colección
                <strong>Alumnos</strong> mediante <code>FindAll()</code>.
            </li>
            <li class="list-group-item">
                La lista filtrada se asigna al <strong>GridView</strong> mediante
                <code>DataSource</code> y <code>DataBind()</code>.
            </li>
            <li class="list-group-item">
                Se recalculan las estadísticas según los resultados obtenidos.
            </li>
            <li class="list-group-item">
                Si no existen coincidencias, se muestran guiones (-) en los indicadores.
            </li>
        </ol>

        <hr />

        
        <h4 class="text-primary">3. Flujo de ejecución – Limpiar búsqueda</h4>

        <ol class="list-group list-group-numbered mb-4">
            <li class="list-group-item">
                El usuario presiona <strong>Limpiar búsqueda</strong>.
            </li>
            <li class="list-group-item">
                Se ejecuta el evento <code>btnLimpiar_Click</code>.
            </li>
            <li class="list-group-item">
                Se limpia el contenido de <code>txtBusqueda.Text</code>.
            </li>
            <li class="list-group-item">
                Se vuelve a cargar la lista completa de alumnos.
            </li>
            <li class="list-group-item">
                Se actualizan nuevamente las estadísticas generales.
            </li>
        </ol>

        <hr />

        
        <h4 class="text-primary">4. Diagrama de flujo</h4>

        <div class="bg-dark text-light p-4 rounded">
<pre class="text-light mb-0">
                ┌─────────────────────┐
                │ Usuario escribe     │
                │ Nombre/Matrícula    │
                └───────┬─────────────┘
                        │
                        ▼
                ┌─────────────────────┐
                │ Presiona "Buscar"   │
                └───────┬─────────────┘
                        │
                        ▼
          ┌──────────────────────────────────┐
          │ btnBuscar_Click                  │
          │ • Normaliza texto                │
          │ • Filtra lista Alumnos           │
          │ • Actualiza GridView             │
          │ • Calcula estadísticas           │
          └──────────────┬───────────────────┘
                         │
                         ▼
                ┌─────────────────────┐
                │ Mostrar resultados  │
                │ filtrados           │
                └─────────────────────┘


                ┌─────────────────────┐
                │ Limpiar búsqueda    │
                └───────┬─────────────┘
                        │
                        ▼
          ┌──────────────────────────────────┐
          │ btnLimpiar_Click                 │
          │ • Limpia TextBox                 │
          │ • Carga lista completa           │
          │ • Actualiza estadísticas         │
          └──────────────┬───────────────────┘
                         │
                         ▼
                ┌─────────────────────┐
                │ Mostrar todos los   │
                │ alumnos             │
                └─────────────────────┘
</pre>
        </div>

        <hr />

        
        <h4 class="text-primary">5. Ventajas técnicas</h4>

        <div class="row">
            <div class="col-md-6 mb-3">
                <div class="alert alert-success">
                    <strong>Uso eficiente de memoria</strong><br />
                    La búsqueda opera sobre datos almacenados en Session sin consultas externas.
                </div>
            </div>

            <div class="col-md-6 mb-3">
                <div class="alert alert-info">
                    <strong>Flexibilidad</strong><br />
                    Un único campo permite búsquedas por nombre o matrícula.
                </div>
            </div>

            <div class="col-md-6 mb-3">
                <div class="alert alert-warning">
                    <strong>Consistencia</strong><br />
                    Las estadísticas reflejan exactamente la información visible en la grilla.
                </div>
            </div>

            <div class="col-md-6 mb-3">
                <div class="alert alert-secondary">
                    <strong>Reutilización</strong><br />
                    El método <code>CalcularEstadisticas()</code> se utiliza tanto para resultados filtrados como completos.
                </div>
            </div>
        </div>

    </div>
</div>



    </main>
</asp:Content>
