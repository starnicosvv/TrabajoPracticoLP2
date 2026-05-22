using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.DTOO
{ 
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

            // Total = suma de todos los componentes
            public double Total {  get; set; }
            public string CalificacionFinal { get; set; }
    }
    
}
