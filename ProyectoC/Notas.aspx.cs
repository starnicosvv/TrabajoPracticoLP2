//using BLL.Fachaada;
//using BLL.DTOO; // Importa tu capa lógica
//using System;
//using System.Collections.Generic;

//namespace ProyectoC
//{
//    public partial class Notas : System.Web.UI.Page
//    {
//        private List<Alumno> Alumnos
//        {
//            get
//            {
//                if (Session["Alumnos"] == null)
//                    Session["Alumnos"] = new List<Alumno>();
//                return (List<Alumno>)Session["Alumnos"];
//            }
//            set { Session["Alumnos"] = value; }
//        }

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                gvNotas.DataSource = Alumnos;
//                gvNotas.DataBind();
//                ActualizarEstadisticas();
//            }
//        }

//        protected void btnAgregar_Click(object sender, EventArgs e)
//        {
//            lblError.Text = "";

//            try
//            {
//                double p1 = double.Parse(txtParcial1.Text);
//                double p2 = double.Parse(txtParcial2.Text);
//                double tp = double.Parse(txtTP.Text);
//                double ex = double.Parse(txtExamenFinal.Text);

//                if (p1 < 0 || p1 > 20 || p2 < 0 || p2 > 20 || tp < 0 || tp > 10 || ex < 0 || ex > 50)
//                {
//                    lblError.Text = "⚠️ Error: Los valores ingresados superan los límites permitidos.";
//                    return;
//                }

//                double total = Calculos.CalcularTotal(p1, p2, tp, ex);
//                string calificacionFinal = Calculos.CalcularCalificacionFinal(total);

//                var alumno = new Alumno
//                {
//                    Nombre = txtNombre.Text,
//                    Materia = ddlMateria.SelectedValue,
//                    Matricula = txtMatricula.Text,
//                    Parcial1 = p1,
//                    Parcial2 = p2,
//                    TP = tp,
//                    ExamenFinal = ex,
//                    Total = total,
//                    CalificacionFinal = calificacionFinal
//                };

//                Alumnos.Add(alumno);

//                gvNotas.DataSource = Alumnos;
//                gvNotas.DataBind();

//                ActualizarEstadisticas();

//                txtNombre.Text = txtMatricula.Text = txtParcial1.Text = txtParcial2.Text = txtTP.Text = txtExamenFinal.Text = "";
//            }
//            catch
//            {
//                lblError.Text = "⚠️ Error: Verifica que los datos sean numéricos y correctos.";
//            }
//        }

//        private void ActualizarEstadisticas()
//        {
//            if (Alumnos.Count > 0)
//            {
//                var (mejor, peor, promedio, aprobados, reprobados) = Calculos.CalcularEstadisticas(Alumnos);

//                lblMejor.Text = $"Mejor calificación: {mejor}";
//                lblPeor.Text = $"Peor calificación: {peor}";
//                lblPromedio.Text = $"Promedio del curso: {promedio:F2}";
//                lblAprobados.Text = $"Cantidad de aprobados: {aprobados}";
//                lblReprobados.Text = $"Cantidad de reprobados: {reprobados}";
//            }
//            else
//            {
//                lblMejor.Text = "Mejor calificación: -";
//                lblPeor.Text = "Peor calificación: -";
//                lblPromedio.Text = "Promedio del curso: -";
//                lblAprobados.Text = "Cantidad de aprobados: -";
//                lblReprobados.Text = "Cantidad de reprobados: -";
//            }
//        }
//    }
//}

