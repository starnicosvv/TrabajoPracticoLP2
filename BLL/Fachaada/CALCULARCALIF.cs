using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL.DTOO; // Importa tu clase Alumno desde DTO

namespace BLL.Fachaada
{
    //namespace BLL.Fachada
    //{

    //    public static class Calculos
    //    {
    //        // Total numérico
    //        public static double CalcularTotal(double parcial1, double parcial2, double tp, double examenFinal)
    //        {
    //            return parcial1 + parcial2 + tp + examenFinal;
    //        }

    //        // Calificación cualitativa según rangos
    //        public static string CalcularCalificacionFinal(double total)
    //        {
    //            if (total >= 60 && total <= 70) return "2 (Aprobado)";
    //            if (total >= 71 && total <= 81) return "3 (Aprobado)";
    //            if (total >= 82 && total <= 91) return "4 (Aprobado)";
    //            if (total >= 92 && total <= 100) return "5 (Aprobado)";
    //            return "Reprobado";
    //        }

    //        // Estadísticas generales
    //        public static (double mejor, double peor, double promedio, int aprobados, int reprobados) CalcularEstadisticas(List<Alumno> alumnos)
    //        {
    //            if (alumnos == null || alumnos.Count == 0)
    //                return (0, 0, 0, 0, 0);

    //            var totales = alumnos.Select(a => a.Total).ToList();
    //            int aprobados = alumnos.Count(a => a.CalificacionFinal != "Reprobado");
    //            int reprobados = alumnos.Count - aprobados;

    //            return (totales.Max(), totales.Min(), totales.Average(), aprobados, reprobados);
    //        }
    //    }

    // Clase Alumno compartida
    //public class Alumno
    //{
    //    public string Nombre { get; set; }
    //    public string Materia { get; set; }
    //    public string Matricula { get; set; }
    //    public double Parcial1 { get; set; }
    //    public double Parcial2 { get; set; }
    //    public double TP { get; set; }
    //    public double ExamenFinal { get; set; }
    //    public double Total { get; set; }
    //    public string CalificacionFinal { get; set; }
    //}



    public static class Calculos
    {
        public static double CalcularTotal(double parcial1, double parcial2, double tp, double examenFinal)
        {
            return parcial1 + parcial2 + tp + examenFinal;
        }

        public static string CalcularCalificacionFinal(double total)
        {
            if (total >= 60 && total <= 70) return "2 (Aprobado)";
            if (total >= 71 && total <= 81) return "3 (Aprobado)";
            if (total >= 82 && total <= 91) return "4 (Aprobado)";
            if (total >= 92 && total <= 100) return "5 (Aprobado)";
            return "Reprobado";
        }

        public static (double mejor, List<string> mejoresNombres,
                       double peor, List<string> peoresNombres,
                       double promedio, int aprobados, int reprobados)
            CalcularEstadisticas(List<Alumno> alumnos)
        {
            if (alumnos == null || alumnos.Count == 0)
                return (0, new List<string>(), 0, new List<string>(), 0, 0, 0);

            var totales = alumnos.Select(a => a.Total).ToList();
            double mejor = totales.Max();
            double peor = totales.Min();
            double promedio = totales.Average();

            var mejoresNombres = alumnos.Where(a => a.Total == mejor).Select(a => a.Nombre).ToList();
            var peoresNombres = alumnos.Where(a => a.Total == peor).Select(a => a.Nombre).ToList();

            int aprobados = alumnos.Count(a => a.CalificacionFinal != "Reprobado");
            int reprobados = alumnos.Count - aprobados;

            return (mejor, mejoresNombres, peor, peoresNombres, promedio, aprobados, reprobados);
        }
    }

    //public class Alumno
    //{
    //    public string Nombre { get; set; }
    //    public string Materia { get; set; }
    //    public string Matricula { get; set; }
    //    public double Parcial1 { get; set; }
    //    public double Parcial2 { get; set; }
    //    public double TP { get; set; }
    //    public double ExamenFinal { get; set; }
    //    public double Total { get; set; }
    //    public string CalificacionFinal { get; set; }
}



