using BLL.DTOO;
using BLL.Fachaada;
using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI.WebControls;

namespace ProyectoC
{
    public partial class Notas : System.Web.UI.Page
    {
        private List<Alumno> Alumnos
        {
            get
            {
                if (Session["Alumnos"] == null)
                    Session["Alumnos"] = new List<Alumno>();
                return (List<Alumno>)Session["Alumnos"];
            }
            set { Session["Alumnos"] = value; }
        }

        // Lista para registrar cambios
        private List<string> Cambios
        {
            get
            {
                if (Session["Cambios"] == null)
                    Session["Cambios"] = new List<string>();
                return (List<string>)Session["Cambios"];
            }
            set { Session["Cambios"] = value; }
        }

        // Agregar esta propiedad para mantener el estado de ordenamiento
        private List<Alumno> AlumnosOrdenados
        {
            get
            {
                if (Session["AlumnosOrdenados"] == null)
                    return Alumnos;
                return (List<Alumno>)Session["AlumnosOrdenados"];
            }
            set { Session["AlumnosOrdenados"] = value; }
        }

        // En Notas.aspx.cs: método para enlazar la lista actual a la grilla
        private void BindGrilla(IEnumerable<Alumno> fuente = null)
        {
            var data = (fuente == null) ? Alumnos : fuente.ToList();
            gvNotas.DataSource = data;
            gvNotas.DataBind();
        }


        // Registrar cambio
        private void RegistrarCambio(string mensaje)
        {
            Cambios.Add($"{DateTime.Now:dd/MM/yyyy HH:mm:ss} - {mensaje}");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvNotas.DataSource = Alumnos;
                gvNotas.DataBind();
                ActualizarEstadisticas();
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            lblError.Text = "";

            // Guardar valores de texto antes de limpiar para evitar registros vacíos
            string nombreInput = txtNombre.Text?.Trim() ?? "";
            string materiaInput = ddlMateria.SelectedValue ?? "";

            try
            {
                if (!double.TryParse(txtParcial1.Text, out double p1) ||
                    !double.TryParse(txtParcial2.Text, out double p2) ||
                    !double.TryParse(txtTP.Text, out double tp) ||
                    !double.TryParse(txtExamenFinal.Text, out double ex))
                {
                    lblError.Text = "⚠️ Error: Verifica que los datos sean numéricos y correctos.";
                    return;
                }

                if (p1 < 0 || p1 > 20 || p2 < 0 || p2 > 20 || tp < 0 || tp > 10 || ex < 0 || ex > 50)
                {
                    lblError.Text = "⚠️ Error: Los valores ingresados superan los límites permitidos.";
                    return;
                }

                double total = Calculos.CalcularTotal(p1, p2, tp, ex);
                string calificacionFinal = Calculos.CalcularCalificacionFinal(total);

                // Si estamos editando por Matricula guardada en ViewState
                string editMatricula = ViewState["EditMatricula"] as string;
                if (!string.IsNullOrWhiteSpace(editMatricula))
                {
                    var existente = Alumnos.FirstOrDefault(a => a.Matricula == editMatricula);
                    if (existente != null)
                    {
                        existente.Nombre = nombreInput;
                        existente.Materia = materiaInput;
                        existente.Matricula = txtMatricula.Text?.Trim() ?? existente.Matricula;
                        existente.Parcial1 = p1;
                        existente.Parcial2 = p2;
                        existente.TP = tp;
                        existente.ExamenFinal = ex;
                        existente.Total = total;
                        existente.CalificacionFinal = calificacionFinal;

                        RegistrarCambio($"Alumno actualizado: {existente.Nombre} - {existente.Materia} - {existente.Matricula}");
                    }

                    ViewState.Remove("EditMatricula");
                    btnAgregar.Text = "Agregar alumno";
                }
                else
                {
                    // Nuevo alumno
                    var alumno = new Alumno
                    {
                        Nombre = nombreInput,
                        Materia = materiaInput,
                        Matricula = txtMatricula.Text?.Trim() ?? "",
                        Parcial1 = p1,
                        Parcial2 = p2,
                        TP = tp,
                        ExamenFinal = ex,
                        Total = total,
                        CalificacionFinal = calificacionFinal
                    };

                    Alumnos.Add(alumno);
                    RegistrarCambio($"Alumno agregado: {alumno.Nombre} - {alumno.Materia} - {alumno.Matricula}");
                }

                gvNotas.DataSource = Alumnos;
                gvNotas.DataBind();
                ActualizarEstadisticas();

                // Limpiar campos después de registrar el cambio
                txtNombre.Text = txtMatricula.Text = txtParcial1.Text = txtParcial2.Text = txtTP.Text = txtExamenFinal.Text = "";
            }
            catch
            {
                lblError.Text = "⚠️ Error: Verifica que los datos sean numéricos y correctos.";
            }
        }

