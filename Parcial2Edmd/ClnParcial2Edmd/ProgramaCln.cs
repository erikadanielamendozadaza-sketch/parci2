using CadParcial2Edmd;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClnParcial2Edmd
{
    public class ProgramaCln
    {
        public static int insertar(Programa programa)
        {
            using (var context = new Parcial2EdmdEntities())
            { 
                context.Programa.Add(programa);
                context.SaveChanges();
                return programa.id;
            }
        }

        public static int actualizar(Programa programa)
        {
            using (var context = new Parcial2EdmdEntities())
            {
                var existe = context.Programa.Find(programa.id);
                existe.idCanal = programa.idCanal;
                existe.titulo = programa.titulo;
                existe.descripcion = programa.descripcion;
                existe.duracion = programa.duracion;
                existe.productor = programa.productor;
                existe.fechaEstreno = programa.fechaEstreno;
                existe.estado = programa.estado;
                existe.tipo = programa.tipo;
                return context.SaveChanges();
            }
        }

        public static int eliminar(int id)
        {
            using (var context = new Parcial2EdmdEntities())
            {
                var existe = context.Programa.Find(id);
                existe.estado = -1;
                return context.SaveChanges();
            }
        }
        public static Programa obtenerUno(int id)
        {
            using (var context = new Parcial2EdmdEntities())
            {
                return context.Programa.Find(id);
            }
        }
        public static List<Programa> listar()
        {
            using (var context = new Parcial2EdmdEntities())
            {
                return context.Programa.Where(x => x.estado != -1).ToList();
            }
        }

        public static List<paProgramaListar_Result> listarPa(string parametro)
        {
            using (var context = new Parcial2EdmdEntities())
            {
                return context.paProgramaListar(parametro).ToList();
            }
        }
    }
}
