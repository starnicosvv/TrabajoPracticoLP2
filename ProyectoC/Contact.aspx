<%@ Page Title="Documentación" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="ProyectoC.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

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
        --shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
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

    .doc-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 2rem;
    }

    .doc-header {
        background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        color: white;
        padding: 3rem 2rem;
        border-radius: 16px;
        margin-bottom: 3rem;
        box-shadow: var(--shadow-lg);
    }

    .doc-header h1 {
        font-size: 2.5rem;
        margin-bottom: 0.5rem;
        font-weight: 700;
    }

    .doc-header p {
        font-size: 1.1rem;
        opacity: 0.95;
        margin: 0;
    }

    .doc-section {
        background: var(--bg-card);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 2rem;
        margin-bottom: 2rem;
        box-shadow: var(--shadow);
        transition: var(--transition);
    }

    .doc-section:hover {
        box-shadow: var(--shadow-lg);
        border-color: var(--primary);
    }

    .doc-section h2 {
        color: var(--primary);
        font-size: 1.8rem;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .doc-section h3 {
        color: var(--text);
        font-size: 1.3rem;
        margin-top: 1.5rem;
        margin-bottom: 1rem;
        padding-bottom: 0.75rem;
        border-bottom: 2px solid var(--border);
    }

    .doc-section p {
        color: var(--text-muted);
        font-size: 1rem;
        line-height: 1.8;
        margin-bottom: 1rem;
    }

    .doc-section ul, .doc-section ol {
        color: var(--text-muted);
        font-size: 1rem;
        line-height: 1.8;
        margin-left: 2rem;
        margin-bottom: 1rem;
    }

    .doc-section li {
        margin-bottom: 0.75rem;
    }

    .code-block {
        background: linear-gradient(135deg, var(--dark) 0%, #0f172a 100%);
        color: #e0e0e0;
        padding: 1.5rem;
        border-radius: 8px;
        overflow-x: auto;
        margin: 1.5rem 0;
        font-family: 'Courier New', monospace;
        font-size: 0.9rem;
        line-height: 1.6;
        border-left: 4px solid var(--primary);
    }

    .feature-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1.5rem;
        margin: 2rem 0;
    }

    .feature-card {
        background: linear-gradient(135deg, rgba(99, 102, 241, 0.05), rgba(139, 92, 246, 0.05));
        border: 1px solid var(--border);
        border-radius: 8px;
        padding: 1.5rem;
        transition: var(--transition);
    }

    .feature-card:hover {
        transform: translateY(-4px);
        border-color: var(--primary);
        box-shadow: var(--shadow-lg);
    }

    .feature-card h4 {
        color: var(--primary);
        font-size: 1.1rem;
        margin-bottom: 0.75rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .feature-card p {
        color: var(--text-muted);
        font-size: 0.95rem;
        margin: 0;
    }

    .architecture-diagram {
        background: var(--light);
        border: 2px solid var(--border);
        border-radius: 8px;
        padding: 2rem;
        margin: 2rem 0;
        text-align: center;
    }

    body.dark-mode .architecture-diagram {
        background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
    }

    .flow-box {
        display: inline-block;
        background: var(--primary);
        color: white;
        padding: 1rem 1.5rem;
        border-radius: 8px;
        margin: 0.5rem;
        font-weight: 600;
        min-width: 150px;
    }

    .flow-arrow {
        display: inline-block;
        color: var(--primary);
        font-size: 1.5rem;
        margin: 0 0.5rem;
    }

    .highlight {
        background: linear-gradient(120deg, rgba(99, 102, 241, 0.2), rgba(139, 92, 246, 0.2));
        padding: 1rem;
        border-radius: 8px;
        border-left: 4px solid var(--primary);
        margin: 1rem 0;
    }

    .step-list {
        counter-reset: step-counter;
        list-style: none;
        padding: 0;
    }

    .step-list li {
        counter-increment: step-counter;
        display: flex;
        gap: 1.5rem;
        margin-bottom: 1.5rem;
        padding: 1rem;
        background: linear-gradient(135deg, rgba(99, 102, 241, 0.05), transparent);
        border-radius: 8px;
        border-left: 4px solid var(--primary);
    }

    .step-list li::before {
        content: counter(step-counter);
        display: flex;
        align-items: center;
        justify-content: center;
        width: 2rem;
        height: 2rem;
        background: var(--primary);
        color: white;
        border-radius: 50%;
        font-weight: 700;
        flex-shrink: 0;
    }

    .step-content {
        flex: 1;
    }

    .step-content strong {
        color: var(--text);
        display: block;
        margin-bottom: 0.25rem;
        font-size: 1.05rem;
    }

    .step-content span {
        color: var(--text-muted);
        font-size: 0.95rem;
    }

    .toc {
        background: linear-gradient(135deg, rgba(99, 102, 241, 0.05), rgba(139, 92, 246, 0.05));
        border: 1px solid var(--border);
        border-radius: 8px;
        padding: 1.5rem;
        margin-bottom: 2rem;
    }

    .toc h3 {
        color: var(--primary);
        margin-top: 0;
    }

    .toc ul {
        margin: 0;
        padding-left: 2rem;
    }

    .toc a {
        color: var(--primary);
        text-decoration: none;
        transition: var(--transition);
    }

    .toc a:hover {
        color: var(--secondary);
        text-decoration: underline;
    }

    .icon-badge {
        display: inline-block;
        font-size: 1.5rem;
        margin-right: 0.5rem;
    }

    body.dark-mode .code-block {
        background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
    }

    @media (max-width: 768px) {
        .doc-container {
            padding: 1rem;
        }

        .doc-header {
            padding: 2rem 1rem;
        }

        .doc-header h1 {
            font-size: 1.8rem;
        }

        .feature-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="doc-container">
    <!-- Header -->
    <div class="doc-header">
        <h1>📚 Documentación Técnica</h1>
        <p>Gestor de Calificaciones - Arquitectura, Lógica y Funcionamiento</p>
    </div>

    <!-- Tabla de Contenidos -->
    <div class="toc">
        <h3>📑 Índice</h3>
        <ul>
            <li><a href="#vision">Visión General del Proyecto</a></li>
            <li><a href="#arquitectura">Arquitectura del Sistema</a></li>
            <li><a href="#capas">Capas de la Aplicación</a></li>
            <li><a href="#flujo">Flujo de Datos</a></li>
            <li><a href="#ordenamiento">Sistema de Ordenamiento</a></li>
            <li><a href="#sesion">Manejo de Sesiones</a></li>
            <li><a href="#features">Características Principales</a></li>
        </ul>
    </div>

    <!-- Sección 1: Visión General -->
    <div class="doc-section" id="vision">
        <h2><span class="icon-badge">🎯</span>Visión General del Proyecto</h2>
        
        <p>El <strong>Gestor de Calificaciones</strong> es una aplicación web moderna construida con <strong>ASP.NET Framework 4.7.2</strong> que permite administrar de forma intuitiva las notas y calificaciones de alumnos. Proporciona un sistema completo para:</p>
        
        <ul>
            <li>✅ Registrar, editar y eliminar calificaciones de alumnos</li>
            <li>📊 Generar estadísticas automáticas del desempeño académico</li>
            <li>📤 Exportar datos en múltiples formatos (Excel, CSV, TXT)</li>
            <li>🔍 Buscar y filtrar alumnos por nombre o matrícula</li>
            <li>⬆️ Ordenar la grilla por diversos criterios</li>
            <li>🌓 Interfaz con tema claro y oscuro adaptativo</li>
            <li>📱 Diseño responsive para todos los dispositivos</li>
        </ul>

        <div class="highlight">
            <strong>Objetivo Principal:</strong> Simplificar la gestión académica mediante una interfaz intuitiva, profesional y tecnológicamente avanzada que optimice el tiempo de administración de calificaciones.
        </div>
    </div>

    <!-- Sección 2: Arquitectura -->
    <div class="doc-section" id="arquitectura">
        <h2><span class="icon-badge">🏗️</span>Arquitectura del Sistema</h2>
        
        <p>La aplicación sigue una arquitectura en <strong>3 capas</strong> (N-Tier), garantizando separación de responsabilidades y mantenibilidad:</p>

        <div class="architecture-diagram">
            <div style="margin-bottom: 1rem;">
                <div class="flow-box">Presentación (UI)</div>
                <div class="flow-arrow">↓</div>
                <div class="flow-box">Lógica de Negocio (BLL)</div>
                <div class="flow-arrow">↓</div>
                <div class="flow-box">Datos (DTO/Sesión)</div>
            </div>
        </div>

        <h3>Capas de Arquitectura:</h3>
        
        <div class="feature-grid">
            <div class="feature-card">
                <h4>🎨 Presentación</h4>
                <p>ASPX con controles Web Forms, formularios interactivos, grilla de datos y estadísticas visuales en tiempo real.</p>
            </div>
            <div class="feature-card">
                <h4>⚙️ Lógica de Negocio</h4>
                <p>Clase Calculos con métodos para cálculo de promedios, validaciones y estadísticas académicas.</p>
            </div>
            <div class="feature-card">
                <h4>💾 Datos</h4>
                <p>DTOs (Alumno) almacenados en sesión del servidor. Modelo de datos serializable para persistencia.</p>
            </div>
        </div>
    </div>

    <!-- Sección 3: Capas -->
    <div class="doc-section" id="capas">
        <h2><span class="icon-badge">📦</span>Capas de la Aplicación</h2>

        <h3>Capa de Presentación (ProyectoC)</h3>
        <p>Archivo: <code>Notas.aspx</code> y <code>Notas.aspx.cs</code></p>
        <ul>
            <li><strong>Formularios:</strong> Ingreso de datos con validación cliente-lado</li>
            <li><strong>GridView:</strong> Visualización de alumnos con acciones (Editar/Eliminar)</li>
            <li><strong>Estadísticas:</strong> Dashboard con widgets interactivos</li>
            <li><strong>Estilos:</strong> CSS moderno con variables CSS y dark mode</li>
            <li><strong>JavaScript:</strong> Lógica de temas, progreso y interactividad</li>
        </ul>

        <h3>Capa de Lógica de Negocio (BLL)</h3>
        <p>Ubicación: <code>BLL/Fachaada/CALCULARCALIF.cs</code></p>
        <div class="code-block">
public static class Calculos
{
    // Calcula total de notas: P1 + P2 + TP + ExamenFinal
    public static double CalcularTotal(double p1, double p2, double tp, double ex)
    {
        return p1 + p2 + tp + ex;
    }

    // Retorna calificación cualitativa según rango
    public static string CalcularCalificacionFinal(double total)
    {
        if (total >= 92) return "5 (Excelente)";
        if (total >= 82) return "4 (Muy Bien)";
        if (total >= 71) return "3 (Bien)";
        if (total >= 60) return "2 (Aprobado)";
        return "Reprobado";
    }

    // Genera estadísticas completas del curso
    public static (...) CalcularEstadisticas(List&lt;Alumno&gt; alumnos)
    {
        // Retorna: mejor, mejoresNombres, peor, peoresNombres, 
        // promedio, aprobados, reprobados
    }
}
        </div>

        <h3>Capa de Datos (DTOs)</h3>
        <p>Ubicación: <code>BLL/DTOO/DTOCALIFICACIONES.cs</code></p>
        <div class="code-block">
[Serializable]
public class Alumno
{
    public string Nombre { get; set; }
    public string Materia { get; set; }
    public string Matricula { get; set; }
    public double Parcial1 { get; set; }
    public double Parcial2 { get; set; }
    public double TP { get; set; }
    public double ExamenFinal { get; set; }
    public double Total { get; set; }
    public string CalificacionFinal { get; set; }
}
        </div>
    </div>

    <!-- Sección 4: Flujo de Datos -->
    <div class="doc-section" id="flujo">
        <h2><span class="icon-badge">🔄</span>Flujo de Datos</h2>

        <p>El flujo completo de una operación en el sistema:</p>

        <ol class="step-list">
            <li>
                <div class="step-content">
                    <strong>Usuario ingresa datos en formulario</strong>
                    <span>El usuario completa nombre, materia, matrícula y calificaciones en los controles TextBox y DropDownList.</span>
                </div>
            </li>
            <li>
                <div class="step-content">
                    <strong>Validación en Code-Behind</strong>
                    <span>btnAgregar_Click valida que los datos sean numéricos y estén dentro de rangos permitidos (P1: 0-20, P2: 0-20, TP: 0-10, Examen: 0-50).</span>
                </div>
            </li>
            <li>
                <div class="step-content">
                    <strong>Cálculos de negocio</strong>
                    <span>Se invocan métodos de la clase Calculos para determinar Total y CalificacionFinal.</span>
                </div>
            </li>
            <li>
                <div class="step-content">
                    <strong>Creación de objeto Alumno</strong>
                    <span>Se instancia un nuevo DTO con todos los datos calculados.</span>
                </div>
            </li>
            <li>
                <div class="step-content">
                    <strong>Almacenamiento en sesión</strong>
                    <span>El alumno se agrega a la propiedad Session["Alumnos"] que persiste durante toda la sesión del usuario.</span>
                </div>
            </li>
            <li>
                <div class="step-content">
                    <strong>Registro de cambios</strong>
                    <span>Se registra la acción en Session["Cambios"] con timestamp para auditoría.</span>
                </div>
            </li>
            <li>
                <div class="step-content">
                    <strong>Actualización de UI</strong>
                    <span>Se ejecuta BindGrilla() y ActualizarEstadisticas() para reflejar cambios en la interfaz.</span>
                </div>
            </li>
        </ol>

        <div class="highlight">
            <strong>Nota Importante:</strong> Los datos se almacenan en sesión del servidor (en memoria). Para una aplicación de producción, se recomienda usar una base de datos SQL Server o similar.
        </div>
    </div>

    <!-- Sección 5: Ordenamiento -->
    <div class="doc-section" id="ordenamiento">
        <h2><span class="icon-badge">⬆️</span>Sistema de Ordenamiento Inteligente</h2>

        <p>El ordenamiento de la grilla es completamente dinámico y se ejecuta en tiempo real mediante LINQ (Language Integrated Query).</p>

        <h3>¿Cómo funciona?</h3>

        <div class="code-block">
protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
{
    string sortOption = ddlSort.SelectedValue;
    List&lt;Alumno&gt; ordenados = new List&lt;Alumno&gt;(Alumnos);

    // Se clona la lista original para no alterar datos
    switch (sortOption)
    {
        case "nombre_asc":
            ordenados = ordenados.OrderBy(a =&gt; a.Nombre).ToList();
            break;
        case "nombre_desc":
            ordenados = ordenados.OrderByDescending(a =&gt; a.Nombre).ToList();
            break;
        case "total_asc":
            ordenados = ordenados.OrderBy(a =&gt; a.Total).ToList();
            break;
        case "total_desc":
            ordenados = ordenados.OrderByDescending(a =&gt; a.Total).ToList();
            break;
        // ... más opciones
    }

    // Se actualiza sesión y se rebinda la grilla
    AlumnosOrdenados = ordenados;
    BindGrilla(ordenados);
    ActualizarEstadisticas();
}
        </div>

        <h3>Opciones de Ordenamiento:</h3>

        <div class="feature-grid">
            <div class="feature-card">
                <h4>👤 Por Nombre</h4>
                <p>Orden alfabético ascendente (A→Z) o descendente (Z→A)</p>
            </div>
            <div class="feature-card">
                <h4>🆔 Por Matrícula</h4>
                <p>Orden numérico de IDs de menor a mayor o viceversa</p>
            </div>
            <div class="feature-card">
                <h4>📊 Por Total</h4>
                <p>Ordenamiento por calificaciones de mayor a menor desempeño</p>
            </div>
            <div class="feature-card">
                <h4>📚 Por Materia</h4>
                <p>Agrupación alfabética de asignaturas</p>
            </div>
        </div>

        <h3>Tecnología LINQ:</h3>
        <p>Se utiliza <strong>LINQ to Objects</strong> que permite:</p>
        <ul>
            <li>✓ Sintaxis declarativa y legible</li>
            <li>✓ Ejecución lazy (diferida) de consultas</li>
            <li>✓ Operaciones seguras sin modificar datos originales</li>
            <li>✓ Performance optimizado en memoria</li>
        </ul>

        <div class="highlight">
            <strong>Ventaja clave:</strong> El ordenamiento es instantáneo porque se ejecuta en RAM del servidor, sin necesidad de acceder a base de datos.
        </div>
    </div>

    <!-- Sección 6: Sesiones -->
    <div class="doc-section" id="sesion">
        <h2><span class="icon-badge">🔐</span>Manejo de Sesiones</h2>

        <h3>Propiedades de Sesión:</h3>

        <div class="code-block">
// Almacena lista de alumnos
private List&lt;Alumno&gt; Alumnos
{
    get
    {
        if (Session["Alumnos"] == null)
            Session["Alumnos"] = new List&lt;Alumno&gt;();
        return (List&lt;Alumno&gt;)Session["Alumnos"];
    }
    set { Session["Alumnos"] = value; }
}

// Registra todos los cambios realizados
private List&lt;string&gt; Cambios
{
    get
    {
        if (Session["Cambios"] == null)
            Session["Cambios"] = new List&lt;string&gt;();
        return (List&lt;string&gt;)Session["Cambios"];
    }
    set { Session["Cambios"] = value; }
}

// Mantiene estado del ordenamiento actual
private List&lt;Alumno&gt; AlumnosOrdenados
{
    get
    {
        if (Session["AlumnosOrdenados"] == null)
            return Alumnos;
        return (List&lt;Alumno&gt;)Session["AlumnosOrdenados"];
    }
    set { Session["AlumnosOrdenados"] = value; }
}
        </div>

        <h3>Beneficios del enfoque con Sesiones:</h3>
        <ul>
            <li>🔒 <strong>Seguridad:</strong> Cada usuario tiene sus datos aislados</li>
            <li>⚡ <strong>Performance:</strong> Los datos residen en memoria, acceso muy rápido</li>
            <li>🔄 <strong>Estado persistente:</strong> Los datos se mantienen durante toda la sesión</li>
            <li>📊 <strong>Auditoría:</strong> Se registran todos los cambios con timestamp</li>
        </ul>

        <div class="highlight">
            <strong>Limitación:</strong> La sesión expira después de 20 minutos de inactividad (configurable en web.config). Los datos se pierden al cerrar navegador o al timeout.
        </div>
    </div>

    <!-- Sección 7: Features -->
    <div class="doc-section" id="features">
        <h2><span class="icon-badge">✨</span>Características Principales</h2>

        <h3>1️⃣ Gestión CRUD Completa</h3>
        <ul>
            <li><strong>Create:</strong> Botón "Agregar Alumno" con validación</li>
            <li><strong>Read:</strong> GridView muestra todos los alumnos registrados</li>
            <li><strong>Update:</strong> Botón "Editar" carga datos en formulario</li>
            <li><strong>Delete:</strong> Botón "Eliminar" con confirmación</li>
        </ul>

        <h3>2️⃣ Búsqueda y Filtrado</h3>
        <p>Campo de búsqueda que filtra por nombre o matrícula en tiempo real con LINQ.</p>

        <h3>3️⃣ Estadísticas Dinámicas</h3>
        <p>Dashboard con 6 widgets que calculan automáticamente:</p>
        <ul>
            <li>📈 Mejor calificación con nombres de estudiantes</li>
            <li>📉 Peor calificación con nombres de estudiantes</li>
            <li>📊 Promedio general del curso</li>
            <li>✅ Cantidad y porcentaje de aprobados</li>
            <li>❌ Cantidad y porcentaje de reprobados</li>
            <li>👥 Total de alumnos registrados</li>
        </ul>

        <h3>4️⃣ Exportación Múltiple</h3>
        <ul>
            <li>📊 <strong>Excel:</strong> Archivo XLSX con formato profesional</li>
            <li>📄 <strong>CSV:</strong> Formato universal para hojas de cálculo</li>
            <li>📝 <strong>Cambios:</strong> Archivo TXT con auditoría completa</li>
        </ul>

        <h3>5️⃣ Tema Adaptativo</h3>
        <ul>
            <li>🌞 Modo claro con colores profesionales</li>
            <li>🌙 Modo oscuro para reducir fatiga visual</li>
            <li>💾 Persistencia en localStorage del navegador</li>
            <li>🎨 Variables CSS dinámicas para facilitar customización</li>
        </ul>

        <h3>6️⃣ Diseño Responsive</h3>
        <p>Interfaz optimizada para:</p>
        <ul>
            <li>💻 Escritorio (1200px+)</li>
            <li>📱 Tablet (768px - 1199px)</li>
            <li>📲 Móvil (< 768px)</li>
        </ul>

        <div class="highlight">
            <strong>Arquitectura Frontend:</strong> Bootstrap 5 + CSS personalizado con Grid Layout y Flexbox para máxima flexibilidad.
        </div>
    </div>

    <!-- Stack Tecnológico -->
    <div class="doc-section">
        <h2><span class="icon-badge">🛠️</span>Stack Tecnológico</h2>

        <div class="feature-grid">
            <div class="feature-card">
                <h4>Backend</h4>
                <p>ASP.NET Web Forms 4.7.2 con C# 7.3</p>
            </div>
            <div class="feature-card">
                <h4>Frontend</h4>
                <p>HTML5, CSS3, JavaScript vanilla, Bootstrap 5</p>
            </div>
            <div class="feature-card">
                <h4>Exportación</h4>
                <p>ClosedXML para Excel, CSV nativo, TXT</p>
            </div>
            <div class="feature-card">
                <h4>Datos</h4>
                <p>Sesión de servidor (en memoria)</p>
            </div>
        </div>
    </div>

</div>

</asp:Content>