        private void ActualizarEstadisticas()
        {
            // Mostrar total de alumnos
            lblTotalAlumnos.Text = Alumnos.Count.ToString();

            if (Alumnos.Count > 0)
            {
                var (mejor, mejoresNombres, peor, peoresNombres, promedio, aprobados, reprobados) = Calculos.CalcularEstadisticas(Alumnos);

                // Mejor calificación
                lblMejorCalif.Text = mejor.ToString("F2");
                lblMejor.Text = $"Estudiantes: {string.Join(", ", mejoresNombres)}";

                // Peor calificación
                lblPeorCalif.Text = peor.ToString("F2");
                lblPeor.Text = $"Estudiantes: {string.Join(", ", peoresNombres)}";

                // Promedio
                lblPromedioVal.Text = promedio.ToString("F2");
                lblPromedio.Text = $"Desempeño: {(promedio >= 60 ? "✓ Satisfactorio" : "⚠ Requiere mejora")}";
                
                // Aprobados
                lblAprobadosNum.Text = aprobados.ToString();
                double porcentajeAprobados = (aprobados * 100.0) / Alumnos.Count;
                lblAprobados.Text = $"{porcentajeAprobados:F1}";

                // Reprobados
                lblReprobadosNum.Text = reprobados.ToString();
                double porcentajeReprobados = (reprobados * 100.0) / Alumnos.Count;
                lblReprobados.Text = $"{porcentajeReprobados:F1}";
            }
            else
            {
                lblMejorCalif.Text = "-";
                lblMejor.Text = "Sin datos";
                lblPeorCalif.Text = "-";
                lblPeor.Text = "Sin datos";
                lblPromedioVal.Text = "-";
                lblPromedio.Text = "Sin datos";
                lblAprobadosNum.Text = "0";
                lblAprobados.Text = "0%";
                lblReprobadosNum.Text = "0";
                lblReprobados.Text = "0%";
            }
        }

        protected void gvNotas_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            // Debug sólo a la ventana de salida en tiempo de depuración (no en la UI)
#if DEBUG
    System.Diagnostics.Debug.WriteLine($"gvNotas_RowCommand: CommandName='{e.CommandName}' Argument='{e.CommandArgument}'");
#endif

    // Limpiar mensajes previos
    lblError.Text = string.Empty;

    // Intentar resolver matrícula. Se aceptan:
    //  - CommandArgument con la propia matrícula
    //  - CommandArgument con índice de fila (entero) -> obtener DataKeys
    string matricula = null;

    if (e.CommandArgument != null)
    {
        var arg = e.CommandArgument.ToString();
        // Si es un índice numérico, obtener matricula desde DataKeys
        if (int.TryParse(arg, out int posibleIndex))
        {
            if (gvNotas.DataKeys != null && gvNotas.DataKeys.Count > posibleIndex && gvNotas.DataKeys[posibleIndex].Value != null)
            {
                matricula = gvNotas.DataKeys[posibleIndex].Value.ToString();
            }
        }
        else
        {
            // No es índice: tomar directamente como matrícula
            matricula = arg;
        }
    }

    // Fallback: intentar vía NamingContainer
    if (string.IsNullOrWhiteSpace(matricula))
    {
        var source = e.CommandSource as System.Web.UI.Control;
        if (source != null)
        {
            var row = source.NamingContainer as System.Web.UI.WebControls.GridViewRow;
            if (row != null)
            {
                int idx = row.RowIndex;
                if (gvNotas.DataKeys != null && gvNotas.DataKeys.Count > idx && gvNotas.DataKeys[idx].Value != null)
                {
                    matricula = gvNotas.DataKeys[idx].Value.ToString();
                }
            }
        }
    }