using BLL.DTOO; // Importa tu capa lógica
using BLL.Fachaada;
using ProyectoC;
using System;
using System.Collections.Generic;
using static System.Net.WebRequestMethods;

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

            try
            {
                double p1 = double.Parse(txtParcial1.Text);
                double p2 = double.Parse(txtParcial2.Text);
                double tp = double.Parse(txtTP.Text);
                double ex = double.Parse(txtExamenFinal.Text);

                if (p1 < 0 || p1 > 20 || p2 < 0 || p2 > 20 || tp < 0 || tp > 10 || ex < 0 || ex > 50)
                {
                    lblError.Text = "⚠️ Error: Los valores ingresados superan los límites permitidos.";
                    return;
                }

                double total = Calculos.CalcularTotal(p1, p2, tp, ex);
                string calificacionFinal = Calculos.CalcularCalificacionFinal(total);

                var alumno = new Alumno
                {
                    Nombre = txtNombre.Text,
                    Materia = ddlMateria.SelectedValue,
                    Matricula = txtMatricula.Text,
                    Parcial1 = p1,
                    Parcial2 = p2,
                    TP = tp,
                    ExamenFinal = ex,
                    Total = total,
                    CalificacionFinal = calificacionFinal
                };

                Alumnos.Add(alumno);

                gvNotas.DataSource = Alumnos;
                gvNotas.DataBind();

                ActualizarEstadisticas();

                txtNombre.Text = txtMatricula.Text = txtParcial1.Text = txtParcial2.Text = txtTP.Text = txtExamenFinal.Text = "";
            }
            catch
            {
                lblError.Text = "⚠️ Error: Verifica que los datos sean numéricos y correctos.";
            }
        }

        private void ActualizarEstadisticas()
        {
            if (Alumnos.Count > 0)
            {
                var (mejor, mejoresNombres, peor, peoresNombres, promedio, aprobados, reprobados) = Calculos.CalcularEstadisticas(Alumnos);

                lblMejor.Text = $"Mejor calificación: {mejor} ({string.Join(", ", mejoresNombres)})";
                lblPeor.Text = $"Peor calificación: {peor} ({string.Join(", ", peoresNombres)})";
                lblPromedio.Text = $"Promedio del curso: {promedio:F2}";
                lblAprobados.Text = $"Cantidad de aprobados: {aprobados}";
                lblReprobados.Text = $"Cantidad de reprobados: {reprobados}";
            }
            else
            {
                lblMejor.Text = "Mejor calificación: -";
                lblPeor.Text = "Peor calificación: -";
                lblPromedio.Text = "Promedio del curso: -";
                lblAprobados.Text = "Cantidad de aprobados: -";
                lblReprobados.Text = "Cantidad de reprobados: -";
            }
        }

        // Evento para eliminar fila
        protected void gvNotas_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            Alumnos.RemoveAt(e.RowIndex);
            gvNotas.DataSource = Alumnos;
            gvNotas.DataBind();
            ActualizarEstadisticas();
        }

        // Evento para editar fila
        protected void gvNotas_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            gvNotas.EditIndex = e.NewEditIndex;
            gvNotas.DataSource = Alumnos;
            gvNotas.DataBind();
        }

        protected void gvNotas_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            var row = gvNotas.Rows[e.RowIndex];
            var alumno = Alumnos[e.RowIndex];

            alumno.Nombre = ((System.Web.UI.WebControls.TextBox)row.Cells[0].Controls[0]).Text;
            alumno.Materia = ((System.Web.UI.WebControls.TextBox)row.Cells[1].Controls[0]).Text;
            alumno.Matricula = ((System.Web.UI.WebControls.TextBox)row.Cells[2].Controls[0]).Text;
            alumno.Parcial1 = double.Parse(((System.Web.UI.WebControls.TextBox)row.Cells[3].Controls[0]).Text);
            alumno.Parcial2 = double.Parse(((System.Web.UI.WebControls.TextBox)row.Cells[4].Controls[0]).Text);
            alumno.TP = double.Parse(((System.Web.UI.WebControls.TextBox)row.Cells[5].Controls[0]).Text);
            alumno.ExamenFinal = double.Parse(((System.Web.UI.WebControls.TextBox)row.Cells[6].Controls[0]).Text);

            alumno.Total = Calculos.CalcularTotal(alumno.Parcial1, alumno.Parcial2, alumno.TP, alumno.ExamenFinal);
            alumno.CalificacionFinal = Calculos.CalcularCalificacionFinal(alumno.Total);

            gvNotas.EditIndex = -1;
            gvNotas.DataSource = Alumnos;
            gvNotas.DataBind();
            ActualizarEstadisticas();
        }

        protected void gvNotas_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            gvNotas.EditIndex = -1;
            gvNotas.DataSource = Alumnos;
            gvNotas.DataBind();
        }
    }
}