    if (string.IsNullOrWhiteSpace(matricula))
    {
        lblError.Text = "No se pudo determinar el identificador de la fila (matrícula).";
        return;
    }

    // Buscar el alumno en la lista en memoria
    var alumno = Alumnos.FirstOrDefault(a => string.Equals(a.Matricula?.Trim(), matricula.Trim(), StringComparison.OrdinalIgnoreCase));
    if (alumno == null)
    {
        lblError.Text = $"Alumno con matrícula '{matricula}' no encontrado.";
        return;
    }

    if (string.Equals(e.CommandName, "Eliminar", StringComparison.OrdinalIgnoreCase))
    {
        Alumnos.Remove(alumno);
        RegistrarCambio($"Alumno eliminado: {alumno.Nombre} - {alumno.Matricula}");
        BindGrilla();
        ActualizarEstadisticas();
        // confirmar visualmente (opcional): lblError.Text = "Alumno eliminado correctamente.";
        return;
    }

    if (string.Equals(e.CommandName, "Editar", StringComparison.OrdinalIgnoreCase))
    {
        // Cargar datos en formulario para edición
        txtNombre.Text = alumno.Nombre;
        ddlMateria.SelectedValue = alumno.Materia;
        txtMatricula.Text = alumno.Matricula;
        txtParcial1.Text = alumno.Parcial1.ToString();
        txtParcial2.Text = alumno.Parcial2.ToString();
        txtTP.Text = alumno.TP.ToString();
        txtExamenFinal.Text = alumno.ExamenFinal.ToString();

        // Guardar identificador persistente
        ViewState["EditMatricula"] = alumno.Matricula;
        btnAgregar.Text = "Actualizar alumno";  
        return;
    }
}

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string criterio = (txtBusqueda.Text ?? "").Trim().ToLower();
            if (string.IsNullOrEmpty(criterio))
            {
                BindGrilla(); // mostrar todo
                ActualizarEstadisticas();
                return;
            }

            var filtrados = Alumnos.Where(a =>
                (a.Nombre ?? "").ToLower().Contains(criterio) ||
                (a.Matricula ?? "").ToLower().Contains(criterio)).ToList();

            BindGrilla(filtrados);

            // actualizar estadísticas sobre filtrados
            if (filtrados.Any())
            {
                var (mejor, mejoresNombres, peor, peoresNombres, promedio, aprobados, reprobados) = Calculos.CalcularEstadisticas(filtrados.ToList());
                lblMejor.Text = $"Mejor: {mejor} ({string.Join(", ", mejoresNombres)})";
                lblPeor.Text = $"Peor: {peor} ({string.Join(", ", peoresNombres)})";
                lblPromedio.Text = $"Promedio: {promedio:F2}";
                lblAprobados.Text = $"Aprobados: {aprobados}";
                lblReprobados.Text = $"Reprobados: {reprobados}";
            }
            else
            {
                lblMejor.Text = lblPeor.Text = lblPromedio.Text = lblAprobados.Text = lblReprobados.Text = "-";
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBusqueda.Text = "";
            gvNotas.DataSource = Alumnos;
            gvNotas.DataBind();
            ActualizarEstadisticas();
        }

        protected void btnExportarExcel_Click(object sender, EventArgs e)
        {
            using (var workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add("Alumnos");

                worksheet.Cell(1, 1).Value = "Nombre";
                worksheet.Cell(1, 2).Value = "Materia";
                worksheet.Cell(1, 3).Value = "Matrícula";
                worksheet.Cell(1, 4).Value = "Parcial 1";
                worksheet.Cell(1, 5).Value = "Parcial 2";
                worksheet.Cell(1, 6).Value = "TP";
                worksheet.Cell(1, 7).Value = "Examen Final";
                worksheet.Cell(1, 8).Value = "Total";
                worksheet.Cell(1, 9).Value = "Calificación Final";

                int fila = 2;
                foreach (var alumno in Alumnos)
                {
                    worksheet.Cell(fila, 1).Value = alumno.Nombre;
                    worksheet.Cell(fila, 2).Value = alumno.Materia;
                    worksheet.Cell(fila, 3).Value = alumno.Matricula;
                    worksheet.Cell(fila, 4).Value = alumno.Parcial1;
                    worksheet.Cell(fila, 5).Value = alumno.Parcial2;
                    worksheet.Cell(fila, 6).Value = alumno.TP;
                    worksheet.Cell(fila, 7).Value = alumno.ExamenFinal;
                    worksheet.Cell(fila, 8).Value = alumno.Total;
                    worksheet.Cell(fila, 9).Value = alumno.CalificacionFinal;
                    fila++;
                }

                worksheet.Columns().AdjustToContents();

                using (var stream = new MemoryStream())
                {
                    workbook.SaveAs(stream);
                    byte[] content = stream.ToArray();

                    Response.Clear();
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=Alumnos.xlsx");
                    Response.BinaryWrite(content);
                    Response.End();
                }
            }
        }

        protected void btnExportarCSV_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Alumnos.csv");
            Response.Charset = "";
            Response.ContentType = "text/csv";

            using (StringWriter sw = new StringWriter())
            {
                sw.WriteLine("Nombre,Materia,Matrícula,Parcial1,Parcial2,TP,ExamenFinal,Total,CalificaciónFinal");

                foreach (var alumno in Alumnos)
                {
                    sw.WriteLine($"{EscapeCsv(alumno.Nombre)},{EscapeCsv(alumno.Materia)},{EscapeCsv(alumno.Matricula)},{alumno.Parcial1},{alumno.Parcial2},{alumno.TP},{alumno.ExamenFinal},{alumno.Total},{EscapeCsv(alumno.CalificacionFinal)}");
                }

                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }

        // Exportar cambios a archivo TXT
        protected void btnExportarCambios_Click(object sender, EventArgs e)
        {
            string fileName = "Cambios.txt";
            Response.Clear();
            Response.ContentType = "text/plain";
            Response.AddHeader("Content-Disposition", $"attachment;filename={fileName}");

            foreach (var cambio in Cambios)
            {
                Response.Write(cambio + Environment.NewLine);
            }

            Response.End();
        }
        // Notas.aspx.cs — dentro de la clase partial Notas
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Limpiar campos del formulario
            txtNombre.Text = string.Empty;
            txtMatricula.Text = string.Empty;
            txtParcial1.Text = string.Empty;
            txtParcial2.Text = string.Empty;
            txtTP.Text = string.Empty;
            txtExamenFinal.Text = string.Empty;

            // Quitar estado de edición si existiera
            ViewState.Remove("EditMatricula");
            btnAgregar.Text = "Agregar alumno";

            // Limpiar mensajes
            lblError.Text = string.Empty;

            // Reenlazar grilla si hace falta
            BindGrilla();
        }

        // Agregar este método para ordenar
        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sortOption = ddlSort.SelectedValue;
            List<Alumno> ordenados = new List<Alumno>(Alumnos);

            switch (sortOption)
            {
                case "nombre_asc":
                    ordenados = ordenados.OrderBy(a => a.Nombre).ToList();
                    break;
                case "nombre_desc":
                    ordenados = ordenados.OrderByDescending(a => a.Nombre).ToList();
                    break;
                case "matricula_asc":
                    ordenados = ordenados.OrderBy(a => a.Matricula).ToList();
                    break;
                case "matricula_desc":
                    ordenados = ordenados.OrderByDescending(a => a.Matricula).ToList();
                    break;
                case "total_asc":
                    ordenados = ordenados.OrderBy(a => a.Total).ToList();
                    break;
                case "total_desc":
                    ordenados = ordenados.OrderByDescending(a => a.Total).ToList();
                    break;
                case "materia_asc":
                    ordenados = ordenados.OrderBy(a => a.Materia).ToList();
                    break;
            }

            AlumnosOrdenados = ordenados;
            BindGrilla(ordenados);
            ActualizarEstadisticas();
        }

        // Helper para CSV: escapado simple
        private string EscapeCsv(string s)
        {
            if (s == null) return "";
            if (s.Contains(",") || s.Contains("\"") || s.Contains("\n"))
            {
                return "\"" + s.Replace("\"", "\"\"") + "\"";
            }
            return s;
        }
    }
}